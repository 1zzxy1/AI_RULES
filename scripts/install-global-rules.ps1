<#
.SYNOPSIS
  把 AI_RULES 的平台规则装成本机【全局】提示词（Windows / PowerShell）。
.DESCRIPTION
  覆盖式同步（区别于项目级脚本的 skip-existing）：全局规则需随仓库持续更新，
  所以每次都覆盖目标，并在覆盖前把旧文件备份为 *.bak.<时间戳>。
  映射：
    platforms\claude\CLAUDE.md -> $env:USERPROFILE\.claude\CLAUDE.md
    platforms\codex\AGENTS.md  -> $env:USERPROFILE\.codex\AGENTS.md
    platforms\gemini\GEMINI.md -> $env:USERPROFILE\.gemini\GEMINI.md
.PARAMETER Targets
  claude / codex / gemini，可多选；省略则三者全装。
.PARAMETER Profile
  profiles\<machine> 名称；指定则在通用核心后追加该机器的个性化片段（不污染核心）。
.PARAMETER DryRun
  只打印将执行的操作，不落盘。
.EXAMPLE
  .\install-global-rules.ps1                      # 三平台全装通用核心
  .\install-global-rules.ps1 -Targets claude      # 只装 Claude 全局规则
  .\install-global-rules.ps1 -Profile xu-windows  # 通用核心 + 本机片段
  .\install-global-rules.ps1 -DryRun              # 预演不落盘
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

$map = @{
    claude = @{ src = 'platforms\claude\CLAUDE.md'; dst = (Join-Path $HomeDir '.claude\CLAUDE.md'); prof = 'CLAUDE.md' }
    codex  = @{ src = 'platforms\codex\AGENTS.md';  dst = (Join-Path $HomeDir '.codex\AGENTS.md');  prof = 'AGENTS.md' }
    gemini = @{ src = 'platforms\gemini\GEMINI.md'; dst = (Join-Path $HomeDir '.gemini\GEMINI.md'); prof = 'GEMINI.md' }
}

foreach ($t in $Targets) {
    $src = Join-Path $RepoDir $map[$t].src
    $dst = $map[$t].dst
    $dstDir = Split-Path -Parent $dst

    $useProfile = $false
    $profFrag = $null
    if ($Profile) {
        $pf = Join-Path $RepoDir ('profiles\' + $Profile + '\' + $map[$t].prof)
        if (Test-Path -LiteralPath $pf) {
            $useProfile = $true
            $profFrag = Get-Content -LiteralPath $pf -Raw
        } else {
            Write-Host "（profile '$Profile' 无 $($map[$t].prof)，$t 仅装通用核心）"
        }
    }

    if ($DryRun) {
        $note = if ($useProfile) { '通用核心 + profile 片段' } else { '通用核心' }
        Write-Host "[dry-run] $t -> $dst（$note）"
        continue
    }

    if (-not (Test-Path -LiteralPath $dstDir)) { New-Item -ItemType Directory -Force -Path $dstDir | Out-Null }
    if (Test-Path -LiteralPath $dst) {
        Copy-Item -LiteralPath $dst -Destination "$dst.bak.$stamp"
        Write-Host "备份 $dst -> $dst.bak.$stamp"
    }
    if ($useProfile) {
        $content = (Get-Content -LiteralPath $src -Raw) + "`r`n`r`n---`r`n# 本机个性化（profile: $Profile）`r`n`r`n" + $profFrag
        Set-Content -LiteralPath $dst -Value $content -Encoding utf8
    } else {
        Copy-Item -LiteralPath $src -Destination $dst
    }
    Write-Host "安装 $dst"
}

Write-Host "`n完成。规则更新流程：改 RULES.md -> 同步 platforms\ -> 各机器重跑本脚本拉取。" -ForegroundColor Green
