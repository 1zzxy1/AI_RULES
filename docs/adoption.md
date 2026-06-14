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

脚本会把 `RULES.md` 核心合入对应平台入口、写到项目根目录（落盘文件【自包含】，项目内无需另有 `RULES.md`），并把 `templates/project/.ai/` 复制为项目的 `.ai/`。

### 方式 B：手动复制

| 助手 | 复制这个文件 | 放到项目根目录为 |
| --- | --- | --- |
| Claude Code | `platforms/claude/CLAUDE.md` | `CLAUDE.md` |
| Codex | `platforms/codex/AGENTS.md` | `AGENTS.md` |
| Gemini CLI | `platforms/gemini/GEMINI.md` | `GEMINI.md` |
| 其它 | `platforms/generic/AI_PROMPT.md` | 粘进系统提示词 |

再把 `templates/project/.ai/` 复制为项目的 `.ai/`。**注意**：`platforms/` 下的入口文件本身只含平台适配、不含完整核心；手动复制时请连同 `RULES.md` 一起参考，或改用上面的脚本（脚本会自动合入核心生成自包含文件）。

## 二、全局安装：每台机器的通用提示词

把三个平台副本装到本机【全局】位置，让本仓库成为每台机器 Claude/Codex/Gemini 的通用规则来源：

| 源 | 目标（全局） |
| --- | --- |
| `platforms/claude/CLAUDE.md` | `~/.claude/CLAUDE.md` |
| `platforms/codex/AGENTS.md` | `~/.codex/AGENTS.md` |
| `platforms/gemini/GEMINI.md` | `~/.gemini/GEMINI.md` |

落盘文件 = 平台入口适配 + `RULES.md` 核心（+ 可选 profile 片段），即【自包含】，不依赖安装目录里另有 `RULES.md`。与项目级脚本（skip-existing）不同，全局脚本是**覆盖式同步**——全局规则需随仓库更新，所以每次覆盖目标，并在覆盖前把旧文件备份为 `*.bak.<时间戳>`。

```powershell
# Windows
.\scripts\install-global-rules.ps1 -DryRun -Profile rainor-opinionated  # 推荐先预演
.\scripts\install-global-rules.ps1 -Profile rainor-opinionated          # 推荐：核心 + 个人偏好
.\scripts\install-global-rules.ps1                      # 三平台全装
.\scripts\install-global-rules.ps1 -Targets claude      # 选装
```

```bash
# macOS / Linux
./scripts/install-global-rules.sh --dry-run --profile rainor-opinionated  # 推荐先预演
./scripts/install-global-rules.sh --profile rainor-opinionated            # 推荐：核心 + 个人偏好
./scripts/install-global-rules.sh                         # 三平台全装
./scripts/install-global-rules.sh claude gemini           # 选装
```

机器差异（路径偏好、本机特有工具）或个人偏好放 `profiles/<name>/`，用 `-Profile`/`--profile` 在通用核心后追加片段，不污染通用核心。多机更新流程：**改 `RULES.md` → 同步 `platforms/` → 各机器 `git pull` 后重跑全局脚本**。

> 注意：覆盖式同步会覆盖你手写在 `~/.claude/CLAUDE.md` 等处但未沉淀到 `profiles/` 的个性化内容（会先备份为 `.bak.<时间戳>`）。首次建议先 `-DryRun`/`--dry-run` 预演。

## 三、系统提示词与用户提示词分工

`RULES.md` 和 `platforms/` 属于系统提示词层，适合放稳定身份、行为准则、能力边界、安全底线和长期工作流。它们会长期影响每一轮对话，所以保持短、稳、通用。

用户提示词负责当前这一轮“做什么”：任务目标、输入材料、可改范围、验收标准、临时输出格式和一次性示例。具体任务示例、JSON 样例、报告模板、某次排障日志不要写进全局规则，避免后续任务被错误格式牵引。

更多说明见 [system-vs-user-prompts.md](system-vs-user-prompts.md)。

## 四、已有规则文件的项目

如果项目已有 `AGENTS.md`/`CLAUDE.md`/`GEMINI.md`，**不要直接覆盖**：

1. 先备份或查看现有文件；
2. 把 `platforms/*` 的规则合并进去；
3. 复制 `templates/project/.ai/` 为项目的 `.ai/`；
4. 若已有旧版 `AI_CONTEXT.md`，把长期状态迁到 `.ai/context.md`、最近交接迁到 `.ai/handoff.md`。

## 五、Profiles 与个人级规则

推荐可安装 profile：

- `profiles/rainor-opinionated/`：轻量个人偏好（计划门禁、小步提交倾向），适合用 `-Profile rainor-opinionated` 追加。**默认安装（不带 profile）不含这两条**——这是相对「每次改动即提交」硬约束的有意放宽，需要时显式追加。「结论先行 / 引用前核实」已在核心 `RULES.md`，无需 profile。

历史参考 profile：

- `profiles/rainor-macos/AGENTS.md`（来自 `~/.codex/AGENTS.md`）
- `profiles/rainor-macos/CLAUDE.md`（来自 `~/.claude/CLAUDE.md`）

`rainor-macos` 是旧版完整全局提示词快照，主要用于追溯和迁移，不建议直接追加安装，否则会把长提示词叠到精简核心后面。项目级规则仍优先用 `platforms/` 和 `templates/project/.ai/`。

## 六、跨平台迭代流程

这套规则会被多个平台的 AI（Claude / Codex / Gemini）轮流复制与改进。为避免漂移，约定：

1. **唯一来源是 [RULES.md](../RULES.md)**：任何规则改动**先改 RULES.md**。
2. **再同步平台系统提示词入口**：同步到 `platforms/` 下四个入口文件（语义一致，允许排版/措辞适配各平台）。
3. **记录到 [CHANGELOG.md](../CHANGELOG.md)**：追加一条 `日期 | 平台 | 改了什么 | 为什么`。
4. **更新 `.ai/`**：更新 `.ai/handoff.md`，必要时回复 `.ai/inbox.md`。
5. **提交**：每次迭代单独 commit，message 用 Conventional Commits。

## 七、校验是否同步

平台系统提示词入口与 RULES.md 应在核心语义上一致。审阅时核对：系统/用户提示词分工、中文回复、先读再改、最小变更、Git/代码/测试事实源、安全边界、`.ai/` 交接、失败处理。若某平台需要特例，在该平台文件中显式标注，不要静默偏离。
