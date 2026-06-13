# AI Handoff

## 最近一次交接

- 时间：2026-06-14
- 作者：Claude Code (Windows)
- 当前任务：学习 Codex 创建并发布的初版，结合本机全局规则迭代 AI_RULES。
- 状态：融合迭代完成，已在远程最新提交之上 rebase，待 push。

## 本次完成

- RULES.md 重构为两部分：**第一部分 · 行为规则**（补入本机全局 CLAUDE.md 的语言/7 条编码原则/3 次失败/Git 纪律/路径表/安全），**第二部分 · 跨 AI 协作协议**（保留并整合 Codex 的 `.ai/` 交接系统）。
- 四个平台入口文件改为自包含：行为规则 + 协作协议两段，单文件复制即可用。
- 新增 `scripts/install-project-rules.ps1`（Windows），接口与 `.sh` 对齐：skip-existing、`-Targets` 选装平台、安装 `.ai/` 模板。
- 新增 `CHANGELOG.md` 做跨平台迭代留痕。
- README.md / docs/adoption.md 去掉 `/Users/rainor/...` Mac 硬编码路径，改为通用写法（保留 Codex 新增的 `profiles/rainor-macos/` 个人规则快照说明）。
- `.gitignore` 合并并新增忽略 `.spec-workflow/`、`*.bak`。

## 涉及文件

- `RULES.md`、`README.md`、`CHANGELOG.md`、`.gitignore`
- `platforms/{claude,codex,gemini,generic}/*`
- `scripts/install-project-rules.ps1`
- `docs/adoption.md`
- `.ai/{handoff,log,inbox,decisions,context}.md`

## 验证结果

- PowerShell 安装脚本已在临时目录冒烟测试：按 `-Targets` 选装正确，`.ai/` 模板齐全，重复运行正确 skip。
- 远程已由 Codex 发布到 `https://github.com/1zzxy1/AI_RULES`，并含 `profiles/rainor-macos/`（本机 Codex/Claude 全局规则快照）；本次改动已 rebase 到 `origin/main`（含该快照提交）之上，未丢弃任何远程内容。

## 下一步建议

- 在真实项目里跑一遍安装脚本，验证 `.ai/` 模板可用性。
- 给 Gemini 补充更具体的工具/文件名适配（见 tasks.md P1）。
- 后续平台 AI 迭代时严格走「先改 RULES.md → 同步 platforms → 记 CHANGELOG → 更新 `.ai/`」。
- 同步个人级规则参考 `profiles/rainor-macos/`；项目接入用 `platforms/` 与 `templates/project/.ai/`。
