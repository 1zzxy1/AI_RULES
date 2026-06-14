# AI_RULES

一套**跨 AI 平台通用的基础协作规则 / 提示词**，供 Claude Code、Codex、Gemini CLI 等不同平台的 AI 助手复制使用并持续迭代。

目标：让不同电脑、不同 AI 接手同一个项目时，先读同一套规则、同一个协作目录，再基于 Git 和代码事实继续工作，避免规则漂移、上下文断裂。

## 三层设计

- **核心规则**：`RULES.md`，只保留跨平台都应遵守的最小协议。
- **平台系统提示词入口**：`platforms/`，各平台入口适配；**安装脚本会把 `RULES.md` 核心合入，落盘文件自包含**（不依赖安装目录里另有 `RULES.md`）。
- **个人偏好**：`profiles/`，保存机器差异和更强的个人工作流偏好。

系统提示词只定义稳定身份、行为边界和长期工作流；具体任务、一次性数据、输出格式和示例放用户提示词。详见 [docs/system-vs-user-prompts.md](docs/system-vs-user-prompts.md)。

Git、代码和测试是事实来源，`.ai/` 只是交接摘要。改规则时先改 [RULES.md](RULES.md)，平台系统提示词入口适配（`platforms/`）一般无需改动。

## 结构

```text
AI_RULES/
├── RULES.md                      # ★ 唯一权威来源：精简核心规则
├── CHANGELOG.md                  # 跨平台迭代留痕
├── platforms/                    # 各平台系统提示词入口适配（安装时合入 RULES.md 核心）
│   ├── claude/CLAUDE.md
│   ├── codex/AGENTS.md
│   ├── gemini/GEMINI.md
│   └── generic/AI_PROMPT.md
├── profiles/                     # 个人偏好与机器差异
│   ├── rainor-opinionated/       #   可追加安装的轻量偏好
│   └── rainor-macos/             #   历史全局规则快照（参考用）
├── templates/project/.ai/        # 复制到具体项目的协作目录模板
├── scripts/
│   ├── install-project-rules.ps1 # 项目级安装（Windows，skip-existing）
│   ├── install-project-rules.sh  # 项目级安装（macOS / Linux）
│   ├── install-global-rules.ps1  # 全局安装（Windows，覆盖式 + 备份）
│   └── install-global-rules.sh   # 全局安装（macOS / Linux）
├── docs/
│   ├── adoption.md               # 接入与迭代指南
│   └── system-vs-user-prompts.md # 系统提示词与用户提示词分工
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

或手动复制 `platforms/<你的助手>/` 下的文件到项目根目录，并把 `templates/project/.ai/` 复制为项目的 `.ai/`。手动复制时平台系统提示词入口不含完整核心，请连同 `RULES.md` 一起参考，或直接用上面的安装脚本生成自包含文件。详见 [docs/adoption.md](docs/adoption.md)。

## 全局安装（让仓库成为每台机器的通用提示词）

把三个平台副本装到本机【全局】位置——`~/.claude/CLAUDE.md`、`~/.codex/AGENTS.md`、`~/.gemini/GEMINI.md`。与项目级脚本不同，全局脚本是**覆盖式同步**（全局规则要随仓库更新），覆盖前自动把旧文件备份为 `*.bak.<时间戳>`：

```powershell
# Windows
.\scripts\install-global-rules.ps1 -DryRun -Profile rainor-opinionated  # 推荐先预演
.\scripts\install-global-rules.ps1 -Profile rainor-opinionated          # 推荐：核心 + 个人偏好
.\scripts\install-global-rules.ps1                 # 三平台全装
.\scripts\install-global-rules.ps1 -Targets claude # 只装 Claude
```

```bash
# macOS / Linux
./scripts/install-global-rules.sh --dry-run --profile rainor-opinionated  # 推荐先预演
./scripts/install-global-rules.sh --profile rainor-opinionated            # 推荐：核心 + 个人偏好
./scripts/install-global-rules.sh                       # 三平台全装
./scripts/install-global-rules.sh claude gemini         # 选装
```

更新流程：**改 `RULES.md` → 同步 `platforms/` → 各机器 `git pull` 后重跑 `install-global-rules`**。机器差异或个人偏好放 `profiles/<name>/`，用 `-Profile`/`--profile` 追加，不污染通用核心。

## Profiles

`profiles/rainor-opinionated/` 是推荐追加安装的轻量个人偏好（计划门禁、小步提交倾向）。**默认安装（不带 `-Profile`）不含这两条**；想要更主动、更可回滚的结对风格时，用 `-Profile rainor-opinionated` 追加。（「结论先行」「引用前核实」等已留在核心 `RULES.md`，无需 profile。）

`profiles/rainor-macos/` 保存了 Rainor macOS 曾经使用的全局 Codex/Claude 规则快照：

- `profiles/rainor-macos/AGENTS.md`：来自 `~/.codex/AGENTS.md`
- `profiles/rainor-macos/CLAUDE.md`：来自 `~/.claude/CLAUDE.md`

它主要用于参考和追溯，不建议直接作为全局安装 profile 追加，否则会把旧版长提示词重新叠加到精简核心后面。

## 给 AI 的迭代约定

如果你是 AI，正在修改本仓库：

1. 先读 [RULES.md](RULES.md) 和 [.ai/handoff.md](.ai/handoff.md)。
2. **改规则先改 RULES.md**，再同步 `platforms/` 下各平台系统提示词入口（保持语义一致，允许入口文件适配平台习惯）。
3. 不要把某个项目的一次性状态写进平台规则文件。
4. 在 [CHANGELOG.md](CHANGELOG.md) 追加一条，更新 `.ai/handoff.md`，必要时回复 `.ai/inbox.md`。
5. 完成后运行 `git status --short`，并在回复中说明改了什么、验证了什么。
