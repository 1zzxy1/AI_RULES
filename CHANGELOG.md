# 迭代记录（CHANGELOG）

格式：`日期 | 平台 | 改了什么 | 为什么`。每次迭代规则后在最上方追加一条。

---

- **2026-06-14 | Claude Code (Windows)** | 在 Codex 初版基础上融合迭代：把本机更完整的行为规则（简体中文、7 条编码原则、3 次失败原则、Git 提交纪律、跨平台路径表、安全边界）补进 RULES.md「第一部分 · 行为规则」，保留并整合 Codex 的「第二部分 · 跨 AI 协作协议」（`.ai/` 交接系统）；平台文件改为自包含（行为规则 + 协作协议两段）；新增 Windows PowerShell 安装脚本 `install-project-rules.ps1`（接口与 `.sh` 对齐：skip-existing、按平台选装）；新增本 CHANGELOG；README/adoption 去掉 Mac 硬编码路径，改为通用写法。 | Codex 初版偏重交接协议、缺少编码行为规则；用户在 Windows 协作，需要可单文件复制、跨平台可迭代且留痕的完整规则库。
- **(初版) | Codex (macOS)** | 创建仓库骨架：RULES.md（跨 AI 交接协议）、platforms/（claude/codex/gemini/generic）、templates/project/.ai/（context/handoff/log/decisions/tasks/inbox 模板）、scripts/install-project-rules.sh、docs/adoption.md、仓库自身 `.ai/`。 | 建立一套可被不同平台 AI 复制与迭代的基础提示词与交接机制。
