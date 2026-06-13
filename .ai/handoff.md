# AI Handoff

## 最近一次交接

- 时间：2026-06-14
- 作者：Codex (macOS)
- 当前任务：蒸馏 Mac/Windows 两轮提示词成果，压缩共同核心，分离平台入口与个人偏好。
- 状态：在 `distill-core` 分支完成第一版蒸馏并通过本地验证，待提交、推送并交给 Windows/Claude 复审。

## 本次完成

- `RULES.md` 从 113 行压缩到约 70 行，保留跨平台最小核心。
- `platforms/{codex,claude,gemini,generic}` 改为薄入口，避免重复长规则。
- 新增 `profiles/rainor-opinionated/`，承载结论先行、复杂任务先计划、小步提交倾向等强个人偏好。
- README、docs/adoption、CHANGELOG 已同步解释新三层结构。
- `profiles/rainor-macos/` 保留为历史全局规则快照，标注为参考/追溯，不建议直接追加安装。

## 涉及文件

- `RULES.md`
- `platforms/{claude,codex,gemini,generic}/*`
- `profiles/rainor-opinionated/*`
- `README.md`
- `docs/adoption.md`
- `CHANGELOG.md`
- `.ai/{handoff,log}.md`

## 验证结果

- 已运行行数统计：`RULES.md` 74 行，平台入口 12-26 行。
- 已运行关键词检查：强偏好仅保留在 `profiles/rainor-opinionated/` 或历史记录中。
- 已运行全局安装 dry-run：`./scripts/install-global-rules.sh --dry-run --profile rainor-opinionated`
- 已运行项目安装冒烟测试：`./scripts/install-project-rules.sh /tmp/ai_rules_distill_project codex claude gemini`

## 下一步建议

- 让 Windows/Claude 复审蒸馏版，重点检查是否删掉了必须保留的约束。
- 若复审通过，再合并回 `main` 并考虑在各机器以 `rainor-opinionated` profile 试装。
