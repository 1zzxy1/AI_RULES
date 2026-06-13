# AI Context

## 当前状态

- 项目阶段：规则仓库已成型，进入跨平台迭代期。
- 当前目标：沉淀 Codex、Claude、Gemini 和通用 AI 可复用的「行为规则 + 交接协议」基础提示词，并能一键安装到任意项目。
- 最近更新时间：2026-06-14
- 远程仓库：https://github.com/1zzxy1/AI_RULES （main）
- 当前分支/工作区状态：在 Codex 初版（commit 8560048）之上完成 Claude/Windows 融合迭代，待提交并 push。

## 架构速览

- `RULES.md`：唯一权威来源，两部分——第一部分行为规则、第二部分跨 AI 协作协议。
- `platforms/`：各 AI 平台自包含入口文件（claude/codex/gemini/generic），单文件可复制即用。
- `templates/project/.ai/`：复制到具体项目的协作目录模板（context/handoff/log/decisions/tasks/inbox）。
- `scripts/install-project-rules.sh` / `.ps1`：把规则与 `.ai/` 安装到目标项目（Unix / Windows，行为对齐：skip-existing）。
- `docs/adoption.md`：接入与迭代指南；`CHANGELOG.md`：跨平台迭代留痕。

## 运行与验证

- 检查 Git：`git status --short`
- Windows 安装：`.\scripts\install-project-rules.ps1 -ProjectDir <目标>`
- Unix 安装：`./scripts/install-project-rules.sh <目标> codex claude gemini`

## 已知问题与风险

- Gemini 的项目规则文件名在不同工具中可能有差异；当前以 `GEMINI.md` 为通用约定，并用 `generic/AI_PROMPT.md` 兜底（见 tasks.md P1）。
- 平台副本是 RULES.md 的自包含拷贝，改规则需手动同步多份，靠 README/adoption/CHANGELOG 的流程约束防漂移。
