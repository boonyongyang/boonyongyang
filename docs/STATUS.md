# Current Status

Last updated: 2026-10-07

## Deployment State

Status: all six independent portfolio editions are live on dedicated Firebase
Hosting sites and custom HTTPS domains. The shared selector exposes V1 through
V6, while the three V3 themes remain a separate group.

- Revamped portfolio landing builds to `build/landing/`.
- Flutter interactive app builds to `build/app/`.
- Flutter landing is served by `boonyongyang` at `https://boonyongyang.web.app`.
- Flutter interactive app is served independently by `boonyongyang-app` at
  `https://app.boonyongyang.com`, with `https://boonyongyang-app.web.app` as a
  permanent fallback.
- Next.js + Three.js portfolio is served independently by
  `boonyongyang-3d` at `https://3d.boonyongyang.com`, with
  `https://boonyongyang-3d.web.app` as a permanent fallback.
- V4 Release Dossier is served independently by `boonyongyang-v4` at
  `https://v4.boonyongyang.com`, with `https://boonyongyang-v4.web.app` as its
  permanent fallback.
- V5 Wildfield is served independently by `boonyongyang-v5` at
  `https://v5.boonyongyang.com`, with `https://boonyongyang-v5.web.app` as its
  permanent fallback.
- V6 Afterimage is served independently by `boonyongyang-v6` at
  `https://v6.boonyongyang.com`, with `https://boonyongyang-v6.web.app` as its
  permanent fallback.
- The previous `boonyongyang-portfolio-3d.web.app` URL redirects permanently to
  the branded canonical URL.
- `boonyongyang.com` currently redirects to the Flutter landing origin.
- Squarespace DNS and Firebase Hosting associations are configured for all six
  canonical domains with publicly valid Firebase-managed TLS.
- Every edition exposes the same hidden layers control. It separates the six
  deployed portfolio versions from the Release Bench, Field Manual, and Store
  Review Room themes within the 3D portfolio.
- Isolated release repositories preserve V3 through V6, and their clean Linux
  CI pipelines pass.
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
- All six editions now share a privacy-safe analytics event contract. The
  provider loader stays disabled until an owner supplies a GA4 measurement ID;
  the deployed default makes no analytics request.
- Every edition publishes canonical, social, structured-data, robots, and
  sitemap contracts with optional Search Console verification injection.
- Bundle budgets guard every independently built edition. The scheduled
  production smoke retains a machine-readable JSON report and checks branded
  TLS expiry.
- Firebase Hosting connects `v4.boonyongyang.com` to V4, Squarespace publishes
  `CNAME v4 -> boonyongyang-v4.web.app`, and Firebase-managed TLS validates.

## V6 Release Verified On 2026-10-07

| Edition | Canonical | Public runtime commit | Release evidence |
| ------- | --------- | --------------------- | ---------------- |
| V1 Editorial | `https://boonyongyang.com` | `1cc599849377d171a887ea92ed1b2af1483344fa` | 74 Flutter tests, 17 visual checks, one intentional matrix skip, and public smoke passed |
| V2 Interactive | `https://app.boonyongyang.com` | `1cc599849377d171a887ea92ed1b2af1483344fa` | Same isolated Flutter release gates and public route smoke passed |
| V3 Next.js + Three.js | `https://3d.boonyongyang.com` | `ec31f11856d2a08973d9a7379c18d3bb63cbdf1e` | [CI run 37548096904](https://github.com/boonyongyang/boonyongyang-portfolio-3d/actions/runs/37548096904) passed; production audit reports zero vulnerabilities |
| V4 Release Dossier | `https://v4.boonyongyang.com` | `7235849847bd1ab92d4031a75027b63a57243e5b` | [CI run 37546685018](https://github.com/boonyongyang/boonyongyang-portfolio-v4/actions/runs/37546685018) passed at reviewed baseline commit `c8e56e6518c8090f22cda99b83322d1c9f5f0378` |
| V5 Wildfield | `https://v5.boonyongyang.com` | `4c41297d021f4cbaf4ab02ae85ba9abad94a4184` | [CI run 37545961686](https://github.com/boonyongyang/boonyongyang-portfolio-v5/actions/runs/37545961686) passed |
| V6 Afterimage | `https://v6.boonyongyang.com` | `28002f975851c6d2a37f03c1632ecd629ec30834` | [Final evidence CI run 37547381068](https://github.com/boonyongyang/boonyongyang-portfolio-v6/actions/runs/37547381068) passed; evidence head `9c7e5b3e42e47c4d760fdaa5fb5f8e9a5d9af5b9` |

- V6 Afterimage is live at `https://v6.boonyongyang.com`; its fallback and
  custom canonical both return HTTP 200 with valid TLS, security headers,
  canonical metadata, JSON-LD, robots, and sitemap contracts.
- V6 `npm run check` and `npm run verify` passed source, formatting, bundle,
  accessibility, responsive, GSAP cleanup, performance, and visual gates. The
  public custom-domain browser suite passed 21 checks across desktop, tablet,
  and mobile.
- V1 through V5 were rebuilt and released with the six-edition selector. V3
  retains Release Bench, Field Manual, and Store Review Room as a separate
  theme group.
- Squarespace publishes `CNAME v5 -> boonyongyang-v5.web.app` and
  `CNAME v6 -> boonyongyang-v6.web.app`; both branded origins return HTTP 200
  with valid Firebase-managed TLS.
- The shared production smoke validates all custom and fallback origins,
  cross-edition navigation, analytics assets, canonical metadata, redirects,
  and TLS expiry. Its final release run passed all 38 checks.

## Release Hardening Verified On 2026-08-28

- Flutter analysis passed with no issues; all 74 tests passed.
- Both Flutter production builds passed metadata, discovery, analytics, and
  bundle contracts. The screenshot matrix passed 17 checks with 1 intentional
  duplicate matrix skip.
- V3 `npm run check` passed all quality, export, metadata, hosting, bundle, and
  public-link gates. Its complete browser matrix passed 66 checks with 21
  intentional capability or viewport skips.
- V4 `npm run check` passed source, formatting, build, and bundle gates. Its
  complete responsive and screenshot matrix passed 37 checks with 5
  intentional project-specific skips.
- The public smoke passed every route, redirect, content, and TLS check. DNS and
  HTTPS for `v4.boonyongyang.com` are publicly valid.

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

## Last Verified On 2026-08-23

- Squarespace publishes `app` and `3d` CNAME records to their isolated
  Firebase Hosting sites. Both branded origins return HTTP 200 with valid TLS;
  the permanent `web.app` fallbacks also return 200.
- The branded 3D root and Release Bench, Field Manual, and Store Review Room
  routes return HTTP 200. The old long 3D origin returns HTTP 301 to
  `https://3d.boonyongyang.com` for both root and unknown paths.
- Flutter commit `8883e97` is deployed to the landing and interactive-app
  sites. Analysis, all 72 tests, formatting, both production builds, and the
  screenshot matrix passed with 15 comparisons and 1 intentional skip.
- V3 commit `195fa8f` is deployed. `npm run check` passed all outbound links,
  metadata, Hosting, bundle, and static-build gates; `npm run verify` passed 63
  browser checks with 21 intentional project-specific skips.
- V4 commit `a3a23ad` is deployed. Its source/build gates and browser suite
  passed with 34 checks and 5 intentional project-specific skips.
- Exact-head GitHub Actions passed for Flutter run `32645614958` and V4 run
  `32645591992`; the V3 run is `32645742477`.

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
- Consider ForUI/shadcn package migration only after a Flutter/Dart SDK upgrade.
- Activate GA4 only after the owner selects a property and supplies its public
  measurement ID.
- Complete Search Console ownership only after the owner supplies or authorizes
  the provider verification token.
