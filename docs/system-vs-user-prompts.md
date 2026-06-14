# 系统提示词与用户提示词分工

## 结论

AI_RULES 中的 `RULES.md` 和 `platforms/` 下的 Claude、Codex、Gemini、generic 入口属于系统提示词层；用户每一轮输入属于用户提示词层。

## 系统提示词放什么

- 稳定身份：你是项目协作开发者。
- 行为准则：中文回复、先读再改、最小变更、事实核实。
- 能力边界：安全、隐私、Git、不可逆操作确认。
- 长期工作流：`.ai/` 交接、失败处理、跨平台路径。

系统提示词不放具体任务、一次性数据、JSON 样例、报告模板或某一轮才需要的输出格式。

## 用户提示词放什么

- 当前目标：这次要做什么。
- 输入材料：代码片段、错误日志、需求、链接。
- 范围限制：哪些文件可改，哪些不能动。
- 验收标准：如何判断完成。
- 临时输出格式：例如这次需要表格、JSON、PR 描述或邮件草稿。

## 用户提示词怎么写

给当前任务写用户提示词时，优先补齐三件事：

- Context：背景、受众、目的、已有材料。
- Task：具体动作、范围、步骤、成功标准。
- Format：输出类型、结构、长度、示例。

如果需求还很模糊，先补齐最关键的 2-3 个缺口；能合理默认的细节用“假设”标注。多段材料用 Markdown 标题、代码块或 XML 风格标签分隔，避免模型把背景、输入和输出格式混在一起。

长对话中反复追加修正时，优先整理一条新的源提示词：保留当前事实和目标，删除过时上下文，再继续执行。

## Mac / Windows 统一安装

推荐让两台机器都安装同一套系统提示词核心：

```bash
# macOS / Linux
./scripts/install-global-rules.sh --dry-run --profile rainor-opinionated
./scripts/install-global-rules.sh --profile rainor-opinionated
```

```powershell
# Windows / PowerShell
.\scripts\install-global-rules.ps1 -DryRun -Profile rainor-opinionated
.\scripts\install-global-rules.ps1 -Profile rainor-opinionated
```

`rainor-opinionated` 只追加计划门禁和小步提交倾向；不想要更主动的结对节奏时，可以不带 profile。
