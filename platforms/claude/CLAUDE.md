# CLAUDE.md — Claude Code 协作入口

始终使用简体中文回复。

本文件派生自 AI_RULES 的 `RULES.md`，可放到项目根目录或 `~/.claude/CLAUDE.md`。核心规则以 `RULES.md` 为准；本文件只保留 Claude Code 入口需要的薄封装。

## 工作前

- 先读当前及上级目录中的 `CLAUDE.md`、`.claude/CLAUDE.md`、`CLAUDE.local.md`，再读项目内 `AGENTS.md`、`GEMINI.md`、README、相关源码和测试。
- 定位项目根目录，先看 `git status --short`。
- 若存在 `.ai/`，按 `.ai/README.md` → `.ai/handoff.md` → `.ai/context.md` 顺序读取。

## 工作中

- `CLAUDE.md` 只放稳定规则；一次性发现、调试结论和接手状态写入 `.ai/`。
- 遵循现有风格，复用已有实现和工具，保持最小变更。
- Git、代码和测试是事实来源；`.ai/` 只做交接摘要。
- 不回滚用户或其他 AI 的未说明改动。
- 删除、覆盖、推送、发布等不可逆或外部操作前确认授权。

## 工作后

- 非平凡修改或重要排障后更新 `.ai/handoff.md`，必要时更新 `.ai/context.md`、`log.md`、`tasks.md`、`decisions.md`、`inbox.md`。
- 最终回复说明改了什么、验证了什么、是否更新 `.ai/`。

完整原则见仓库 `RULES.md`。
