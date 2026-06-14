# AI Handoff

## 最近一次交接

- 时间：2026-06-15
- 作者：Codex (macOS)
- 当前任务：读取并对比 `Mapotofsky/prompt-optimizer`，把适合 Claude/Codex 共用的提示词优化原则提炼进 AI_RULES。
- 状态：规则与文档已更新并验证，待提交和推送。

## 外部仓库读取

- 仓库：`https://github.com/Mapotofsky/prompt-optimizer`
- 读取版本：`9f28074 更新 SKILL.md 中的描述`
- 读取文件：`SKILL.md`、`README.md`、`references/examples.md`、`references/interview-bank.md`

## 对比结论

`prompt-optimizer` 本质是用户提示词优化 skill，不是项目开发系统提示词。它的完整模式 A/B/C、示例库和提问库太长，不适合整段并入 AI_RULES 核心；但它的“降低模型对用户意图的不确定性”方法论适合提炼成短规则。

## 本次采纳

- `RULES.md` 在“系统提示词与用户提示词分工”下新增用户提示词质量准则：
  - 用 `Context × Task × Format` 补齐背景/受众/目的、动作/范围/成功标准、输出形态/长度/示例。
  - 需求模糊时一次只问最关键的 2-3 个问题。
  - 能合理默认的细节用“假设”标注。
  - 多段输入用 Markdown、代码块或 XML 风格标签划清边界。
  - 长对话或补丁式修正污染上下文时，整理源提示词和当前事实后再继续。
- `docs/system-vs-user-prompts.md` 增加“用户提示词怎么写”。
- 新增 `docs/prompt-optimizer-comparison.md`，记录采纳和未采纳理由。
- README、adoption、CHANGELOG、`.ai/context.md`、`.ai/log.md`、`.ai/decisions.md` 同步更新。

## 未采纳

- 未把 `prompt-optimizer` 的完整流程、案例、热力图、提问库并入核心。
- 未把 Chain-of-Thought、Self-Consistency、prefilling 等具体技巧设为跨平台硬规则。
- 未加入多智能体编排规则；这类内容更适合未来 profile 或 skill。

## 验证结果

- `git diff --check` 通过。
- `./scripts/install-global-rules.sh --dry-run --profile rainor-opinionated` 通过。
- 临时 `HOME` 全局安装后，Claude/Codex/Gemini 落盘文件均含 `Context、Task、Format`、关键提问和结构边界规则，并含 `rainor-opinionated` profile。
- 临时项目安装后，项目 `AGENTS.md`、`CLAUDE.md` 均含新规则。
