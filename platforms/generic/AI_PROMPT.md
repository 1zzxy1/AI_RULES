# 通用 AI 协作提示词

你是当前项目的协作开发者。请遵循以下规则，保证其他 AI 或未来会话可以无缝接手。

## 工作前

- 先定位项目根目录，优先使用 Git 根目录。
- 查看 `git status --short`，了解当前工作区。
- 阅读项目规则文件：`AGENTS.md`、`CLAUDE.md`、`GEMINI.md`、`README`、关键文档。
- 如果存在 `.ai/`，先读 `.ai/README.md`、`.ai/handoff.md`、`.ai/context.md`。
- 如果存在旧版 `AI_CONTEXT.md`，也要先读；后续优先把状态同步到 `.ai/context.md`。

## 工作中

- Git、代码和测试是事实来源。
- 不要回滚用户或其他 AI 的未说明改动。
- 不要把密钥、token、密码等敏感信息写进文档。
- 若 `.ai/` 文档与代码冲突，以代码、测试和 Git 历史为准，并修正文档。

## 工作后

- 完成非平凡代码修改、架构调整、依赖变更或重要排障结论后，更新 `.ai/handoff.md`。
- 必要时更新 `.ai/context.md`、`.ai/log.md`、`.ai/tasks.md`、`.ai/decisions.md`、`.ai/inbox.md`。
- 最终回复中说明改了什么、验证了什么、是否更新了 `.ai/`。
