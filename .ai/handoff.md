# AI Handoff

## 最近一次交接

- 时间：2026-06-14
- 作者：Claude Code (Windows)
- 当前任务：复审 Codex 在 `distill-core`(1d7ffd6) 的蒸馏是否过度删减，修复后合并回 main。
- 状态：复审 = approve-with-fixes；4 个阻塞项 + 必回规则已修并本地验证，待合并 main 并推送。

## 复审结论（9-agent 对抗式复审）

蒸馏方向正确（114→75 行核心、合并 Git/安全、收敛 .ai/、把计划门禁/小步提交下沉到 profile），但有阻塞项必须修。

## 本次修复

- **落地缺口（最重）**：原薄入口写「完整原则见 RULES.md」，但安装脚本只拷 platforms/* 不拷 RULES.md，装出的 `~/.claude/CLAUDE.md` 仅十几行、指向不存在的 RULES.md。改为 **安装时合入 `RULES.md` 核心**：全局/项目、ps1/sh 四个脚本都把「平台入口适配 + RULES.md 核心(+可选 profile)」拼成自包含落盘文件。
- **补回 4 条跨平台必回核心到 `RULES.md`**：① 中英文加空格 + 中文全角标点；② 涉及远程先 `git remote -v`，无远程主动询问、确认前不擅自创建/推送；③ 交付前不留 `[TODO]`/占位符；④ 结论先行。另补回「数据结构优先」。
- **opinionated profile** 只保留「计划门禁 + 小步提交」（结论先行已回核心）；明确默认不带 profile 时这两条不生效。
- **PowerShell 编码 bug**：`-Profile` 路径原用 `Get-Content -Raw` 读无 BOM UTF-8，在中文 Windows(CP936) 误读成乱码；改为 `[System.IO.File]::ReadAllText/WriteAllText` 无 BOM UTF-8，全局/项目 ps1 统一。
- **文档诚实化**：README/adoption/.ai/context 纠正「可单独复制使用」为「入口适配，安装时合入核心；手动复制需连同 RULES.md」，并说明默认不含 opinionated 偏好。

## 涉及文件

- `RULES.md`、`platforms/{claude,codex,gemini,generic}/*`、`profiles/rainor-opinionated/*`
- `scripts/install-{global,project}-rules.{ps1,sh}`
- `README.md`、`docs/adoption.md`、`CHANGELOG.md`、`.ai/{handoff,log,decisions,context}.md`

## 验证结果

- 四脚本（global/project × ps1/sh）实测：落盘文件自包含、含必回规则（数据结构优先/结论先行/中英文加空格）、含核心分隔；`-Profile` 片段正确追加。
- PowerShell 落盘文件按 UTF-8 读回首行精确匹配、字节层确认 UTF-8（无 GBK 乱码）；项目级 skip-existing 正常。
- `[Parser]::ParseFile` 对两个 ps1 零错误。

## 下一步建议

- 合并 `distill-core` → `main` 并推送。
- 各机器 `git pull` 后用 `install-global-rules`（首次 `-DryRun` 预演）；想要主动节奏再加 `-Profile rainor-opinionated`。
