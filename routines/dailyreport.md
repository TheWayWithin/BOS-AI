# Routine: /dailyreport

Scheduled variant of the `/dailyreport` slash command. Runs on an Anthropic-managed cloud schedule (claude.ai/code/routines) instead of being triggered manually. Same logic, different invocation.

Per BOS-AI v2.1 Blueprint §2.6 and AGENT-11 v6 empirical lesson #4: `/dailyreport` is scheduled-cadence work, so it gets a Routine. `/blog` is event-driven (on-demand topic) and stays a slash command — there is no `/blog` Routine.

---

## What it does

Reads today's `progress.md` (and any related logs) for the current BOS-AI / AGENT-11 project, then produces:

- **Daily report** (`progress/YYYY-MM-DD.md`) — structured changelog of what shipped today
- **Blog post** (`blog/YYYY-MM-DD-<slug>.md`) — long-form voice-aligned post if the day's work warrants one
- **Twitter/X post** (`progress/YYYY-MM-DD-twitter.md` and matching blog twitter file) — short hook
- **LinkedIn post** (matching `-linkedin.md`) — 800-1000 char professional version
- **wip.co changelog line** (`progress/YYYY-MM-DD-wip.md`) — one-line update

All artifacts use the same voice guide resolution chain as the slash command. See `commands/dailyreport.md` for the full chain.

---

## Setup

1. Open the routine in this template.
2. Paste it into a new routine at **https://claude.ai/code/routines**.
3. Set the schedule. Suggested: `0 21 * * *` (every evening at 9pm local time).
4. Point the routine at the project repository (BOS-AI or whichever business you want daily reports for).
5. Save and enable.

---

## Routine prompt (copy this into the routine body)

```
Run /dailyreport for this project.

If today's progress.md has substantive entries (more than just whitespace or housekeeping commits), produce all five artifacts (daily report, blog post, Twitter/X, LinkedIn, wip.co changelog) and write them to the standard paths under progress/ and blog/.

If today was a no-meaningful-work day (no commits affecting business logic, no shipped features, no learnings worth posting), produce only the daily report (progress/YYYY-MM-DD.md) noting "no public-facing output today" and skip the blog and social posts entirely. Do not invent content.

Follow the voice guide chain documented in commands/dailyreport.md. Constitution §3 (solopreneur voice) applies: first person, no corporate-speak, no em-dashes in published content. The voice-check hook (library/hooks/check-voice.sh) will block violations in scoped paths.

When complete, commit the generated files to the repo and push. If the working tree has uncommitted changes from the day's work that aren't yet on main, do NOT commit on behalf of the user — flag those in the daily report and stop.
```

---

## Why a Routine instead of cron

- **Anthropic-managed cloud** — survives laptop sleep, no local dependencies
- **Authenticated sessions** — git push works without manual credential handling
- **Same Claude model** as your interactive sessions — voice consistency
- **Visible in claude.ai** — you see what ran and when

If Routines is unavailable in your account/region, fall back to running `/dailyreport` manually at end-of-day or wiring a local cron to launch a Claude Code session with the prompt above.

---

## Variants

You can clone this routine for multiple projects (run a separate routine per business). Or set up a single weekly routine using the `/coord weekly-review` mission for a deeper roll-up every Friday.
