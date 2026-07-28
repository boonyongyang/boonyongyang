# Current Status

Last updated: 2026-07-28

## Deployment State

Status: three isolated web surfaces are available; custom app and 3D subdomains remain pending DNS setup.

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
  expose the same Versions selector and identify the current surface.
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

- `flutter test`: 50 tests passed.
- `flutter analyze --no-fatal-infos`: no issues found.
- `dart format --output=none --set-exit-if-changed lib test`: passed.
- `make build_all`: both release web bundles built successfully.
- Desktop and mobile release-bundle screenshots were inspected for both Flutter
  surfaces, including the compact selector placement.
- The isolated 3D portfolio passed `npm run check` and `npm run verify`: 45
  browser tests passed with 12 intentional project-specific skips.
- `git diff --check`
- Production smoke checks for all three `.web.app` origins
- Deployed landing-bundle check for the Flutter app and 3D portfolio links

## Next Phase

Use `docs/ROADMAP.md` Phase 5 for product improvements:

- Add real project screenshots or product imagery.
- Keep production app proof inline unless a later content pass justifies dedicated case-study routes.
- Connect `app.boonyongyang.com` to the deployed `boonyongyang-app` site.
- Connect `3d.boonyongyang.com` to the existing `boonyongyang-3d` site.
- Consider ForUI/shadcn package migration only after a Flutter/Dart SDK upgrade.
