# AI_RULES

一套**跨 AI 平台通用的基础协作规则 / 提示词**，供 Claude Code、Codex、Gemini CLI 等不同平台的 AI 助手复制使用并持续迭代。

目标：让不同电脑、不同 AI 接手同一个项目时，先读同一套规则、同一个协作目录，再基于 Git 和代码事实继续工作，避免规则漂移、上下文断裂。

## 两层设计

- **行为规则**：AI 写代码时怎么做——语言、编码原则、Git 纪律、路径、安全。
- **跨 AI 协作协议**：多个 AI 通过项目根目录的 `.ai/` 接力——`context` / `handoff` / `log` / `decisions` / `tasks` / `inbox`。Git 是事实来源，`.ai/` 只是交接摘要。

二者都收敛在唯一权威来源 [RULES.md](RULES.md)；`platforms/` 下是各平台自包含副本，可单文件复制即用。

## 结构

```text
AI_RULES/
├── RULES.md                      # ★ 唯一权威来源：行为规则 + 协作协议
├── CHANGELOG.md                  # 跨平台迭代留痕
├── platforms/                    # 各平台自包含副本（可单独复制使用）
│   ├── claude/CLAUDE.md
│   ├── codex/AGENTS.md
│   ├── gemini/GEMINI.md
│   └── generic/AI_PROMPT.md
├── profiles/                     # 个人级全局规则快照（参考用）
│   └── rainor-macos/             #   AGENTS.md / CLAUDE.md
├── templates/project/.ai/        # 复制到具体项目的协作目录模板
├── scripts/
│   ├── install-project-rules.ps1 # Windows 安装脚本
│   └── install-project-rules.sh  # macOS / Linux 安装脚本
├── docs/adoption.md              # 接入与迭代指南
└── .ai/                          # 本仓库自己的协作目录（修改本仓库前先读）
```

## 快速使用

给目标项目安装规则（已存在的文件会跳过、不覆盖）：

```powershell
# Windows
.\scripts\install-project-rules.ps1 -ProjectDir D:\work\my-project
# 只装部分平台：
.\scripts\install-project-rules.ps1 -ProjectDir . -Targets claude,gemini
```

```bash
# macOS / Linux
./scripts/install-project-rules.sh /path/to/project codex claude gemini
```

或手动复制 `platforms/<你的助手>/` 下的文件到项目根目录，并把 `templates/project/.ai/` 复制为项目的 `.ai/`。详见 [docs/adoption.md](docs/adoption.md)。

也可把 `platforms/claude/CLAUDE.md` 放到 `~/.claude/CLAUDE.md` 作为全局规则。

## 个人配置备份

`profiles/rainor-macos/` 保存了 Rainor 当前 macOS 本机正在使用的全局 Codex/Claude 规则快照：

- `profiles/rainor-macos/AGENTS.md`：来自 `~/.codex/AGENTS.md`
- `profiles/rainor-macos/CLAUDE.md`：来自 `~/.claude/CLAUDE.md`

Windows 或其他机器可以参考这个目录迁移个人级规则；项目级规则仍建议使用 `platforms/` 和 `templates/project/.ai/`。

## 给 AI 的迭代约定

如果你是 AI，正在修改本仓库：

1. 先读 [RULES.md](RULES.md) 和 [.ai/handoff.md](.ai/handoff.md)。
2. **改规则先改 RULES.md**，再同步 `platforms/` 下各自包含副本（保持语义一致，允许入口文件适配平台习惯）。
3. 不要把某个项目的一次性状态写进平台规则文件。
4. 在 [CHANGELOG.md](CHANGELOG.md) 追加一条，更新 `.ai/handoff.md`，必要时回复 `.ai/inbox.md`。
5. 完成后运行 `git status --short`，并在回复中说明改了什么、验证了什么。
