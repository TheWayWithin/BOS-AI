#!/usr/bin/env bash
# check-voice.sh
#
# Enforce the solopreneur voice rules from the Karpathy Business Constitution
# (library/CLAUDE.md §3) on generated user-facing content.
#
# Hook contract:
#   - Receives a JSON payload from Claude Code via stdin describing the
#     PostToolUse event (Edit / Write / MultiEdit).
#   - Reads the target file path from tool_input.file_path.
#   - Exits 0 if the file is out of scope or clean.
#   - Exits 2 (blocks the tool result) if banned words / em-dashes appear.
#
# Scope: only enforces on generated user-facing content paths:
#   - blog/
#   - progress/
#   - documents/business-assets/
#   - documents/foundation/
#
# Out of scope (silently skipped):
#   - The BOS-AI library source itself (.claude/, agents/, commands/,
#     missions/, templates/, library/, docs/, ideation/, workspace/, archive/)
#   - Non-markdown files
#
# False positive mitigation: scope is deliberately narrow. Constitution
# documents and ideation drafts can quote banned words freely without
# blocking edits.

set -uo pipefail

PAYLOAD=$(cat || true)

# Extract file_path from JSON payload (no jq dependency).
FILE=$(printf '%s' "$PAYLOAD" \
  | grep -oE '"file_path"[[:space:]]*:[[:space:]]*"[^"]+"' \
  | head -1 \
  | sed -E 's/.*"file_path"[[:space:]]*:[[:space:]]*"([^"]*)".*/\1/')

# Fallback: accept file path as command-line arg (manual invocation / testing).
[[ -z "${FILE:-}" ]] && FILE="${1:-}"

# Out of scope: no file, missing file, non-markdown.
[[ -z "${FILE:-}" ]] && exit 0
[[ ! -f "$FILE" ]] && exit 0
[[ "$FILE" != *.md ]] && exit 0

# Scope check: only enforce on user-facing generated content.
case "$FILE" in
  */blog/*|blog/*) ;;
  */progress/*|progress/*) ;;
  */documents/business-assets/*|documents/business-assets/*) ;;
  */documents/foundation/*|documents/foundation/*) ;;
  *) exit 0 ;;
esac

# Banned patterns from Constitution §3 + Jamie's banned-words list.
PATTERNS=(
  '\bwe\b'
  '\bour team\b'
  '\bthe team\b'
  '\becosystem\b'
  '\bleverage\b'
  '\bunlock\b'
  '\bempower\b'
  '\bseamless\b'
  '\brobust\b'
  '\butilize\b'
  '\bdelve\b'
  '\bnavigate\b'
  '—'
)

VIOLATIONS=""
for p in "${PATTERNS[@]}"; do
  MATCHES=$(grep -HniE -- "$p" "$FILE" 2>/dev/null || true)
  if [[ -n "$MATCHES" ]]; then
    VIOLATIONS+="$MATCHES"$'\n'
  fi
done

if [[ -n "$VIOLATIONS" ]]; then
  {
    echo ""
    echo "Voice rule violation in: $FILE"
    echo "Constitution §3 (solopreneur voice): rewrite in first person, plain English. No em-dashes in publishable content."
    echo ""
    echo "Matches:"
    printf '%s' "$VIOLATIONS"
  } >&2
  exit 2
fi

exit 0
