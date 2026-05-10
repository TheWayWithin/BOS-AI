# BOS-AI Routines

Routine templates for **scheduled** BOS-AI work. Run on Anthropic-managed cloud at **https://claude.ai/code/routines**, not via slash commands.

| Routine | Cadence | Purpose |
|---|---|---|
| `dailyreport.md` | Daily (evening) | Generate day's report + blog/social posts from `progress.md` |

## When to use a Routine vs a slash command

| Pattern | Use |
|---|---|
| Recurring on a clock — "every day at 9pm", "every Monday" | **Routine** |
| Event-driven on demand — "draft a blog post about X" | **Slash command** |

This is the AGENT-11 v6 empirical lesson #4 baked in: `/dailyreport` is scheduled (Routine candidate), `/blog` is event-driven (stays a slash command). Don't lump them together.

## Setup

1. Open the routine template you want to use.
2. Copy the "Routine prompt" section.
3. Create a new routine at `claude.ai/code/routines` and paste.
4. Set the schedule (cron-style).
5. Point at the project repository.
6. Enable.

The routine runs unattended. Output lands in the repo on schedule.

## Customise

Edit the prompt inline at claude.ai/code/routines, or fork the template here and reference your fork in the routine. Both work.
