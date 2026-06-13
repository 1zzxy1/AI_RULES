#!/usr/bin/env sh
# 把 AI_RULES 规则装成本机【全局】提示词（macOS / Linux）。
# 落盘文件 = 平台入口适配 + RULES.md 核心（+ 可选 profile 片段），即【自包含】，
# 不依赖安装目录里另有 RULES.md。覆盖式同步（区别于项目级脚本的 skip-existing）：
# 每次覆盖目标，覆盖前备份为 *.bak.<时间戳>。
#   platforms/claude/CLAUDE.md (+RULES.md) -> $HOME/.claude/CLAUDE.md
#   platforms/codex/AGENTS.md  (+RULES.md) -> $HOME/.codex/AGENTS.md
#   platforms/gemini/GEMINI.md (+RULES.md) -> $HOME/.gemini/GEMINI.md
# 用法: ./install-global-rules.sh [claude] [codex] [gemini] [--profile <name>] [--dry-run]
#   省略平台则三者全装。--profile 在核心后追加 profiles/<name>/ 片段（如 rainor-opinionated）。
set -eu

REPO_DIR=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
STAMP=$(date +%Y%m%d-%H%M%S)
PROFILE=""
DRYRUN=0
TARGETS=""

while [ "$#" -gt 0 ]; do
  case "$1" in
    --profile) PROFILE=${2:-}; shift 2 ;;
    --dry-run) DRYRUN=1; shift ;;
    claude|codex|gemini) TARGETS="$TARGETS $1"; shift ;;
    *) printf 'unknown arg: %s\n' "$1" >&2; exit 2 ;;
  esac
done
[ -n "$TARGETS" ] || TARGETS="claude codex gemini"

src_for() { case "$1" in
  claude) echo "platforms/claude/CLAUDE.md" ;;
  codex)  echo "platforms/codex/AGENTS.md" ;;
  gemini) echo "platforms/gemini/GEMINI.md" ;;
esac }
dst_for() { case "$1" in
  claude) echo "$HOME/.claude/CLAUDE.md" ;;
  codex)  echo "$HOME/.codex/AGENTS.md" ;;
  gemini) echo "$HOME/.gemini/GEMINI.md" ;;
esac }
prof_for() { case "$1" in
  claude) echo "CLAUDE.md" ;;
  codex)  echo "AGENTS.md" ;;
  gemini) echo "GEMINI.md" ;;
esac }

for t in $TARGETS; do
  src="$REPO_DIR/$(src_for "$t")"
  dst=$(dst_for "$t")
  pf="$REPO_DIR/profiles/$PROFILE/$(prof_for "$t")"
  use_profile=0
  if [ -n "$PROFILE" ] && [ -f "$pf" ]; then use_profile=1; fi
  if [ -n "$PROFILE" ] && [ ! -f "$pf" ]; then
    printf "(profile '%s' 无 %s，%s 仅装通用核心)\n" "$PROFILE" "$(prof_for "$t")" "$t"
  fi

  if [ "$DRYRUN" -eq 1 ]; then
    if [ "$use_profile" -eq 1 ]; then printf '[dry-run] %s -> %s (通用核心 + profile 片段)\n' "$t" "$dst"
    else printf '[dry-run] %s -> %s (通用核心)\n' "$t" "$dst"; fi
    continue
  fi

  mkdir -p "$(dirname "$dst")"
  if [ -e "$dst" ]; then cp "$dst" "$dst.bak.$STAMP"; printf '备份 %s -> %s.bak.%s\n' "$dst" "$dst" "$STAMP"; fi
  {
    cat "$src"
    printf '\n\n---\n\n# 通用核心规则（来自 AI_RULES / RULES.md）\n\n'
    cat "$REPO_DIR/RULES.md"
    if [ "$use_profile" -eq 1 ]; then
      printf '\n\n---\n\n# 个人偏好（profile: %s）\n\n' "$PROFILE"
      cat "$pf"
    fi
  } > "$dst"
  printf '安装 %s\n' "$dst"
done

printf '\n完成。规则更新流程：改 RULES.md -> 同步 platforms/ -> 各机器重跑本脚本拉取。\n'
