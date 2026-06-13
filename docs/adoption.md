# 接入与迭代指南

## 一、给项目接入规则

### 方式 A：脚本安装（推荐）

已存在的文件/目录会**跳过、不覆盖**，可安全重复运行。

```powershell
# Windows / PowerShell —— <仓库>\scripts\install-project-rules.ps1
.\scripts\install-project-rules.ps1 -ProjectDir D:\work\my-project
# 只装部分平台：
.\scripts\install-project-rules.ps1 -ProjectDir . -Targets claude,gemini
```

```bash
# macOS / Linux —— <仓库>/scripts/install-project-rules.sh
./scripts/install-project-rules.sh /path/to/project codex claude gemini
```

脚本会复制对应平台入口文件到项目根目录，并把 `templates/project/.ai/` 复制为项目的 `.ai/`。

### 方式 B：手动复制

| 助手 | 复制这个文件 | 放到项目根目录为 |
| --- | --- | --- |
| Claude Code | `platforms/claude/CLAUDE.md` | `CLAUDE.md` |
| Codex | `platforms/codex/AGENTS.md` | `AGENTS.md` |
| Gemini CLI | `platforms/gemini/GEMINI.md` | `GEMINI.md` |
| 其它 | `platforms/generic/AI_PROMPT.md` | 粘进系统提示词 |

再把 `templates/project/.ai/` 复制为项目的 `.ai/`。也可把 `platforms/claude/CLAUDE.md` 放到 `~/.claude/CLAUDE.md` 作全局规则。

## 二、已有规则文件的项目

如果项目已有 `AGENTS.md`/`CLAUDE.md`/`GEMINI.md`，**不要直接覆盖**：

1. 先备份或查看现有文件；
2. 把 `platforms/*` 的规则合并进去；
3. 复制 `templates/project/.ai/` 为项目的 `.ai/`；
4. 若已有旧版 `AI_CONTEXT.md`，把长期状态迁到 `.ai/context.md`、最近交接迁到 `.ai/handoff.md`。

## 三、同步个人级规则

如果要把某台机器本机正在用的个人级（全局）规则同步到另一台机器，可参考 `profiles/` 下的快照，例如：

- `profiles/rainor-macos/AGENTS.md`（来自 `~/.codex/AGENTS.md`）
- `profiles/rainor-macos/CLAUDE.md`（来自 `~/.claude/CLAUDE.md`）

这些是个人配置快照；跨机器使用前先检查路径、平台差异和本机工具习惯。项目级规则仍优先用 `platforms/` 和 `templates/project/.ai/`。

## 四、跨平台迭代流程

这套规则会被多个平台的 AI（Claude / Codex / Gemini）轮流复制与改进。为避免漂移，约定：

1. **唯一来源是 [RULES.md](../RULES.md)**：任何规则改动**先改 RULES.md**。
2. **再同步派生文件**：同步到 `platforms/` 下四个自包含副本（语义一致，允许排版/措辞适配各平台）。
3. **记录到 [CHANGELOG.md](../CHANGELOG.md)**：追加一条 `日期 | 平台 | 改了什么 | 为什么`。
4. **更新 `.ai/`**：更新 `.ai/handoff.md`，必要时回复 `.ai/inbox.md`。
5. **提交**：每次迭代单独 commit，message 用 Conventional Commits。

## 五、校验是否同步

派生文件与 RULES.md 应在「规则条目」上一致。审阅时逐条核对：语言、编码原则 7 条、3 次失败、Git 工作流、路径、安全边界、`.ai/` 协作协议。若某平台需要特例，在该平台文件中显式标注，不要静默偏离。
