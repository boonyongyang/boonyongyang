# Current Status

Last updated: 2026-08-22

## Deployment State

Status: all four isolated portfolio surfaces are live. The Flutter landing was
refreshed and all four versions were publicly reverified on 2026-08-22; only
the optional custom app and 3D subdomains remain pending DNS setup.

- Revamped portfolio landing builds to `build/landing/`.
- Flutter interactive app builds to `build/app/`.
- Flutter landing is served by `boonyongyang` at `https://boonyongyang.web.app`.
- Flutter interactive app is served independently by `boonyongyang-app` at
  `https://boonyongyang-app.web.app`.
- Next.js + Three.js portfolio is served independently by
  `boonyongyang-3d` at `https://boonyongyang-3d.web.app`.
- V4 Release Dossier is served independently by `boonyongyang-v4` at
  `https://boonyongyang-v4.web.app`.
- The previous `boonyongyang-portfolio-3d.web.app` URL redirects permanently to
  the shorter canonical URL.
- `boonyongyang.com` currently redirects to the Flutter landing origin.
- `app.boonyongyang.com` and `3d.boonyongyang.com` do not have DNS records yet.
- The Flutter landing, Flutter interactive app, Next.js + Three.js portfolio,
  and V4 Release Dossier expose the same hidden layers control. It separates
  the four deployed portfolio versions from the Release Bench, Field Manual,
  and Store Review Room themes within the 3D portfolio.
- Private release repositories now preserve both codebases, and their clean
  Linux CI pipelines pass.
- Generated `.firebase/` cache files are ignored.
- Refreshed interactive-app URLs now initialize from the requested browser path
  instead of silently returning to Home.
- Public landing proof uses current, durable product facts and canonical Cashiu,
  Involve Asia, GitHub, and media destinations.
- Both production case studies include approved App Store evidence rendered at
  its source aspect ratio across phone, tablet, laptop, and wide desktop widths.
- Decorative motion respects the reduced-motion preference, and primary
  navigation uses accessible button semantics and a compact layout below 1024px.
- The reduced-motion interactive-home hero uses a deterministic decorative
  palette, so layout regressions are not invalidated by random color state.

## Primary Commands

```bash
make run_landing_web
make build_landing
make build_app
make build_all
make analyze
make test
make format_check
```

Deploy one surface explicitly after confirming the Firebase project:

```bash
firebase use
make deploy_landing
make deploy_app
```

## Last Verified On 2026-08-22

- The landing, interactive app, Next.js + Three.js portfolio, all three 3D
  theme routes, and V4 returned HTTP 200 in a fresh public availability check.
- Firebase Hosting previously released 45 landing files, and all four deployed
  product-image URLs returned HTTP 200 during the release closure.
- The focused public browser pass matched the reviewed desktop/mobile evidence
  screenshots and contained all four product images at 320, 390, 768, 1024,
  1440, and 1920 pixel widths: 3 checks passed with 1 intentional duplicate
  project skip.
- Flutter commit `07d96dd` is deployed. GitHub Actions run `32478674724`
  passed analysis, all 72 tests, formatting, both production builds, and all
  15 Linux layout comparisons with 1 intentional duplicate matrix skip.
- V4 commit `18db24c` remains deployed. GitHub Actions run `31852110551`
  passed, and the fresh local release pass completed with 34 browser checks and
  5 intentional project-specific skips.
- V3 commit `80097f9` is the final release-closure head. GitHub Actions run
  `32477777240` passed its quality and Chromium verification jobs; the fresh
  local quality, static-build, link, metadata, and hosting gates passed with
  63 browser checks and 21 intentional viewport/project skips.

Earlier release-repair evidence remains valid:

- `flutter test --coverage`: 67 tests passed.
- `flutter analyze --no-fatal-infos`: no issues found.
- `dart format --set-exit-if-changed .`: 129 files checked with no changes.
- `make build_all`: both release web bundles built successfully.
- Eleven public GitHub, App Store, Google Play, and Giphy destinations returned
  HTTP 200.
- The deployed Flutter landing hero and complete Versions/3D themes menu were
  visually inspected in the in-app browser.
- Direct production entry and refresh checks passed for `/maps`,
  `/charts/candle`, `/plays/connect4`, `/plays/brick-breaker`, and `/about` on
  the canonical interactive-app origin with zero console errors. Automated
  routing tests cover all ten non-home public paths.
- The web map uses native Flutter OSM tiles with pan, zoom, a Kuala Lumpur
  marker, and contributor attribution; the mobile app retains its platform map
  implementation.
- Firebase Hosting released 41 landing files and 40 interactive-app files.
- Flutter GitHub Actions run `30694027921` passed analysis, all 67 tests,
  formatting, and both release web builds for the final deployed commit.
- The isolated 3D portfolio passed `npm run check` and `npm run verify`: 50
  browser tests passed with 16 intentional project-specific skips, including
  all three themes on desktop, tablet, mobile, reduced motion, and WebGL
  fallback.
- 3D GitHub Actions run `30329836775` passed quality gates and the complete
  Chromium verification job with retained evidence.
- All three theme routes returned HTTP 200 after deployment. A focused public
  Playwright run passed the selector and three-theme contract on desktop,
  tablet, and mobile: 6 tests passed.

## Next Phase

Use `docs/ROADMAP.md` Phase 5 for product improvements:

- Keep production app proof inline unless a later content pass justifies dedicated case-study routes.
- Connect `app.boonyongyang.com` to the deployed `boonyongyang-app` site.
- Connect `3d.boonyongyang.com` to the existing `boonyongyang-3d` site.
- Consider ForUI/shadcn package migration only after a Flutter/Dart SDK upgrade.
- Add privacy-safe analytics only when there is a concrete measurement goal.
