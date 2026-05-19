# Roadmap

Living document for active and planned work on the portfolio. Updated as scope shifts.

> Format conventions:
> * Each item is one line, optionally followed by a short note.
> * Items move down the list as they progress: **Now → Next → Ideas → Done**.
> * Items that ship get a date stamp and a link to their spec or commit when relevant.
> * If an item outgrows a line, promote it to a spec at `docs/specs/NNNN-<slug>.md` and link the spec from here.

---

## Now (in flight)

* **`/ship-check` slash command**: Stage 3 of the harness rollout. Codifies the Post-Change Checklist (`slang` regen, `flutter analyze`, `flutter test`) into one command. Referenced from [CLAUDE.md §Post-Change Checklist](../CLAUDE.md) and [CLAUDE.md §Quality Gate](../CLAUDE.md). Spec pending.

---

## Next (planned, not started)

* **Portfolio content review**: validate descriptions, tech stack chips, and metrics for every entry in `lib/features/portfolio/domain/entities/project_data.dart`. Closed-source items rely on copy alone; cross-check claims against actual delivery.
* **Add `my_pet` / `foca` as projects**: public/private repos exist; needs preview images in `lib/app/assets/images/projects/`, `TypeEnum` entries for store URLs, and i18n strings in `en.i18n.json`.
* **SEO and metadata polish**: review `web/index.html` `<meta>` tags, Open Graph image, favicon, and structured data. The site is the first impression for recruiters; the head matters.
* **Analytics dashboards**: define the events worth tracking (section views, CTA clicks, project link-outs) and confirm they surface in Firebase Analytics with useful dimensions.

---

## Ideas (parking lot, not committed)

* **Localization beyond English**: slang already supports multi-locale; consider PT-BR once English copy stabilizes.
* **Animated section transitions**: explore beyond the current `ScrollFadeIn`; potential gains in perceived polish without sacrificing performance budgets.
* **CMS-driven projects**: let Remote Config drive the full project list (not just URLs) so adding a project does not require a code deploy. Trade-off: heavier startup + risk of broken state if Remote Config fetch fails.
* **Dark/light system-preference toggle**: currently manual via `ThemeCubit`; could auto-follow `MediaQuery.platformBrightness` on first load.

---

## Done (recent, newest first)

* **2026-05-19**: Fully automated release pipeline. Workflow now auto-bumps `pubspec.yaml` version (patch / minor / major based on Conventional-Commits prefix in last commit), tags `vX.Y.Z`, creates a GitHub Release with generated notes, and deploys to `gh-pages`. Concurrency control added so consecutive pushes queue instead of racing.
* **2026-05-19**: Featured + Other Projects copy refresh. All 13 entries got rewritten descriptions, more specific tech-chip arrays, and the Financo entry was corrected (was claiming Windows desktop / Melos / flutter_modular; actual stack is mobile+web BLoC / go_router / Vertex AI Gemini via Cloud Functions). README and `User-Facing Copy` rule (no em-dashes) added to CLAUDE.md.
* **2026-05-06**: Spec workflow shipped. Five specs land covering portfolio sections, Remote Config, theme system, loading bootstrap, and the test harness. See [docs/specs/](specs/).
* **Test harness**: Stages 1 and 2 shipped (`test/harness/` with `mocks.dart`, `helpers.dart`, `factories/`). Stage 3 (`/ship-check`) remains; see *Now*.

---

## How to use this file

* Before starting non-trivial work, move the item from **Next** to **Now**. If no entry exists, add one.
* When work ships, move it to **Done** with a date stamp.
* Periodically prune **Ideas**. The list is a parking lot, not a backlog. If something has not moved up in two months, ask whether it should still be here.
* For anything that fits in one PR with no design risk, you may skip the roadmap and go straight to a commit; the roadmap is for work whose shape benefits from being visible.
