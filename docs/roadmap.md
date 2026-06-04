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
* **Add `my_pet` / `foca` as projects**: public/private repos exist; needs preview images in `lib/app/assets/images/projects/`, URL constants on `AppConstants`, and i18n strings in `en.i18n.json`.
* **SEO and metadata polish**: review `web/index.html` `<meta>` tags, Open Graph image, favicon, and structured data. The site is the first impression for recruiters; the head matters.
* **Decide on analytics**: Firebase Analytics was removed (it was wired but never attached, see [spec 0006](specs/0006-remove-firebase-remote-config.md)). If page-view / CTA tracking is wanted, re-add a lightweight analytics layer deliberately and wire the observer into `go_router`.

---

## Ideas (parking lot, not committed)

* **Localization beyond English**: slang already supports multi-locale; consider PT-BR once English copy stabilizes.
* **Animated section transitions**: explore beyond the current `ScrollFadeIn`; potential gains in perceived polish without sacrificing performance budgets.
* **CMS-driven projects**: drive the full project list from a backend so adding a project does not require a code deploy. Trade-off: heavier startup + risk of broken state if the fetch fails. Note: Remote Config was removed in [spec 0006](specs/0006-remove-firebase-remote-config.md); this would mean re-introducing a runtime data source, so weigh it against the simplicity won by going all-constants.
* **Dark/light system-preference toggle**: currently manual via `ThemeCubit`; could auto-follow `MediaQuery.platformBrightness` on first load.

---

## Done (recent, newest first)

* **2026-06-04**: Faster web cold load. Instant HTML splash in `web/index.html` (no blank white frame), self-hosted + Latin-subset fonts (dropped `google_fonts`, killed the runtime `fonts.gstatic.com` fetch + FOUT), dropped `font_awesome_flutter` (only GitHub/LinkedIn marks used, now vendored SVGs via `flutter_svg`), and `--wasm` production build (skwasm with CanvasKit JS fallback). Net: cold-load transfer 2.57MB to 1.27MB, broadband first frame ~3.0s to ~2.25s. See [spec 0007](specs/0007-faster-web-load.md).
* **2026-06-04**: Removed Firebase + Remote Config; faster load. Deleted `firebase_core` / `firebase_analytics` / `firebase_remote_config`, the `lib/core/remote_config/` module, `AppDependencies`, and `firebase_options.dart`. Outbound URLs are now `AppConstants` constants. Loading splash floor dropped from 1800ms to 700ms and no longer blocks on a network fetch. See [spec 0006](specs/0006-remove-firebase-remote-config.md).
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
