# Current Status

Last updated: 2026-07-28

## Deployment State

Status: all three isolated web surfaces were redeployed and publicly verified on
2026-07-28; only the optional custom app and 3D subdomains remain pending DNS
setup.

- Revamped portfolio landing builds to `build/landing/`.
- Flutter interactive app builds to `build/app/`.
- Flutter landing is served by `boonyongyang` at `https://boonyongyang.web.app`.
- Flutter interactive app is served independently by `boonyongyang-app` at
  `https://boonyongyang-app.web.app`.
- Next.js + Three.js portfolio is served independently by
  `boonyongyang-3d` at `https://boonyongyang-3d.web.app`.
- The previous `boonyongyang-portfolio-3d.web.app` URL redirects permanently to
  the shorter canonical URL.
- `boonyongyang.com` currently redirects to the Flutter landing origin.
- `app.boonyongyang.com` and `3d.boonyongyang.com` do not have DNS records yet.
- The Flutter landing, Flutter interactive app, and Next.js + Three.js headers
  expose the same hidden layers control. It separates the three deployed
  portfolio versions from the Release Bench, Field Manual, and Store Review
  Room themes within the 3D portfolio.
- Private release repositories now preserve both codebases, and their clean
  Linux CI pipelines pass.
- Generated `.firebase/` cache files are ignored.

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

## Last Verified Locally On 2026-07-28

- `flutter test`: 51 tests passed.
- `flutter analyze --no-fatal-infos`: no issues found.
- `dart format --output=none --set-exit-if-changed lib test`: passed.
- `make build_all`: both release web bundles built successfully.
- Desktop and mobile release-bundle screenshots were inspected for both Flutter
  surfaces, including the compact selector placement.
- The isolated 3D portfolio passed `npm run check` and `npm run verify`: 50
  browser tests passed with 16 intentional project-specific skips, including
  all three themes on desktop, tablet, mobile, reduced motion, and WebGL
  fallback.
- `git diff --check`
- Production smoke checks for all three `.web.app` origins
- Fresh deployed-bundle checks found all three 3D theme labels and canonical
  theme paths on both Flutter surfaces.
- Firebase Hosting released 41 landing files, 40 interactive-app files, and 78
  isolated 3D files.
- Flutter GitHub Actions run `30329836705` passed analysis, 51 tests,
  formatting, and both release web builds.
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
