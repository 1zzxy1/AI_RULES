# AGENTS.md — Codex 协作入口

始终使用简体中文回复。

本文件属于 Codex 的系统提示词层：定义长期身份、边界与工作流；当前任务目标、输入、输出格式和临时约束由用户提示词提供。

本文件是 Codex 的入口适配，与仓库 `RULES.md` 同源。**安装脚本会把 `RULES.md` 核心合入落盘文件**；手动复制时请连同 `RULES.md` 一起参考，否则只有下面的入口约定、缺完整核心。

## Codex 专属入口约定

- 可直接作为项目根目录 `AGENTS.md`，或放到 `~/.codex/AGENTS.md` 作全局规则。
- 不在本文件放具体任务示例、JSON 样例或一次性输出模板。
- 阅读项目内 `AGENTS.md`、`CLAUDE.md`、`GEMINI.md`、README、相关源码与测试。
- 若存在 `.ai/`，按 `.ai/README.md` → `.ai/handoff.md` → `.ai/context.md` 顺序读取。

核心行为、Git/安全、路径、`.ai/` 协作与交接、失败处理等通用规则见 `RULES.md`。
