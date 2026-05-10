# BOS-AI voice-enforcement hook

Deterministic guardrail that blocks corporate-speak and em-dashes in generated user-facing content. Implements rule §3 of the Karpathy Business Constitution (see `library/CLAUDE.md`).

## What it does

When you Edit / Write / MultiEdit a markdown file in one of these paths:

- `blog/`
- `progress/`
- `documents/business-assets/`
- `documents/foundation/`

the hook greps the file for banned words and em-dashes. If any match, the tool result is blocked (exit 2) and Claude has to rewrite before the change lands.

**Banned patterns:**

| Pattern | Reason |
|---|---|
| `we`, `our team`, `the team` | Solopreneur voice — first person only |
| `leverage`, `unlock`, `empower`, `seamless`, `robust`, `utilize`, `delve`, `navigate`, `ecosystem` | Corporate-speak — plain English |
| `—` (em-dash) | Not used in publishable content |

The hook is **silent** outside the scoped paths (script source, agent profiles, missions, templates, ideation, archive, etc. all bypass). This is deliberate — the rules apply to what BOS-AI produces for users, not to the library source itself.

## Install

1. Copy `check-voice.sh` to your project's `.claude/hooks/` directory:

   ```bash
   mkdir -p .claude/hooks
   cp library/hooks/check-voice.sh .claude/hooks/
   chmod +x .claude/hooks/check-voice.sh
   ```

2. Add the hook block to `.claude/settings.json` under `hooks.PostToolUse[].hooks`:

   ```json
   {
     "type": "command",
     "if": "Edit(*.md)|Write(*.md)|MultiEdit(*.md)",
     "command": "bash .claude/hooks/check-voice.sh",
     "statusMessage": "voice check",
     "timeout": 10
   }
   ```

3. Restart your Claude Code session.

## Customise

Edit the `PATTERNS` array in `check-voice.sh` to add or remove banned words. Edit the `case` block to add or remove scoped paths.

## Test

```bash
mkdir -p /tmp/voice-test/blog
echo "We are excited to leverage our ecosystem." > /tmp/voice-test/blog/test.md
echo '{"tool_input":{"file_path":"/tmp/voice-test/blog/test.md"}}' \
  | bash .claude/hooks/check-voice.sh
echo "Exit: $?"
```

Expect exit code 2 and a list of matches.
