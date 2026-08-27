# Portfolio Revamp Roadmap

This is the working task list for the portfolio revamp and the dual-app command surface. Keep it updated when a phase starts, ships, or gets blocked.

## Current Status

- Active surface: revamped landing app at `lib/main_landing.dart`.
- Default run target: Flutter Web.
- Secondary target: active iOS Simulator only when iOS behavior needs checking.
- Current implementation state: design-system revamp is implemented; command docs, build outputs, and Firebase landing deployment config are aligned.
- Deployment state: Flutter landing, Flutter interactive app, isolated Next.js
  + Three.js portfolio, and V4 Release Dossier each have separate live Firebase
  Hosting sites. Custom `app` and `3d` subdomains are connected. The V4 custom
  domain is associated and its DNS record is public, with certificate
  provisioning still pending.

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

Status: complete

- [x] Add widget coverage for each theme preset.
- [x] Add a focused test for web theme persistence fallback behavior.
- [x] Review `LandingPageDataProvider` for unused legacy model surfaces.
- [x] Remove or repurpose stale model fields that no active section reads.
- [x] Confirm links launch through `UrlLauncherService` with valid URIs.

Acceptance criteria:

- Landing tests cover page render, theme switching, and core content assertions.
- No active landing section depends on legacy card/chip assumptions.
- Analyzer adds no new warning/error-level issues from landing code.

Evidence (2026-08-21): restricted-storage reads and writes are covered by a
pure fallback guard; unused feature, technical-skill, utility, and model fields
were removed; all 72 Flutter tests passed; and analysis reported no issues.

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

- [x] Add visible project screenshots or product imagery where available.
- [ ] Add per-project case-study detail pages only if the landing page becomes too dense.
- [x] Add privacy-safe, provider-optional analytics for version, theme, project,
      profile, and contact-intent measurement without personal-data parameters.
- [ ] Consider ForUI/shadcn package migration after Flutter/Dart SDK upgrade.
- [x] Configure separate Firebase Hosting site IDs for the Flutter landing and interactive app.
- [x] Add a cross-surface Versions selector linking every deployed surface.
- [x] Add and deploy V4 Release Dossier as the fourth isolated portfolio
      surface.
- [x] Add a separate 3D themes group linking Release Bench, Field Manual, and
      Store Review Room from both Flutter surfaces.
- [x] Connect `app.boonyongyang.com` and `3d.boonyongyang.com` with verified
      Squarespace DNS and Firebase-managed TLS.
- [x] Add cross-surface production monitoring, machine-readable evidence,
      TLS-expiry checks, and bundle budgets.
- [x] Define the quarterly maintenance routine and the decision gate for V5.

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

## Phase 6 — Public Release Repair

Status: complete (2026-08-01)

- [x] Preserve and refresh every public interactive-app route.
- [x] Replace stale or unsupported public metrics with durable product proof.
- [x] Update Cashiu naming and both mobile-store destinations.
- [x] Repair the Flutter starter-kit repository link and remove the broken GIF.
- [x] Respect reduced-motion preferences across decorative and autoplay motion.
- [x] Use accessible navigation controls and prevent medium-width overflow.
- [x] Replace the blank web map platform view with rendered OSM tiles and
      preserve the mobile map implementation.
- [x] Add regressions for direct routes, public copy, destinations, and motion.
- [x] Deploy both Flutter Hosting targets and verify live rendered routes.

Verification:

```bash
flutter analyze --no-fatal-infos
flutter test --coverage
dart format --set-exit-if-changed .
make build_all
```

## Phase 7 — Automated Layout Regression

Status: complete

- [x] Add browser-level pixel baselines for both deployed Flutter surfaces.
- [x] Compare the landing hero in Studio Light, Midnight Zinc, and Signal Amber.
- [x] Compare the hidden Versions selector on desktop and mobile.
- [x] Compare representative interactive-app routes at desktop and mobile widths.
- [x] Run structural overflow and viewport-containment assertions before pixels.
- [x] Add one review/update command and one fail-on-diff command.
- [x] Run the visual suite on every push and pull request and retain diff artifacts.
- [x] Record clean local and Linux CI evidence for the committed baseline set.

Evidence (2026-08-21): local Flutter analysis, all 72 tests, formatting, both
web builds, and all 15 desktop/mobile visual comparisons passed with 1
intentional duplicate matrix skip. The added product-evidence matrix covered
320, 390, 768, 1024, 1440, and 1920 pixel widths. GitHub Actions run
`32477214371` passed both Ubuntu jobs and retained the reviewed Linux evidence.
The focused public run then passed the same product screenshot and width-matrix
checks against `https://boonyongyang.web.app`.

Verification:

```bash
make visual_get
make visual_install_browser
make visual_test
```

Use `make visual_update` only after intentionally reviewing a layout change.
Never update baselines merely to make a failure disappear.
