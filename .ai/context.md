# AI Context

## 当前状态

- 项目阶段：初始规则仓库搭建。
- 当前目标：沉淀 Codex、Claude、Gemini 和通用 AI 可复用的交接与版本管理提示词。
- 最近更新时间：2026-06-14
- 当前分支/工作区状态：新建 Git 仓库，准备初始提交。

## 架构速览

- `RULES.md`：跨平台通用规则正文。
- `platforms/`：各 AI 平台入口文件。
- `templates/project/.ai/`：复制到具体项目的协作目录模板。
- `scripts/install-project-rules.sh`：把规则安装到目标项目。
- `docs/adoption.md`：接入说明。

## 运行与验证

- 检查目录：`find . -maxdepth 4 -type f | sort`
- 检查 Git：`git status --short`

## 已知问题与风险

- Gemini 的项目规则文件名在不同工具中可能有差异；当前使用 `GEMINI.md` 作为通用约定，并提供 `generic/AI_PROMPT.md` 兜底。
