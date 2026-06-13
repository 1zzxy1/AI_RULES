# AI Context

## 当前状态

- 项目阶段：规则仓库已成型，进入蒸馏与多机复审期。
- 当前目标：保持 `RULES.md` 为短核心，平台入口为薄封装，个人偏好放入 `profiles/`，并支持一键安装到项目或全局。
- 最近更新时间：2026-06-14
- 远程仓库：https://github.com/1zzxy1/AI_RULES （main）
- 当前分支/工作区状态：`distill-core` 分支完成第一轮蒸馏并通过本地验证，待提交、推送。

## 架构速览

- `RULES.md`：唯一权威来源，跨平台最小核心规则。
- `platforms/`：各 AI 平台薄入口文件（claude/codex/gemini/generic），单文件可复制即用。
- `profiles/`：个人偏好与机器差异；`rainor-opinionated` 可追加安装，`rainor-macos` 为历史快照参考。
- `templates/project/.ai/`：复制到具体项目的协作目录模板（context/handoff/log/decisions/tasks/inbox）。
- `scripts/install-project-rules.sh` / `.ps1`：把规则与 `.ai/` 安装到目标项目（Unix / Windows，行为对齐：skip-existing）。
- `docs/adoption.md`：接入与迭代指南；`CHANGELOG.md`：跨平台迭代留痕。

## 运行与验证

- 检查 Git：`git status --short`
- Windows 安装：`.\scripts\install-project-rules.ps1 -ProjectDir <目标>`
- Unix 安装：`./scripts/install-project-rules.sh <目标> codex claude gemini`

## 已知问题与风险

- Gemini 的项目规则文件名在不同工具中可能有差异；当前以 `GEMINI.md` 为通用约定，并用 `generic/AI_PROMPT.md` 兜底（见 tasks.md P1）。
- 平台入口不再重复完整长规则，改规则先改 `RULES.md`，再同步入口摘要，靠 README/adoption/CHANGELOG 的流程约束防漂移。
