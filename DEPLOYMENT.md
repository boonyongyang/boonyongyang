# Deployment Guide

This project builds two separate Flutter Web outputs:

| Surface | Entry point | Output | Intended host |
|---|---|---|---|
| Revamped Flutter portfolio | `lib/main_landing.dart` | `build/landing/` | `boonyongyang.com` and `boonyongyang.web.app` |
| Flutter interactive app | `lib/main_app.dart` | `build/app/` | `boonyongyang-app.web.app`; future `app.boonyongyang.com` |
| Next.js + Three.js portfolio | isolated repository | `portfolio-3d-next/out/` | `boonyongyang-3d.web.app`; future `3d.boonyongyang.com` |

## Build Commands

Build the landing site:

```bash
make build_landing
```

Build the app surface:

```bash
make build_app
```

Build both:

```bash
make build_all
```

`make build_all` calls `./build_apps.sh all`, which writes:

```text
build/
├── landing/
└── app/
```

## Configurable Build Values

`build_apps.sh` uses production defaults but can be overridden per deploy:

```bash
SITE_URL=https://boonyongyang.com \
APP_URL=https://boonyongyang-app.web.app \
PORTFOLIO_3D_URL=https://boonyongyang-3d.web.app \
GITHUB_URL=https://github.com/boonyongyang \
LINKEDIN_URL=https://linkedin.com/in/boonyongyang \
./build_apps.sh landing
```

Defaults:

| Variable | Default |
|---|---|
| `SITE_URL` | `https://boonyongyang.com` |
| `APP_URL` | `https://boonyongyang-app.web.app` |
| `PORTFOLIO_3D_URL` | `https://boonyongyang-3d.web.app` |
| `GITHUB_URL` | `https://github.com/boonyongyang` |
| `LINKEDIN_URL` | `https://linkedin.com/in/boonyongyang` |

## Static Hosting

Deploy `build/landing/` and `build/app/` to their separate Firebase Hosting site IDs. Never deploy the parent configuration without an explicit `--only hosting:<site>` selector.

For any single-page-app host, configure rewrites so all routes fall back to `/index.html`.

## Firebase Hosting

The parent `firebase.json` declares two isolated Firebase Hosting sites:

```json
{
  "hosting": [
    {
      "site": "boonyongyang",
      "public": "build/landing",
      "ignore": ["firebase.json", "**/.*", "**/node_modules/**"],
      "rewrites": [{ "source": "**", "destination": "/index.html" }]
    },
    {
      "site": "boonyongyang-app",
      "public": "build/app",
      "ignore": ["firebase.json", "**/.*", "**/node_modules/**"],
      "rewrites": [{ "source": "**", "destination": "/index.html" }]
    }
  ]
}
```

The 3D portfolio keeps its own `firebase.json` inside `portfolio-3d-next/` and deploys only to `boonyongyang-3d`. The previous `boonyongyang-portfolio-3d` site redirects to the shorter canonical URL. The parent repository ignores that standalone repository so Flutter analysis and Git staging cannot absorb it accidentally.

Explicit production commands:

```bash
make deploy_landing
make deploy_app
cd portfolio-3d-next && npm run deploy:firebase
```

The custom-domain plan is:

| Host | Firebase site | State |
|---|---|---|
| `boonyongyang.com` | `boonyongyang` | Existing |
| `app.boonyongyang.com` | `boonyongyang-app` | Add after the site is deployed and DNS is configured |
| `3d.boonyongyang.com` | `boonyongyang-3d` | Add after DNS is configured |

The `.web.app` origins remain permanent fallbacks, so adding custom domains does not replace a version.

Every surface exposes the same hidden layers control. Its first group contains
the three independently deployed portfolio versions. Its second group contains
the three shareable themes within the Next.js + Three.js version:

| 3D theme | Canonical route |
|---|---|
| Release Bench | `https://boonyongyang-3d.web.app/themes/release-bench/` |
| Field Manual | `https://boonyongyang-3d.web.app/themes/field-manual/` |
| Store Review Room | `https://boonyongyang-3d.web.app/themes/review-room/` |

Desktop headers show the control label where space allows, while compact
layouts retain the accessible layers icon. The Next.js selector identifies both
the current application version and the active 3D theme.

## Pre-Deploy Checklist

Run:

```bash
make analyze
make test
make build_all
git diff --check
```

Then check:

- `build/landing/index.html` loads the landing site.
- `build/landing/robots.txt` contains the correct `SITE_URL`.
- `build/app/index.html` loads the old/main interactive app.
- No generated `build/` or `.firebase/` artifacts are staged.
- `docs/ROADMAP.md` has current deployment-readiness status.

Deploy the landing site:

```bash
make deploy_landing
make deploy_app
```

Deploy a preview channel:

```bash
make deploy_web_channel CHANNEL=preview-name
```
