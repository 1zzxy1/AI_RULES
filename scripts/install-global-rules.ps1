<#
.SYNOPSIS
  把 AI_RULES 规则装成本机【全局】提示词（Windows / PowerShell）。
.DESCRIPTION
  落盘文件 = 平台入口适配 + RULES.md 核心（+ 可选 profile 片段），即【自包含】，
  不依赖安装目录里另有 RULES.md。覆盖式同步（区别于项目级脚本的 skip-existing）：
  每次覆盖目标，覆盖前把旧文件备份为 *.bak.<时间戳>。
  映射：
    platforms\claude\CLAUDE.md (+RULES.md) -> $env:USERPROFILE\.claude\CLAUDE.md
    platforms\codex\AGENTS.md  (+RULES.md) -> $env:USERPROFILE\.codex\AGENTS.md
    platforms\gemini\GEMINI.md (+RULES.md) -> $env:USERPROFILE\.gemini\GEMINI.md
.PARAMETER Targets
  claude / codex / gemini，可多选；省略则三者全装。
.PARAMETER Profile
  profiles\<name> 名称；指定则在核心后追加该 profile 的个性化片段（如 rainor-opinionated）。
.PARAMETER DryRun
  只打印将执行的操作，不落盘。
.EXAMPLE
  .\install-global-rules.ps1                              # 三平台全装核心
  .\install-global-rules.ps1 -Targets claude             # 只装 Claude
  .\install-global-rules.ps1 -Profile rainor-opinionated # 核心 + 个人偏好
  .\install-global-rules.ps1 -DryRun                     # 预演不落盘
#>
[CmdletBinding()]
param(
    [ValidateSet('claude', 'codex', 'gemini')]
    [string[]]$Targets = @('claude', 'codex', 'gemini'),
    [string]$Profile,
    [switch]$DryRun
)

$ErrorActionPreference = 'Stop'
$RepoDir = Split-Path -Parent $PSScriptRoot
$HomeDir = $env:USERPROFILE
$stamp = Get-Date -Format 'yyyyMMdd-HHmmss'

# 统一用无 BOM 的 UTF-8 读写，避免中文 Windows(PS 5.1) 把无 BOM 源按 GBK 误读成乱码
$utf8 = New-Object System.Text.UTF8Encoding($false)
function Read-Utf8($p) { [System.IO.File]::ReadAllText($p, $utf8) }
function Write-Utf8($p, $c) { [System.IO.File]::WriteAllText($p, $c, $utf8) }

$rules = Read-Utf8 (Join-Path $RepoDir 'RULES.md')

$map = @{
    claude = @{ src = 'platforms\claude\CLAUDE.md'; dst = (Join-Path $HomeDir '.claude\CLAUDE.md'); prof = 'CLAUDE.md' }
    codex  = @{ src = 'platforms\codex\AGENTS.md';  dst = (Join-Path $HomeDir '.codex\AGENTS.md');  prof = 'AGENTS.md' }
    gemini = @{ src = 'platforms\gemini\GEMINI.md'; dst = (Join-Path $HomeDir '.gemini\GEMINI.md'); prof = 'GEMINI.md' }
}

foreach ($t in $Targets) {
    $dst = $map[$t].dst
    $dstDir = Split-Path -Parent $dst

    $content = (Read-Utf8 (Join-Path $RepoDir $map[$t].src)) +
        "`r`n`r`n---`r`n`r`n# 通用核心规则（来自 AI_RULES / RULES.md）`r`n`r`n" + $rules

    $note = '核心'
    if ($Profile) {
        $pf = Join-Path $RepoDir ('profiles\' + $Profile + '\' + $map[$t].prof)
        if (Test-Path -LiteralPath $pf) {
            $content += "`r`n`r`n---`r`n`r`n# 个人偏好（profile: $Profile）`r`n`r`n" + (Read-Utf8 $pf)
            $note = "核心 + profile:$Profile"
        } else {
            Write-Host "（profile '$Profile' 无 $($map[$t].prof)，$t 仅装核心）"
        }
    }

    if ($DryRun) {
        Write-Host "[dry-run] $t -> $dst（$note，$($content.Length) 字符）"
        continue
    }

    if (-not (Test-Path -LiteralPath $dstDir)) { New-Item -ItemType Directory -Force -Path $dstDir | Out-Null }
    if (Test-Path -LiteralPath $dst) {
        Copy-Item -LiteralPath $dst -Destination "$dst.bak.$stamp"
        Write-Host "备份 $dst -> $dst.bak.$stamp"
    }
    Write-Utf8 $dst $content
    Write-Host "安装 $dst（$note）"
}

Write-Host "`n完成。规则更新流程：改 RULES.md -> 同步 platforms\ -> 各机器重跑本脚本拉取。" -ForegroundColor Green
