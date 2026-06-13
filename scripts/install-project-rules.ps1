<#
.SYNOPSIS
  把 AI_RULES 的规则与 .ai/ 模板安装到目标项目（Windows / PowerShell）。
  落盘的平台文件 = 平台入口适配 + RULES.md 核心（【自包含】，项目内无需另有 RULES.md）。
  已存在的文件/目录跳过，不覆盖（与 install-project-rules.sh 对齐）。
.PARAMETER ProjectDir
  目标项目根目录（必填）。
.PARAMETER Targets
  要安装的平台，可多选：codex / claude / gemini。省略则三者都装。
.EXAMPLE
  .\install-project-rules.ps1 -ProjectDir D:\work\my-project
.EXAMPLE
  .\install-project-rules.ps1 -ProjectDir . -Targets claude,gemini
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$ProjectDir,

    [Parameter(Position = 1, ValueFromRemainingArguments = $true)]
    [ValidateSet('codex', 'claude', 'gemini')]
    [string[]]$Targets = @('codex', 'claude', 'gemini')
)

$ErrorActionPreference = 'Stop'
$RepoDir = Split-Path -Parent $PSScriptRoot

if (-not (Test-Path -LiteralPath $ProjectDir)) {
    throw "Project directory does not exist: $ProjectDir"
}

# 无 BOM UTF-8 读写，避免中文 Windows(PS 5.1) 把无 BOM 源按 GBK 误读成乱码
$utf8 = New-Object System.Text.UTF8Encoding($false)
function Read-Utf8($p) { [System.IO.File]::ReadAllText($p, $utf8) }
$rules = Read-Utf8 (Join-Path $RepoDir 'RULES.md')

# 1) 安装 .ai/ 模板（已存在则跳过）
$aiDest = Join-Path $ProjectDir '.ai'
if (Test-Path -LiteralPath $aiDest) {
    Write-Host "skip existing $aiDest"
} else {
    Copy-Item -LiteralPath (Join-Path $RepoDir 'templates\project\.ai') -Destination $aiDest -Recurse
    Write-Host "installed $aiDest"
}

# 2) 安装平台入口文件（合入 RULES.md 核心，自包含）
$map = @{
    codex  = @{ src = 'platforms\codex\AGENTS.md';   dst = 'AGENTS.md' }
    claude = @{ src = 'platforms\claude\CLAUDE.md';   dst = 'CLAUDE.md' }
    gemini = @{ src = 'platforms\gemini\GEMINI.md';   dst = 'GEMINI.md' }
}
foreach ($t in $Targets) {
    $dst = Join-Path $ProjectDir $map[$t].dst
    if (Test-Path -LiteralPath $dst) {
        Write-Host "skip existing $dst"
        continue
    }
    $content = (Read-Utf8 (Join-Path $RepoDir $map[$t].src)) +
        "`r`n`r`n---`r`n`r`n# 通用核心规则（来自 AI_RULES / RULES.md）`r`n`r`n" + $rules
    [System.IO.File]::WriteAllText($dst, $content, $utf8)
    Write-Host "installed $dst"
}
