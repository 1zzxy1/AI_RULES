# AI Handoff

## 最近一次交接

- 时间：2026-06-14
- 作者：Codex
- 当前任务：创建并发布 AI_RULES 仓库，沉淀跨 AI 协作提示词。
- 状态：已发布到 GitHub，准备给其他机器和其他 AI 继续迭代。

## 本次完成

- 创建通用规则 `RULES.md`。
- 创建 Codex、Claude、Gemini 和通用 AI 平台入口。
- 创建项目 `.ai/` 模板。
- 创建安装脚本和接入文档。

## 涉及文件

- `README.md`
- `RULES.md`
- `platforms/**`
- `templates/project/.ai/**`
- `scripts/install-project-rules.sh`
- `docs/adoption.md`
- `.ai/**`

## 验证结果

- 已运行目录检查：`find /Users/rainor/AI_RULES -maxdepth 4 -type f | sort`
- 已确认关键文件存在：`README.md`、`RULES.md`、平台入口、模板、安装脚本。
- 已执行安装脚本冒烟测试：`/Users/rainor/AI_RULES/scripts/install-project-rules.sh /tmp/ai_rules_install_test codex claude gemini`
- 已确认临时项目生成 `.ai/`、`AGENTS.md`、`CLAUDE.md`、`GEMINI.md`。
- 已创建 GitHub 仓库：`https://github.com/1zzxy1/AI_RULES`
- 已确认远程包含 `.ai/`、`platforms/`、`templates/`、`scripts/`、`RULES.md`。
- 已补充 `profiles/rainor-macos/`，保存本机当前 Codex/Claude 全局规则快照，便于 Windows 机器参考迁移。

## 下一步建议

- 根据不同平台真实行为继续压缩/调整入口文件。
- 给 Gemini 补充更具体的工具适配规则。
- 在 Windows 机器 clone 后，让本地 Claude/Codex/Gemini 先读 `README.md`、`RULES.md` 和 `.ai/handoff.md`，再提交迭代。
- 若要同步 Rainor 个人级规则，参考 `profiles/rainor-macos/AGENTS.md` 和 `profiles/rainor-macos/CLAUDE.md`；若要给项目接入，优先使用 `platforms/` 和 `templates/project/.ai/`。
