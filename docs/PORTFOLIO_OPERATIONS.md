# Portfolio Operations

This guide is the shared operating contract for the four independently deployed
portfolio versions. It covers measurement, discovery, regression evidence, and
the decision gate for future versions without merging their build systems.

## Production surfaces

| Version | Product surface | Canonical origin | Repository boundary |
|---|---|---|---|
| V1 | Flutter editorial landing | `https://boonyongyang.com` | Parent Flutter repository |
| V2 | Flutter interactive app | `https://app.boonyongyang.com` | Parent Flutter repository |
| V3 | Next.js + Three.js portfolio | `https://3d.boonyongyang.com` | `portfolio-3d-next/` isolated repository |
| V4 | Static Release Dossier | `https://v4.boonyongyang.com` | `portfolio-v4-casebook/` isolated repository |

The permanent Firebase fallback origins remain valid release-recovery paths.
V4 moved to `https://v4.boonyongyang.com` after its Firebase association, DNS,
certificate, and public smoke checks passed on 2026-08-28.

## Privacy-safe analytics

All versions implement the same small event vocabulary. The browser keeps a
testable in-memory event log, strips parameters outside the allowlist, and does
not load Google Analytics unless a valid `G-...` measurement ID is supplied at
build time. No email address, full outbound URL, query string, or free-form user
input is sent.

| Event | Allowed context | Purpose |
|---|---|---|
| `portfolio_version_view` | `version`, `path` | Compare useful traffic across versions |
| `portfolio_theme_view` | `version`, `theme` | Understand which V3 themes are opened |
| `portfolio_version_switch` | `target` | Measure movement between versions |
| `portfolio_theme_switch` | `target` | Measure movement between V3 themes |
| `project_open` | `project`, `target` | Measure portfolio proof engagement |
| `contact_click` | `method` | Measure contact intent without recording addresses |
| `external_profile_click` | `profile` | Measure GitHub or LinkedIn exits |

GA4 consent defaults to denied storage, Google Signals is disabled, and IP
anonymization is requested. Review the final consent behavior and privacy notice
for the visitor jurisdictions before changing that default.

Build with one shared measurement ID:

```bash
ANALYTICS_MEASUREMENT_ID=G-XXXXXXXXXX ./build_apps.sh all

cd portfolio-3d-next
NEXT_PUBLIC_ANALYTICS_MEASUREMENT_ID=G-XXXXXXXXXX npm run build

cd ../portfolio-v4-casebook
ANALYTICS_MEASUREMENT_ID=G-XXXXXXXXXX npm run build
```

An empty value is the safe production default and produces no analytics network
request. The measurement ID is public configuration, not a secret; never store
provider credentials or service-account keys in the repository.

## Search discovery

Every canonical origin publishes a canonical link, social metadata, structured
data, `robots.txt`, and `sitemap.xml`. Google Search Console verification can be
injected without editing source:

```bash
GOOGLE_SITE_VERIFICATION=<token> ./build_apps.sh all

cd portfolio-3d-next
NEXT_PUBLIC_GOOGLE_SITE_VERIFICATION=<token> npm run build

cd ../portfolio-v4-casebook
GOOGLE_SITE_VERIFICATION=<token> npm run build
```

The account owner must obtain the token and complete verification in Search
Console. After deployment, submit each canonical sitemap and record the verified
property date here or in `docs/STATUS.md`.

## Regression and monitoring evidence

Run the parent command for a public, cross-repository contract check:

```bash
make production_smoke
```

It checks public routes, redirects, route markers, discovery files, TLS expiry,
and cross-version navigation. The machine-readable result is written to
`verification/production-smoke.json`; scheduled GitHub Actions retains it for
30 days and writes the same summary into the workflow run. GitHub repository
notification settings remain the owner-controlled alert channel.

Before releasing a surface, run its own gates:

```bash
# V1 and V2
make analyze && make test && make visual_test

# V3
cd portfolio-3d-next && npm run check && npm run verify

# V4
cd portfolio-v4-casebook && npm run check && npm run verify
```

Bundle budgets are release gates. Raise a budget only after inspecting the
changed artifact and documenting why the additional weight improves the page.

## Quarterly maintenance

Once per quarter, or after a material product launch:

1. Revalidate job title, availability, contact destinations, stores, GitHub
   repositories, and all quantitative claims against primary sources.
2. Replace screenshots only from approved publisher/source assets, preserving
   aspect ratio and responsive `object-fit` behavior.
3. Run all local quality and visual gates, then inspect desktop, tablet, mobile,
   reduced-motion, keyboard, and WebGL-fallback evidence.
4. Run the production smoke and review its JSON artifact, including TLS days
   remaining and redirects.
5. Review Search Console indexing and GA4 event totals if those provider
   integrations have been activated.
6. Update `docs/STATUS.md`, the relevant isolated roadmap, and the deployment
   evidence with the exact released commits and CI runs.

## V5 decision gate

Do not create V5 merely to add another theme. Start it only when all of these
are true:

- It serves a distinct audience or hiring conversation that V1-V4 do not.
- It has a one-sentence visual and interaction thesis before implementation.
- Its content source, accessibility target, performance budget, canonical URL,
  repository owner, deployment target, monitoring contract, and retirement plan
  are written down.
- The additional maintenance cost is justified by a measurable goal.
- It can be added to the shared Versions control and smoke suite without
  weakening the four existing releases.

If the need is only a new palette, copy revision, or case study, improve an
existing version instead.
