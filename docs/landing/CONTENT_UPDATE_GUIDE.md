# Landing Page Content Update Guide

This guide is optimized for regular portfolio updates with minimal code changes.

## Fast Update Path (recommended)

Use these 2 files for almost all updates:

1. `lib/apps/landing/config/quick_config.dart`
2. `lib/apps/landing/models/project_model.dart`

## What To Edit

### 1) Profile, status, links, headline metrics, quick skills

Edit:

- `lib/apps/landing/config/quick_config.dart`

This file controls:

- Name, role, work status, email
- Header title/subtitle
- Social links (GitHub, LinkedIn)
- Main app URL and email subject
- Availability copy and hero summary
- Quick skills categories shown in Work Experience
- Experience implementation rows shown in Work Experience
- Production app store links
- Common metrics used in sections

### 2) Project references (production + personal)

Edit:

- `lib/apps/landing/models/project_model.dart`

Update/add:

- `getProductionApps()`
- `getPersonalProjects()`

For each project, keep these fields accurate:

- title, subtitle, description
- achievements, features, technologies
- metrics, status
- githubUrl/liveUrl (if available)
- media assets, semantic labels, and intrinsic dimensions where available

## Alternative Content Strategy (when you grow)

Current setup uses typed Dart constants, which is ideal for a personal portfolio:

- Easy to edit
- Type-safe
- No parsing/runtime config errors

If updates become very frequent and non-technical (for example, edited by someone else), move only portfolio content to a JSON/YAML file and keep UI in Dart. Until then, this QuickConfig + model approach is the simplest reliable option.

## Section-to-File Mapping

- Hero/Header/Footer info: `config/quick_config.dart`
- Work experience summary/metrics: `config/quick_config.dart` + `work_experience_model.dart`
- Technical skill blocks: `config/quick_config.dart` (`skillCategories`)
- Production and personal projects: `project_model.dart`
- Social button actions: `config/quick_config.dart` via `url_launcher_service.dart`

## When Adding New Skills

Use:

- `QuickConfig.skillCategories`

Each category contains:

- title
- level
- skills list

## When Updating Work Experience Implementation Rows

Use:

- `QuickConfig.experienceImplementations`

Each implementation row contains:

- title
- description
- detail bullet list

This avoids editing section layout code for content-only changes. Layout and visual treatment live in the landing design-system primitives under `lib/apps/landing/widgets/components/landing_design_system.dart` and the section widgets under `lib/apps/landing/widgets/sections/`.

## When Adding New Production App References

1. Add the project reference data in `project_model.dart`.
2. Add store URLs in `QuickConfig.productionStoreLinks`.
3. Add approved WebP evidence under `assets/portfolio/products/` and update
   its `ASSETS.md` provenance record.
4. Use a `matchTitleContains` value that matches your project title.

## Build and Verify

### Run locally

```bash
make run_landing_web
```

The default local target is Flutter Web. Run on the already active iOS Simulator only when you specifically need iOS behavior:

```bash
make run_landing_sim_active
```

See `docs/COMMANDS.md` for the old/main app command and the full command guide.

### Build landing app

```bash
make build_landing
```

### Sanity check before deploy

- Links open correctly (GitHub, LinkedIn, email)
- New production panels and project index rows render on desktop/mobile
- Skill categories reflect latest stack
- Metrics and availability copy are still accurate

### Visual baseline screenshots

After layout or theme changes, refresh the baseline screenshots under `docs/landing/screenshots/`:

- `phase1-desktop-hero-studio-light.png`
- `phase1-mobile-hero-studio-light.png`
- `phase1-desktop-production-apps-studio-light.png`
- `phase1-desktop-project-index-studio-light.png`
- `phase1-desktop-hero-midnight-zinc.png`
- `phase1-desktop-hero-signal-amber.png`

## Maintenance Checklist (monthly)

1. Update experience duration text.
2. Update metrics (`downloads`, `ratings`, app count).
3. Add/remove skill tags in `skillCategories`.
4. Refresh project achievements/features based on latest releases.
5. Update `copyrightYear`.
