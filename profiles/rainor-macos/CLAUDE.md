Always respond in Chinese-simplified

# Claude 项目交接与版本管理规范

当任务涉及软件项目、仓库、代码修改、排障或较长期开发时，默认执行以下协作协议，帮助后续 Claude、Codex、其他 AI 或未来会话无缝接手。

## 1. Claude 启动与规则读取
- 先阅读当前目录及上级目录中的 `CLAUDE.md`、`.claude/CLAUDE.md`、`CLAUDE.local.md`，再阅读项目内的 `AGENTS.md`、`README`、关键文档和 `.ai/` 协作目录。
- 如果项目已有 `AGENTS.md` 但没有 `CLAUDE.md`，且本次需要建立项目级 AI 协作规则，可创建项目根目录 `CLAUDE.md`，内容优先使用 `@AGENTS.md` 导入，再补充 Claude 专用规则。
- `CLAUDE.md` 用来放稳定规则；一次性发现、调试结论和接手状态优先写入 `.ai/`，不要把全量开发日志塞进 `CLAUDE.md`。

## 2. 跨 AI 协作目录：`.ai/`
- 项目根目录可以维护 `.ai/`，作为 Claude、Codex 和其他 AI 的公共工作台。
- `.ai/` 存放接手状态、交接留言、决策记录和待办；`CLAUDE.md`/`AGENTS.md` 只放稳定规则。
- 若项目已有 `.ai/`，开始工作前先读 `.ai/README.md`、`.ai/context.md`、`.ai/handoff.md`，必要时再读 `.ai/log.md`、`.ai/decisions.md`、`.ai/tasks.md`、`.ai/inbox.md`。
- 若项目还没有 `.ai/`，且本次是非平凡开发/修复/排障任务，可以创建最小结构；若只是回答问题、运行简单命令或一次性小改，不强制创建。
- 若项目已有旧版 `AI_CONTEXT.md`，先读取它；后续优先把状态迁移或同步到 `.ai/context.md`，也可以让 `AI_CONTEXT.md` 只保留指向 `.ai/context.md` 的说明。

推荐结构：

```text
.ai/
  README.md       # 协作目录说明和读写规则
  context.md      # 当前项目状态、架构速览、运行方式
  handoff.md      # 最近一次交接摘要，下一位 AI 优先读
  log.md          # 简短开发日志，按时间追加
  decisions.md    # 重要技术决策，ADR-lite
  tasks.md        # AI 可继续推进的待办
  inbox.md        # Claude/Codex 之间的留言、问题、回复
```

## 3. 先同步事实，再开始开发
- 先定位项目根目录：优先使用 `git rev-parse --show-toplevel`，失败时使用当前工作目录。
- 若处于 Git 仓库，先查看 `git status --short`，必要时查看最近提交和相关 diff。Git 是事实来源，不用开发日志替代 Git。
- 开始修改前确认是否已有 `.ai/` 或旧版 `AI_CONTEXT.md`；若存在，先读取并用当前代码、测试和 Git 状态校正它。
- 若 `.ai/` 文档与代码冲突，以代码、测试和 Git 历史为准，并顺手修正文档。

## 4. `.ai/` 的写入原则
- `.ai/context.md` 记录长期状态：项目阶段、当前目标、核心架构、运行/测试方式、重要约束。
- `.ai/handoff.md` 记录最近一次交接：本次完成了什么、改了哪些文件、验证了什么、下一步做什么。
- `.ai/log.md` 只追加高信号开发日志：时间、作者、变更摘要、验证结果。不要写成完整命令流水账。
- `.ai/decisions.md` 记录重要决策：背景、决策、影响、回滚条件。
- `.ai/tasks.md` 记录可接手任务：状态、优先级、阻塞点、相关文件。
- `.ai/inbox.md` 用于 AI 之间异步留言：问题、假设、需要对方确认的事项。
- 不要写入 API key、token、密码、私密路径细节等敏感信息；必要时用 `<redacted>`。
- 如果用户明确要求不要更新文档或日志，优先遵从用户请求。

## 5. 每次完成后的归档规则
- 只要完成了代码修改、架构调整、依赖变更、重要排障结论或用户明确要求记录，就更新 `.ai/context.md` 或 `.ai/handoff.md`。
- 记录本次改动涉及的文件、核心意图、验证命令与结果、遗留问题。
- 保持日志可读：必要时合并旧条目，避免无限膨胀；细节以 Git diff/commit 为准。
- 如果进行了 Git 提交、打标签、发布或切分支，必须在 `.ai/handoff.md` 或 `.ai/log.md` 中写明；但不要在未经用户要求时主动提交。

## 6. 面向接手 AI 的工作习惯
- 接手时先读 `.ai/handoff.md`，再读 `.ai/context.md`、Git 状态和相关源码，以当前仓库事实校正文档。
- 不要回滚用户或其他 AI 的未说明改动；遇到无关改动只避开，遇到相关改动先理解再继续。
- 最终回复中简短说明是否更新了 `.ai/`，以及验证过什么。
