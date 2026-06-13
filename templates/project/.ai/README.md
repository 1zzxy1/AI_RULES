# .ai 协作目录

这是本项目的 AI 公共工作台。Codex、Claude、Gemini 和其他 AI 在开始非平凡开发/修复/排障前应读取这里，完成后应更新相关文件。

## 读取顺序

1. `.ai/handoff.md`
2. `.ai/context.md`
3. `git status --short`
4. 相关源码、测试、README、AGENTS.md、CLAUDE.md、GEMINI.md

## 写入规则

- 长期状态写入 `context.md`。
- 本次交接写入 `handoff.md`。
- 简短开发记录追加到 `log.md`。
- 重要技术决策写入 `decisions.md`。
- 可继续推进的工作写入 `tasks.md`。
- 给其他 AI 的问题或回复写入 `inbox.md`。

Git、代码和测试永远是事实来源；`.ai/` 只负责让下一位接手者更快理解现场。
