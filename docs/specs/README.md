# Specs

Single-file, ADR-style specs for non-trivial changes in this repo. Each spec captures the **why**, **what**, and **how** of one coherent change so future readers (including future-you) can reconstruct the decision without digging through commit history.

## When to write a spec

Write a spec for:
- New portfolio sections (Hero/About/Projects/Resume/Skills/Contact-level features).
- New cross-cutting infrastructure (new Firebase service, new remote config pattern, routing changes, theme overhauls).
- Refactors that touch more than ~3 files or cross feature boundaries.
- Anything you'd want to explain twice.

Skip for:
- Typo fixes, dependency bumps, one-line bug fixes.
- Isolated cosmetic tweaks (padding, copy changes).
- Adding a new project entry via the existing `ProjectData` flow (the checklist in `CLAUDE.md` is sufficient).

## File naming

```
docs/specs/NNNN-slug.md
```

- `NNNN` — zero-padded, four-digit, **monotonic** (never reused, never reordered). Next spec = highest existing + 1.
- `slug` — kebab-case, concise, describes the change (not the status). Examples: `portfolio-sections`, `blog-section`, `language-toggle`, `remote-config-migration`.
- One spec per change. If a change outgrows a single file (~400 lines), split it by introducing follow-up specs that reference the original.

## Template

Copy the block below into a new `docs/specs/NNNN-slug.md` file. Once the `/spec` slash command lands (Stage 2 of the harness rollout), it will scaffold this automatically.

```markdown
# NNNN — <Title>

**Status:** draft | in-progress | shipped | superseded-by-NNNN
**Date:** YYYY-MM-DD

## Context

Why this change? What problem, opportunity, or constraint prompted it? What's the current state and what's missing or wrong? 2–5 short paragraphs.

## Requirements

What must be true when this is done. Bullet list of observable, testable statements — not implementation details.

- ...
- ...

## Design

How the change is structured. Call out:
- Files to be created, modified, or deleted (with paths).
- Existing utilities / widgets / entities being reused (`GlassCard`, `ResponsiveLayout`, `ScrollFadeIn`, `TypeEnum`, etc.).
- Data flow (UI → UseCase → Repository → Service).
- Theme tokens, i18n keys, Remote Config keys touched.
- Trade-offs considered and rejected (one line each).

For specs written before implementation, fill this section **in plan mode** so design thinking is preserved with the feature.

## Tasks

Ordered, checkable implementation steps. Granular enough that each one is a coherent commit.

- [ ] ...
- [ ] ...
- [ ] Run `dart run slang` (if i18n touched)
- [ ] Run `flutter analyze` — zero issues
- [ ] Verify all items in `## Verification`

## Verification

How to confirm the change works end-to-end. Mix of manual checks and (where applicable) tests.

- [ ] Manual: render at mobile / tablet / desktop breakpoints
- [ ] Manual: all i18n keys resolve (no raw keys visible)
- [ ] Manual: all Remote Config URLs launch correctly
- [ ] CI: `.github/workflows/deploy.yml` passes on the branch
```

## Workflow

1. Create `docs/specs/NNNN-slug.md` from the template (manually now; via `/spec` once it exists).
2. Fill `## Context` and `## Requirements`.
3. Enter plan mode and fill `## Design` — the plan file becomes the spec's design section.
4. Derive `## Tasks` from `## Design`; work through them one commit at a time.
5. Tick `## Verification` before marking the spec `shipped`.
6. If the approach materially changes during implementation, update the spec rather than letting it drift. If it becomes obsolete, mark it `superseded-by-NNNN` and point to the replacement.

## Current specs

See the files alongside this README. The index is the filesystem — no separate list to keep in sync.
