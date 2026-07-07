# Current Status

Last updated: 2026-05-19

## Deployment State

Status: locally ready for landing-site deployment.

- Revamped portfolio landing builds to `build/landing/`.
- Old/main interactive app builds to `build/app/`.
- Firebase Hosting currently serves `build/landing`.
- Generated `.firebase/` cache files are ignored.
- Live Firebase deploy has not been run from this handoff.

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

Deploy the landing site after confirming the Firebase project:

```bash
firebase use
make deploy_web
```

## Last Verified Locally

- `flutter test`
- `flutter analyze --no-fatal-infos`
- `make build_landing`
- `make build_app`
- `git diff --check`

## Next Phase

Use `docs/ROADMAP.md` Phase 5 for product improvements:

- Add real project screenshots or product imagery.
- Keep production app proof inline unless a later content pass justifies dedicated case-study routes.
- Configure Firebase multi-site hosting before deploying the old/main app to `app.boonyongyang.dev`.
- Consider ForUI/shadcn package migration only after a Flutter/Dart SDK upgrade.
