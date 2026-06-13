<#
.SYNOPSIS
  把 AI_RULES 的平台规则与 .ai/ 模板安装到目标项目（Windows / PowerShell）。
  行为与 scripts/install-project-rules.sh 对齐：已存在的文件/目录跳过，不覆盖。
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

function Install-File($src, $dst) {
    if (Test-Path -LiteralPath $dst) {
        Write-Host "skip existing $dst"
    } else {
        Copy-Item -LiteralPath $src -Destination $dst
        Write-Host "installed $dst"
    }
}

# 1) 安装 .ai/ 模板（已存在则跳过）
$aiDest = Join-Path $ProjectDir '.ai'
if (Test-Path -LiteralPath $aiDest) {
    Write-Host "skip existing $aiDest"
} else {
    Copy-Item -LiteralPath (Join-Path $RepoDir 'templates\project\.ai') -Destination $aiDest -Recurse
    Write-Host "installed $aiDest"
}

# 2) 安装平台入口文件
$map = @{
    codex  = @{ src = 'platforms\codex\AGENTS.md';   dst = 'AGENTS.md' }
    claude = @{ src = 'platforms\claude\CLAUDE.md';   dst = 'CLAUDE.md' }
    gemini = @{ src = 'platforms\gemini\GEMINI.md';   dst = 'GEMINI.md' }
}
foreach ($t in $Targets) {
    Install-File (Join-Path $RepoDir $map[$t].src) (Join-Path $ProjectDir $map[$t].dst)
}
