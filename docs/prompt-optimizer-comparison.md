# prompt-optimizer 对比记录

## 来源

- 仓库：`https://github.com/Mapotofsky/prompt-optimizer`
- 读取版本：`9f28074 更新 SKILL.md 中的描述`
- 读取文件：`SKILL.md`、`README.md`、`references/examples.md`、`references/interview-bank.md`

## 结论

`prompt-optimizer` 是一套“优化用户提示词”的 skill，不是项目开发系统提示词。它的价值在于降低模型对用户意图的不确定性；适合把方法论提炼进 AI_RULES 的用户提示词边界和使用指南，不适合整段并入系统提示词核心。

## 采纳到核心的内容

- 用户提示词质量用 `Context × Task × Format` 检查：背景/受众/目的，具体动作/范围/成功标准，输出形态/长度/示例。
- 当用户需求模糊时，不直接产出空泛结果，先补齐最关键的 2-3 个缺口。
- 能合理默认的细节用“假设”标注，避免为了小细节反复追问。
- 多段输入用清晰边界分隔；可用 Markdown 标题、代码块或 XML 风格标签。
- 长对话或补丁式修正污染上下文时，整理源提示词、当前事实和目标后再继续。

## 未并入核心的内容

- 模式 A/B/C 的完整流程、热力图、示例库、提问库：太长，适合作为专门 skill 或参考文档。
- Chain-of-Thought / Self-Consistency / prefilling 的具体调用技巧：平台和场景差异较大，不应成为跨平台核心硬规则。
- 多智能体编排建议：属于高级工作流或 profile，不是所有项目都需要。
- 具体 XML 示例和案例：属于任务级示例，放入系统提示词会污染全局上下文。

## 对 AI_RULES 的影响

- `RULES.md` 保持短核心，只增加用户提示词质量的稳定准则。
- `docs/system-vs-user-prompts.md` 增加“用户提示词怎么写”小节，指导 Mac/Windows 两端统一使用。
- 后续若需要完整提示词优化能力，应新建可选 profile 或 skill，而不是继续膨胀 `RULES.md`。
