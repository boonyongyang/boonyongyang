# Deployment Guide

This project builds two separate Flutter Web outputs:

| Surface | Entry point | Output | Intended host |
|---|---|---|---|
| Revamped portfolio landing | `lib/main_landing.dart` | `build/landing/` | `boonyongyang.dev` |
| Old/main interactive app | `lib/main_app.dart` | `build/app/` | `app.boonyongyang.dev` |

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
SITE_URL=https://boonyongyang.dev \
APP_URL=https://app.boonyongyang.dev \
GITHUB_URL=https://github.com/boonyongyang \
LINKEDIN_URL=https://linkedin.com/in/boonyongyang \
./build_apps.sh landing
```

Defaults:

| Variable | Default |
|---|---|
| `SITE_URL` | `https://boonyongyang.dev` |
| `APP_URL` | `https://app.boonyongyang.dev` |
| `GITHUB_URL` | `https://github.com/boonyongyang` |
| `LINKEDIN_URL` | `https://linkedin.com/in/boonyongyang` |

## Static Hosting

Deploy `build/landing/` to the main portfolio domain and `build/app/` to the app subdomain.

For any single-page-app host, configure rewrites so all routes fall back to `/index.html`.

## Firebase Hosting

The current `firebase.json` serves `build/landing`, so `make deploy_web` deploys the revamped portfolio landing by default.

For a dual-site Firebase deployment that also publishes the old/main interactive app to `app.boonyongyang.dev`, replace `firebase.json` with multi-site hosting after targets are configured:

```json
{
  "hosting": [
    {
      "target": "landing",
      "public": "build/landing",
      "ignore": ["firebase.json", "**/.*", "**/node_modules/**"],
      "rewrites": [{ "source": "**", "destination": "/index.html" }]
    },
    {
      "target": "app",
      "public": "build/app",
      "ignore": ["firebase.json", "**/.*", "**/node_modules/**"],
      "rewrites": [{ "source": "**", "destination": "/index.html" }]
    }
  ]
}
```

Only switch to multi-site hosting after Firebase targets are configured locally with `firebase target:apply hosting ...`; otherwise the current landing-only Firebase deploy is safer.

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
make deploy_web
```

Deploy a preview channel:

```bash
make deploy_web_channel CHANNEL=preview-name
```
