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
