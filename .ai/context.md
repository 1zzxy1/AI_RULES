# AI Context

## 当前状态

- 项目阶段：规则仓库已成型，正在把系统提示词 / 用户提示词分工沉淀进跨平台核心。
- 当前目标：保持 `RULES.md` 为短核心，平台入口为系统提示词适配，安装时合入核心生成自包含落盘文件；具体任务目标、一次性示例和输出格式留给用户提示词。
- 最近更新时间：2026-06-15
- 远程仓库：https://github.com/1zzxy1/AI_RULES （main）
- 当前分支/工作区状态：`main` 已含蒸馏 + Windows 复审修复；本轮本地修改新增系统/用户提示词分工，待验证、提交、推送。

## 架构速览

- `RULES.md`：唯一权威来源，跨平台最小核心规则；包含系统提示词与用户提示词分工。
- `platforms/`：各 AI 平台系统提示词入口适配（claude/codex/gemini/generic）；安装脚本会合入 `RULES.md` 核心，落盘文件自包含（手动单文件复制需连同 `RULES.md`）。
- `profiles/`：个人偏好与机器差异；`rainor-opinionated` 可追加安装，`rainor-macos` 为历史快照参考。
- `templates/project/.ai/`：复制到具体项目的协作目录模板（context/handoff/log/decisions/tasks/inbox）。
- `scripts/install-project-rules.sh` / `.ps1`：把规则与 `.ai/` 安装到目标项目（Unix / Windows，行为对齐：skip-existing）。
- `docs/adoption.md`：接入与迭代指南；`docs/system-vs-user-prompts.md`：系统/用户提示词分工；`CHANGELOG.md`：跨平台迭代留痕。

## 运行与验证

- 检查 Git：`git status --short`
- Windows 安装：`.\scripts\install-project-rules.ps1 -ProjectDir <目标>`
- Unix 安装：`./scripts/install-project-rules.sh <目标> codex claude gemini`
- 全局推荐先预演再安装：`install-global-rules` + `rainor-opinionated` profile。

## 已知问题与风险

- Gemini 的项目规则文件名在不同工具中可能有差异；当前以 `GEMINI.md` 为通用约定，并用 `generic/AI_PROMPT.md` 兜底（见 tasks.md P1）。
- 平台入口只放平台适配、不重复核心；改规则**先改 `RULES.md`**，再同步入口措辞，安装时由脚本合入核心生成自包含落盘文件，无手工副本漂移。
- 不要把任务级示例、JSON 样例、报告模板或某次排障流水账写进系统提示词核心；这些属于用户提示词或 `.ai/` 项目状态。
- 全局/项目脚本均「合入 RULES.md 核心」；PS 脚本统一用无 BOM UTF-8 读写（避免中文 Windows GBK 误读乱码）。
