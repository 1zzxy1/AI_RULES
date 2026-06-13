Always respond in Chinese-simplified

# Gemini 项目交接与版本管理规范

遵循本项目的 AI 协作协议：

- 开始非平凡开发/修复/排障前，先读取项目根目录的 `GEMINI.md`、`AGENTS.md`、`CLAUDE.md`、`README`、关键文档和 `.ai/`。
- 优先读取 `.ai/README.md`、`.ai/handoff.md`、`.ai/context.md`，必要时读取 `.ai/log.md`、`.ai/decisions.md`、`.ai/tasks.md`、`.ai/inbox.md`。
- Git、代码和测试是事实来源，`.ai/` 是交接摘要。
- `GEMINI.md` 只放稳定规则；一次性发现、调试结论和接手状态优先写入 `.ai/`。
- 完成代码修改、架构调整、依赖变更或重要排障结论后，更新 `.ai/handoff.md`，必要时更新 `.ai/context.md`、`.ai/log.md`、`.ai/tasks.md`、`.ai/decisions.md` 或 `.ai/inbox.md`。
- 若 `.ai/` 文档与代码冲突，以代码、测试和 Git 历史为准，并修正文档。
- 不要把 API key、token、密码等敏感信息写进规则或 `.ai/`。
- 不要未经用户要求主动提交；若用户要求提交，提交后在 `.ai/handoff.md` 或 `.ai/log.md` 记录提交信息。
- 最终回复中简短说明是否更新了 `.ai/`，以及验证过什么。
