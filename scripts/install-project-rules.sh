#!/usr/bin/env sh
set -eu

usage() {
  printf 'Usage: %s <project-dir> [codex] [claude] [gemini]\n' "$0" >&2
  exit 2
}

[ "$#" -ge 1 ] || usage

PROJECT_DIR=$1
shift || true

if [ ! -d "$PROJECT_DIR" ]; then
  printf 'Project directory does not exist: %s\n' "$PROJECT_DIR" >&2
  exit 1
fi

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
REPO_DIR=$(CDPATH= cd -- "$SCRIPT_DIR/.." && pwd)

install_file() {
  src=$1
  dst=$2
  if [ -e "$dst" ]; then
    printf 'skip existing %s\n' "$dst"
  else
    cp "$src" "$dst"
    printf 'installed %s\n' "$dst"
  fi
}

install_ai_dir() {
  if [ -e "$PROJECT_DIR/.ai" ]; then
    printf 'skip existing %s\n' "$PROJECT_DIR/.ai"
  else
    cp -R "$REPO_DIR/templates/project/.ai" "$PROJECT_DIR/.ai"
    printf 'installed %s\n' "$PROJECT_DIR/.ai"
  fi
}

install_ai_dir

if [ "$#" -eq 0 ]; then
  set -- codex claude gemini
fi

for target in "$@"; do
  case "$target" in
    codex)
      install_file "$REPO_DIR/platforms/codex/AGENTS.md" "$PROJECT_DIR/AGENTS.md"
      ;;
    claude)
      install_file "$REPO_DIR/platforms/claude/CLAUDE.md" "$PROJECT_DIR/CLAUDE.md"
      ;;
    gemini)
      install_file "$REPO_DIR/platforms/gemini/GEMINI.md" "$PROJECT_DIR/GEMINI.md"
      ;;
    *)
      printf 'unknown target: %s\n' "$target" >&2
      usage
      ;;
  esac
done
