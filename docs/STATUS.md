# Current Status

Last updated: 2026-08-15

## Deployment State

Status: all four isolated portfolio surfaces are live. V4, V3, and both Flutter
surfaces were deployed and publicly verified on 2026-08-15; only the optional
custom app and 3D subdomains remain pending DNS setup.

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
- Decorative motion respects the reduced-motion preference, and primary
  navigation uses accessible button semantics and a compact layout below 1024px.

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

## Last Verified On 2026-08-15

- The Flutter landing, Flutter interactive app, Next.js + Three.js portfolio,
  all three 3D theme routes, and V4 returned HTTP 200 after deployment.
- The public V4 build serves self-hosted Archivo and IBM Plex Mono WOFF2 assets
  with HTTP 200, a seven-day asset cache policy, and a revalidating homepage.
- Public release files on all four surfaces contain the canonical
  `https://boonyongyang-v4.web.app` version destination.
- V4 GitHub Actions run `31830424404` passed the source, production audit,
  build, and complete Chromium verification jobs with reviewed desktop,
  tablet, mobile, and full-page baselines.
- V3 GitHub Actions run `31830721418` passed the quality and complete Chromium
  jobs after its reviewed desktop and mobile four-version selector baselines
  were recorded.
- Flutter GitHub Actions run `31822466481` passed analysis, 67 tests,
  formatting, release builds, and all 12 desktop/mobile visual comparisons.

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

- Add real project screenshots or product imagery.
- Keep production app proof inline unless a later content pass justifies dedicated case-study routes.
- Connect `app.boonyongyang.com` to the deployed `boonyongyang-app` site.
- Connect `3d.boonyongyang.com` to the existing `boonyongyang-3d` site.
- Consider ForUI/shadcn package migration only after a Flutter/Dart SDK upgrade.
- Refresh GitHub Actions from Node 20-based action runtimes before GitHub stops
  forcing them onto Node 24.
