# 迭代记录（CHANGELOG）

格式：`日期 | 平台 | 改了什么 | 为什么`。每次迭代规则后在最上方追加一条。

---

- **2026-06-14 | Claude Code (Windows)** | 复审 distill-core(1d7ffd6) 并修复后合并：用 9-agent 对抗式复审，裁决 approve-with-fixes。修复 4 个阻塞项——① 落地缺口：安装脚本改为「合入 `RULES.md` 核心」生成自包含落盘文件（全局/项目、ps1/sh 四脚本），不再让薄入口指向安装目录里不存在的 `RULES.md`；② 补回 4 条被过度删减的跨平台核心：中英文加空格+全角标点、新对话主动询问/不擅自创建推送远程、交付前不留占位符、结论先行（回 `RULES.md`，其余计划门禁/小步提交保留在 opinionated profile）；③ 修 PowerShell `-Profile` 在中文 Windows 把无 BOM UTF-8 按 GBK 误读成乱码的 bug（统一 .NET 无 BOM 读写）；④ 文档诚实化：纠正「可单独复制使用」表述、说明默认不含 opinionated 偏好。另补回「数据结构优先」。 | 蒸馏方向（短核心 + 偏好下沉）正确，但薄入口让安装后核心规则丢失、且删了必须跨平台保留的约束，必须修复后才能合并。
- **2026-06-14 | Codex (macOS)** | 蒸馏核心规则：`RULES.md` 从长条目压缩为最小核心；`platforms/` 改为薄入口；将「结论先行 / 计划门禁 / 小步提交倾向」下沉到 `profiles/rainor-opinionated/`；README/adoption 解释三层结构与 profile 用法。 | Mac 与 Windows 规则都已形成后，压缩共同内核，避免通用规则继续膨胀。
- **2026-06-14 | Claude Code (Windows)** | 新增全局安装能力：`scripts/install-global-rules.{ps1,sh}` 把 platforms/* 装到 `~/.claude/CLAUDE.md`、`~/.codex/AGENTS.md`、`~/.gemini/GEMINI.md`（覆盖式同步 + `*.bak.<时间戳>` 备份，区别于项目级 skip-existing），支持 `-Targets`/`-Profile`/`-DryRun`；机器差异用 `profiles/<machine>/` 片段隔离。README/adoption 增「全局安装」章节。修复 `.ps1` 缺 UTF-8 BOM 导致 PowerShell 5.1 按 GBK 解析中文的问题（含旧 `install-project-rules.ps1`）。 | 用户希望仓库成为每台机器通用 Claude/Codex/Gemini 提示词的唯一来源。
- **2026-06-14 | Claude Code (Windows)** | 用 agent 集群（19 挖掘 + 7 盘点 + 合成/守门/提案）交叉分析本机 Claude/Codex/Gemini 提示词资产，守门人从 15 候选中放行 5 条并入 RULES.md 与 4 个平台副本：① c7「动手前先看相似实现、复用既有库、无理由不引入新工具」并入「遵循现有风格」；② c8+c9「引用前核实、交付前自检（不凭记忆臆造引用、不留占位符）」新增反幻觉条目；③ c1+c2 第二部分新增「10. 汇报与计划纪律」（结论先行、计划门禁）。并按用户裁决处理 3 个冲突：注释语言改为「跟随代码库」；明确「每次改动即提交」为权威、删除平台副本里矛盾的「未经用户要求不主动提交」；「不主动生成文档」细化为不新建但同步更新既有文档。 | 让仓库吸收本机多来源提示词中真正跨 AI 通用的增量，同时严守「极简优先」防止规则膨胀。
- **2026-06-14 | Claude Code (Windows)** | 在 Codex 初版基础上融合迭代：把本机更完整的行为规则（简体中文、7 条编码原则、3 次失败原则、Git 提交纪律、跨平台路径表、安全边界）补进 RULES.md「第一部分 · 行为规则」，保留并整合 Codex 的「第二部分 · 跨 AI 协作协议」（`.ai/` 交接系统）；平台文件改为自包含（行为规则 + 协作协议两段）；新增 Windows PowerShell 安装脚本 `install-project-rules.ps1`（接口与 `.sh` 对齐：skip-existing、按平台选装）；新增本 CHANGELOG；README/adoption 去掉 Mac 硬编码路径，改为通用写法。 | Codex 初版偏重交接协议、缺少编码行为规则；用户在 Windows 协作，需要可单文件复制、跨平台可迭代且留痕的完整规则库。
- **(初版) | Codex (macOS)** | 创建仓库骨架：RULES.md（跨 AI 交接协议）、platforms/（claude/codex/gemini/generic）、templates/project/.ai/（context/handoff/log/decisions/tasks/inbox 模板）、scripts/install-project-rules.sh、docs/adoption.md、仓库自身 `.ai/`。 | 建立一套可被不同平台 AI 复制与迭代的基础提示词与交接机制。
