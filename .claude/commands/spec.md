---
description: Scaffold a new ADR-style spec at docs/specs/NNNN-<slug>.md and enter plan mode to fill the Design section
argument-hint: <kebab-case-slug>
---

Scaffold a new spec and drop into plan mode to design it.

## Arguments

The user has invoked `/spec` with these arguments: **$ARGUMENTS**

Treat `$ARGUMENTS` as the kebab-case slug for the new spec (e.g. `blog-section`, `language-toggle`, `remote-config-migration`). If `$ARGUMENTS` is empty, ask the user for a slug before proceeding.

## Steps

1. **Validate the slug.** It must be lowercase, hyphen-separated, no spaces, no leading digits, no file extension. If it isn't, correct it silently (lowercase + replace spaces/underscores with hyphens) and tell the user the normalized form you're using.

2. **Determine the next number.** Use the Glob tool on `docs/specs/[0-9][0-9][0-9][0-9]-*.md` to list existing specs. Parse the leading `NNNN` from each filename, take the max, add 1. If no specs exist, start at `0001`. Zero-pad to four digits.

3. **Read the template.** Read `docs/specs/README.md` and extract the markdown template block (fenced under a ` ```markdown ` fence). That block is the canonical template — do not improvise your own.

4. **Write the new file** at `docs/specs/NNNN-<slug>.md` using Write, substituting:
   - `NNNN — <Title>` → `NNNN — <Title From Slug>` (slug → Title Case, hyphens → spaces; leave `<Title>` if the slug is too cryptic and ask the user for a title).
   - `**Date:** YYYY-MM-DD` → today's date in `YYYY-MM-DD` (use the `currentDate` system context if available, otherwise ask).
   - `**Status:** draft | in-progress | shipped | superseded-by-NNNN` → `**Status:** draft`.
   - Leave all other template sections as-is (with their placeholder prose and empty bullet lists) for the user to fill.

5. **Report** the new file path to the user and ask whether they want you to enter plan mode now to collaboratively fill `## Context`, `## Requirements`, and `## Design`. If they say yes, use `ExitPlanMode`'s plan file (or the new spec file directly — plan mode can target the spec) to draft design thinking that lands in the spec rather than a throwaway plan.

## Rules

- Do not create any other files. Do not modify `docs/specs/README.md`.
- Do not commit the new spec — leave that to the user.
- Do not pre-fill `## Tasks` or `## Verification` with guesses; those emerge from `## Design`.
- If the slug collides with an existing spec slug, append `-v2` (or `-v3`, etc.) and warn the user.
- If the user supplies more than one word of freeform prose in `$ARGUMENTS` (e.g. `/spec add a blog section`), treat the first kebab-able token-group as the slug and use the rest as a hint for the title.
