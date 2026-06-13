# 接入指南

## 新项目

在项目根目录运行：

```sh
/Users/rainor/AI_RULES/scripts/install-project-rules.sh . codex claude gemini
```

这会复制：

- `AGENTS.md`
- `CLAUDE.md`
- `GEMINI.md`
- `.ai/`

## 已有项目

如果已有 `AGENTS.md`、`CLAUDE.md` 或 `GEMINI.md`，不要直接覆盖。建议：

1. 先备份或查看现有文件。
2. 将 `platforms/*` 中的规则合并进去。
3. 复制 `templates/project/.ai/` 到项目根目录。
4. 如果已有 `AI_CONTEXT.md`，把长期状态迁移到 `.ai/context.md`，把最近交接迁移到 `.ai/handoff.md`。

## 平台对应

- Codex：读取项目 `AGENTS.md`。
- Claude：读取用户级或项目级 `CLAUDE.md`。
- Gemini：可使用项目 `GEMINI.md` 或把 `platforms/generic/AI_PROMPT.md` 贴入系统提示词。

## 迭代建议

- 修改规则时优先更新 `RULES.md`。
- 平台入口文件保持短小，只写平台差异和规则入口。
- `.ai/` 模板只写可迁移结构，不写某个项目的具体状态。
