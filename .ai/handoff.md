# AI Handoff

## 最近一次交接

- 时间：2026-06-15
- 作者：Codex (macOS)
- 当前任务：把“系统提示词定义稳定规则，用户提示词定义当前任务”的分工沉淀进 AI_RULES，供 Mac/Windows 的 Claude、Codex、Gemini 共用。
- 状态：规则与文档已更新并验证，待提交和推送。

## 本次变更

- `RULES.md` 新增“系统提示词与用户提示词分工”，明确系统层只放稳定身份、行为准则、能力边界、安全底线和长期工作流；当前目标、输入、验收标准、输出格式、一次性示例放用户提示词。
- `platforms/{claude,codex,gemini,generic}/` 明确标注为系统提示词入口，并要求不放具体任务示例、JSON 样例或一次性输出模板。
- 新增 `docs/system-vs-user-prompts.md`，给 Mac/Windows 统一安装和分层使用提供短说明。
- `README.md` 与 `docs/adoption.md` 补充“平台系统提示词入口”措辞、分层说明、推荐 dry-run 后安装的 Mac/Windows 命令。
- `CHANGELOG.md` 追加本轮迭代记录。

## 设计要点

- 这次没有把用户给的知乎原文或具体示例原样塞进核心规则，只提炼成稳定原则。
- `RULES.md` 仍是唯一权威来源；平台入口保持薄适配，安装脚本负责合入核心生成自包含落盘文件。
- `rainor-opinionated` 仍只追加计划门禁和小步提交倾向，默认安装不带这两条。

## 验证结果

- `git diff --check` 通过。
- `./scripts/install-global-rules.sh --dry-run --profile rainor-opinionated` 通过。
- 临时 `HOME` 全局安装通过，`~/.codex/AGENTS.md`、`~/.claude/CLAUDE.md`、`~/.gemini/GEMINI.md` 均含分层规则和 `rainor-opinionated` profile 片段。
- 临时项目安装通过，项目 `AGENTS.md`、`CLAUDE.md` 均含分层规则。

## 下一步建议

- Windows 机器 `git pull` 后运行：
  - `.\scripts\install-global-rules.ps1 -DryRun -Profile rainor-opinionated`
  - `.\scripts\install-global-rules.ps1 -Profile rainor-opinionated`
- macOS 机器运行：
  - `./scripts/install-global-rules.sh --dry-run --profile rainor-opinionated`
  - `./scripts/install-global-rules.sh --profile rainor-opinionated`
