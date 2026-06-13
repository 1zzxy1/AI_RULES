# AI Handoff

## 最近一次交接

- 时间：2026-06-14
- 作者：Claude Code (Windows)
- 当前任务：用 agent 集群交叉分析本机 Claude/Codex/Gemini 提示词，把可通用的增量融入 AI_RULES，并准备让仓库成为每台机器的全局提示词来源。
- 状态：5 条放行规则 + 3 个冲突裁决已落地 RULES.md 与 4 个平台副本；全局安装脚本待建（用户选择「先建脚本暂不安装」）。

## 本次完成

- 用工作流（19 挖掘 + 7 盘点 + 合成 + 守门 + 提案，共 43 个 agent）分析了 `~/.claude`、`~/.claude_backup`、`~/.codex`、`~/.gemini` 等处的提示词。
- 守门人从 15 候选放行 5 条，已并入 RULES.md（极简优先，能并入就不另起条目）：
  - c7 → 第一部分第 2 条「遵循现有风格」补「先看相似实现、复用既有库、无理由不引入新工具」。
  - c8+c9 → 第一部分第 2 条新增「引用前核实、交付前自检」反幻觉条目。
  - c1+c2 → 第二部分新增「10. 汇报与计划纪律」（结论先行、计划门禁）。
- 按用户裁决处理 3 个冲突：
  - 注释语言：由「保持英文」改为「跟随代码库已有语言（无先例默认英文）」。
  - 提交策略：确认「每次改动即提交」为权威，删除 codex/AGENTS.md 与 generic/AI_PROMPT.md 里矛盾的「未经用户要求不主动提交」，并同步去掉 RULES.md 第 9 条的同款矛盾表述。
  - 既有文档：「不主动生成文档」细化为「不新建，但改动影响到的既有文档/注释同步更新」。
- 4 个平台副本（claude/codex/gemini/generic）全部同步上述改动。

## 涉及文件

- `RULES.md`
- `platforms/{claude,codex,gemini,generic}/*`
- `CHANGELOG.md`、`.ai/{handoff,log,decisions}.md`

## 验证结果

- 交叉分析工作流完成：43 个 agent、约 193 万 tokens、208 次工具调用。
- 规则改动均为文本编辑，已逐条核对 4 个平台副本与 RULES.md 在「编码原则」「协作协议」两段语义一致。

## 下一步建议

- 落地全局安装脚本 `scripts/install-global-rules.{ps1,sh}`：把 platforms/* 装到 `~/.claude/CLAUDE.md`、`~/.codex/AGENTS.md`、`~/.gemini/GEMINI.md`（覆盖式 + 时间戳备份，区别于项目级 skip-existing），支持 `-Targets`/`-Profile`/`-DryRun`，并写进 README「全局安装」。
- 用户已选「先建脚本暂不安装」——脚本建好后由用户自行在各机器执行。
- 机器差异（Windows 路径偏好、本机特有工具）用 `profiles/<machine>/` 片段隔离，避免污染通用核心。
