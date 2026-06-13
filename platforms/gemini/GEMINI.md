# GEMINI.md — Gemini 协作入口

始终使用简体中文回复。

本文件是 Gemini 的入口适配，与仓库 `RULES.md` 同源。**安装脚本会把 `RULES.md` 核心合入落盘文件**；手动复制时请连同 `RULES.md` 一起参考，否则只有下面的入口约定、缺完整核心。

## Gemini 专属入口约定

- 可作为项目根目录 `GEMINI.md`，或放到 `~/.gemini/GEMINI.md` 作全局规则。
- 阅读项目内 `GEMINI.md`、`AGENTS.md`、`CLAUDE.md`、README、相关源码与测试。
- 若存在 `.ai/`，按 `.ai/README.md` → `.ai/handoff.md` → `.ai/context.md` 顺序读取。
- 不同 Gemini CLI/IDE 集成读取的规则文件名可能不同；若你的环境不读 `GEMINI.md`，把本文件与 `RULES.md` 内容贴进系统提示词。

核心行为、Git/安全、路径、`.ai/` 协作与交接、失败处理等通用规则见 `RULES.md`。
