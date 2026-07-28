# Portfolio Revamp Roadmap

This is the working task list for the portfolio revamp and the dual-app command surface. Keep it updated when a phase starts, ships, or gets blocked.

## Current Status

- Active surface: revamped landing app at `lib/main_landing.dart`.
- Default run target: Flutter Web.
- Secondary target: active iOS Simulator only when iOS behavior needs checking.
- Current implementation state: design-system revamp is implemented; command docs, build outputs, and Firebase landing deployment config are aligned.
- Deployment state: Flutter landing, Flutter interactive app, and isolated
  Next.js + Three.js portfolio each have separate live Firebase Hosting sites.
  Custom `app` and `3d` subdomains remain pending DNS configuration.

## Phase 0 — Command Surface And Handoff

Status: complete

- [x] Document revamped landing vs old/main app entry points.
- [x] Make Flutter Web the default local run target.
- [x] Keep active-simulator-only commands documented as optional.
- [x] Include CocoaPods UTF-8 environment variables for simulator runs.
- [x] Add `make` shortcuts for run/build/test/analyze workflows.
- [x] Add a durable roadmap so future sessions do not restart from chat history.

Verification:

```bash
make help
make build_landing
git diff --check -- README.md docs/COMMANDS.md docs/PROJECT_DOCUMENTATION.md docs/landing/CONTENT_UPDATE_GUIDE.md docs/ROADMAP.md makefile
```

## Phase 1 — Visual QA Baseline

Status: complete

- [x] Run revamped landing on Flutter Web.
- [x] Capture desktop hero screenshot.
- [x] Capture mobile-width hero screenshot.
- [x] Capture production apps section screenshot.
- [x] Capture project index section screenshot.
- [x] Check all three themes: Studio Light, Midnight Zinc, Signal Amber.
- [x] Record screenshot paths and acceptance notes in this roadmap.

Evidence:

- `docs/landing/screenshots/phase1-desktop-hero-studio-light.png`
- `docs/landing/screenshots/phase1-mobile-hero-studio-light.png`
- `docs/landing/screenshots/phase1-desktop-production-apps-studio-light.png`
- `docs/landing/screenshots/phase1-desktop-project-index-studio-light.png`
- `docs/landing/screenshots/phase1-desktop-hero-midnight-zinc.png`
- `docs/landing/screenshots/phase1-desktop-hero-signal-amber.png`

Acceptance criteria:

- First viewport states name, role, availability, and primary action clearly.
- No generic glow-gradient hero.
- No nested cards or chip-heavy skill wall.
- Text fits on narrow mobile width.
- Theme contrast is readable in all presets.

## Phase 2 — Content And SEO Polish

Status: complete

- [x] Replace placeholder deployment domains in `build_apps.sh`.
- [x] Review `web/landing.html` SEO copy against current portfolio positioning.
- [x] Update manifest title/description/colors if deployment target changes.
- [x] Remove stale summary markdown files or move them under `docs/archive/`.
- [x] Refresh `DEPLOYMENT.md` for current dual-output web deployment.

Acceptance criteria:

- Public docs read like a portfolio repo, not generated setup notes.
- SEO metadata matches the actual portfolio copy.
- No obsolete “optimization summary” docs compete with the current roadmap.

## Phase 3 — Landing Code Hardening

Status: planned

- [ ] Add widget coverage for each theme preset.
- [ ] Add a focused test for web theme persistence fallback behavior.
- [ ] Review `LandingPageDataProvider` for unused legacy model surfaces.
- [ ] Remove or repurpose stale model fields that no active section reads.
- [ ] Confirm links launch through `UrlLauncherService` with valid URIs.

Acceptance criteria:

- Landing tests cover page render, theme switching, and core content assertions.
- No active landing section depends on legacy card/chip assumptions.
- Analyzer adds no new warning/error-level issues from landing code.

## Phase 4 — Deployment Readiness

Status: complete

- [x] Build revamped landing through `./build_apps.sh landing`.
- [x] Build old/main app through `./build_apps.sh app`.
- [x] Confirm Firebase hosting target and output directory are intentional.
- [x] Decide whether `build/web`, `build/landing`, or Firebase cache files should be ignored or committed.
- [x] Add release checklist for pre-deploy verification.

Verification:

```bash
flutter test
flutter analyze --no-fatal-infos
./build_apps.sh landing
./build_apps.sh app
git diff --check
dart format --set-exit-if-changed lib/apps/landing test/landing
```

Acceptance criteria:

- Build paths match the deploy docs.
- Generated artifacts do not pollute source control unexpectedly.
- Release checklist is short enough to run before every deploy.

## Phase 5 — Optional Product Improvements

Status: in progress

- [ ] Add visible project screenshots or product imagery where available.
- [ ] Add per-project case-study detail pages only if the landing page becomes too dense.
- [ ] Add lightweight analytics only if there is a clear privacy-safe use.
- [ ] Consider ForUI/shadcn package migration after Flutter/Dart SDK upgrade.
- [x] Configure separate Firebase Hosting site IDs for the Flutter landing and interactive app.
- [x] Add a cross-surface Versions selector linking every deployed surface.
- [ ] Connect `app.boonyongyang.com` and `3d.boonyongyang.com` after their DNS records are added.

Verification:

```bash
dart format lib/apps/landing test/landing
flutter test test/landing/landing_app_test.dart
flutter analyze --no-fatal-infos
make build_landing
```

Acceptance criteria:

- Improvements increase credibility without returning to a decorative showcase feel.
- No package upgrade blocks the current Flutter SDK unless intentionally planned.
