Always respond in Chinese-simplified

# Claude 项目交接与版本管理规范

遵循本项目的 AI 协作协议：

- 先阅读当前目录及上级目录中的 `CLAUDE.md`、`.claude/CLAUDE.md`、`CLAUDE.local.md`，再阅读项目内的 `AGENTS.md`、`GEMINI.md`、`README`、关键文档和 `.ai/`。
- 如果项目已有 `AGENTS.md` 但没有 `CLAUDE.md`，且本次需要建立项目级 AI 协作规则，可创建项目根目录 `CLAUDE.md`，内容优先使用 `@AGENTS.md` 导入，再补充 Claude 专用规则。
- 非平凡开发/修复/排障任务开始前，先读取 `.ai/README.md`、`.ai/handoff.md`、`.ai/context.md`。
- Git、代码和测试是事实来源，`.ai/` 是交接摘要。
- `CLAUDE.md` 只放稳定规则；一次性发现、调试结论和接手状态优先写入 `.ai/`。
- 完成代码修改、架构调整、依赖变更或重要排障结论后，更新 `.ai/handoff.md`，必要时更新 `.ai/context.md`、`.ai/log.md`、`.ai/tasks.md`、`.ai/decisions.md` 或 `.ai/inbox.md`。
- 不要把 API key、token、密码等敏感信息写进规则或 `.ai/`。
- 不要未经用户要求主动提交；若用户要求提交，提交后在 `.ai/handoff.md` 或 `.ai/log.md` 记录提交信息。
- 最终回复中简短说明是否更新了 `.ai/`，以及验证过什么。
