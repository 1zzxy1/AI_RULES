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

## 全局安装脚本（已完成）

- 已建 `scripts/install-global-rules.ps1`（Windows）与 `.sh`（macOS/Linux）：覆盖式同步 + `*.bak.<时间戳>` 备份，支持 `-Targets`/`-Profile`/`-DryRun`；已在临时 HOME 冒烟测试（备份、安装三处、profile 片段追加、缺失片段跳过均正确）。
- 修复 `.ps1` UTF-8 BOM 问题（PowerShell 5.1 否则按 GBK 解析中文报错）；旧 `install-project-rules.ps1` 一并加 BOM。
- README、docs/adoption.md 已加「全局安装」章节。

## 下一步建议

- 用户已选「先建脚本暂不安装」——各机器自行 `git pull` 后跑 `install-global-rules`（首次建议先 `-DryRun`）。
- 机器差异（Windows 路径偏好、本机特有工具）建议沉淀到 `profiles/<machine>/`（如 `profiles/xu-windows/`），再用 `-Profile` 追加。
- 后续平台 AI 迭代仍走「先改 RULES.md → 同步 platforms → 记 CHANGELOG → 更新 `.ai/`」。
