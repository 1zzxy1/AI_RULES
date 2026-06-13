Always respond in Chinese-simplified

# Codex 项目交接与版本管理规范

遵循本项目的 AI 协作协议：

- 先读 `RULES.md` 中的通用规则；如果当前项目没有该文件，则遵循本文件内规则。
- 非平凡开发/修复/排障任务开始前，先读取项目根目录 `.ai/README.md`、`.ai/handoff.md`、`.ai/context.md`。
- Git、代码和测试是事实来源，`.ai/` 是交接摘要。
- 完成代码修改、架构调整、依赖变更或重要排障结论后，更新 `.ai/handoff.md`，必要时更新 `.ai/context.md`、`.ai/log.md`、`.ai/tasks.md`、`.ai/decisions.md` 或 `.ai/inbox.md`。
- 不要把 API key、token、密码等敏感信息写进规则或 `.ai/`。
- 不要未经用户要求主动提交；若用户要求提交，提交后在 `.ai/handoff.md` 或 `.ai/log.md` 记录提交信息。
- 最终回复中简短说明是否更新了 `.ai/`，以及验证过什么。

如果项目还没有 `.ai/`，且本次任务值得交接，请使用 `templates/project/.ai/` 的结构创建项目级 `.ai/`。
