# AI_RULES

一套给 Codex、Claude、Gemini 和其他 AI 共同使用的项目交接与版本管理基础规则。

目标很简单：让不同 AI 接手同一个项目时，先读同一套规则、同一个协作目录，再基于 Git 和代码事实继续工作。

## 核心设计

- Git 是事实来源，AI 文档只是交接摘要。
- 平台规则文件只放稳定工作流：`AGENTS.md`、`CLAUDE.md`、`GEMINI.md`。
- 项目状态放在项目根目录的 `.ai/`：
  - `.ai/context.md`：长期项目状态
  - `.ai/handoff.md`：最近一次交接
  - `.ai/log.md`：简短开发日志
  - `.ai/decisions.md`：重要技术决策
  - `.ai/tasks.md`：可接手待办
  - `.ai/inbox.md`：不同 AI 之间的异步留言

## 目录说明

```text
AI_RULES/
  README.md
  RULES.md
  platforms/
    codex/AGENTS.md
    claude/CLAUDE.md
    gemini/GEMINI.md
    generic/AI_PROMPT.md
  templates/
    project/
      .ai/
        README.md
        context.md
        handoff.md
        log.md
        decisions.md
        tasks.md
        inbox.md
  scripts/
    install-project-rules.sh
  docs/
    adoption.md
  .ai/
    ...
```

## 快速使用

在目标项目根目录运行：

```sh
/Users/rainor/AI_RULES/scripts/install-project-rules.sh /path/to/project codex claude gemini
```

也可以手动复制：

```sh
cp /Users/rainor/AI_RULES/platforms/codex/AGENTS.md /path/to/project/AGENTS.md
cp /Users/rainor/AI_RULES/platforms/claude/CLAUDE.md /path/to/project/CLAUDE.md
cp /Users/rainor/AI_RULES/platforms/gemini/GEMINI.md /path/to/project/GEMINI.md
cp -R /Users/rainor/AI_RULES/templates/project/.ai /path/to/project/.ai
```

## 给 AI 的迭代原则

如果你是 AI，正在修改这个仓库：

- 先读 `RULES.md` 和 `.ai/handoff.md`。
- 修改平台规则时，保持各平台语义一致，但允许入口文件适配平台习惯。
- 不要把一次性项目状态写进平台规则文件。
- 更新规则后，同步更新 `templates/project/.ai/README.md` 和 `.ai/handoff.md`。
- 修改完成后运行 `git status --short`，并在回复中说明改了什么。
