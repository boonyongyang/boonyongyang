# Landing Page Architecture

The landing page is a separate Flutter app under `lib/apps/landing/`. It is now built around a small repo-local design system instead of one-off gradients, card styles, and per-section color logic.

## Design Direction

Visual thesis: quiet technical portfolio. The page should feel like a deliberate product-engineering portfolio: restrained surfaces, crisp borders, compact proof, and fewer decorative effects.

Current principles:

- Prefer section rhythm, typography, and borders over floating cards.
- Keep the hero editorial and direct: name, role, availability, contact actions, proof metrics.
- Present production apps as case studies, not generic project cards.
- Keep personal projects as a compact index.
- Group skills as capability rows, not a wall of colorful chips.

## Theme System

`lib/apps/landing/theme/landing_theme.dart` owns the landing theme layer.

- `LandingThemePreset` defines the three preview themes: Studio Light, Midnight Zinc, and Signal Amber.
- `LandingTokens` is a `ThemeExtension` for landing-specific colors, spacing, radius, and max width.
- `LandingTheme.themeFor()` maps each preset to Material 3 `ThemeData` plus the landing tokens.

The landing app stores the active preset in `LandingApp` and passes it to `HeaderSection`, where the theme menu can switch presets without adding a package dependency. On web, `LandingThemeStorage` persists the selected preset in `localStorage`; tests and non-web targets use the no-op conditional fallback.

The separate `PortfolioVersionMenu` layers control is cross-surface navigation,
not part of the landing theme system. It groups the six independently hosted
portfolio versions first, then the three shareable themes of the Next.js 3D
version.

## Component Layer

`lib/apps/landing/widgets/components/landing_design_system.dart` contains the shared primitives used by the sections:

- `LandingSection` for page rhythm and section headers.
- `LandingPanel` for the few framed surfaces that need containment.
- `LandingButton` for primary and secondary actions.
- `LandingBadge` for status and compact labels.
- `LandingMetricRow` and `LandingMetricItem` for proof points.
- `LandingList` for short outcome and feature lists.

Use these primitives before adding new section-local decoration. If a new section needs a visual pattern, add the smallest reusable primitive here instead of duplicating style code.

## Content Workflow

For regular portfolio updates, start here:

1. `lib/apps/landing/config/quick_config.dart` for profile, links, metrics, capability groups, and common copy.
2. `lib/apps/landing/models/project_model.dart` for production apps and personal project references.
3. `docs/landing/CONTENT_UPDATE_GUIDE.md` for the existing content update workflow.

Keep source copy short. The UI assumes each project has a concise description, a few outcomes, a few product features, and a focused stack.

## Section Structure

`lib/apps/landing/pages/landing_page.dart` composes the page in this order:

1. `HeaderSection` with contact links and theme switcher.
2. `HeroSection` with identity, role, CTA buttons, and proof metrics.
3. `WorkExperienceSection` with current role and implementation timeline.
4. `ProductionAppsSection` with case-study panels.
5. `PassionProjectsSection` with the compact project index.
6. `FeaturesSection` with grouped capability rows.
7. `FooterSection` with direct contact actions.

Production app panels keep role, outcome, product scope, stack, and store links inline. Keep this landing slice single-page unless a later content pass proves that dedicated case-study routes are worth the extra surface area.

Each production app may also carry a small `ProjectMedia` evidence set. Record
the source, publisher, dimensions, and review date in
`assets/portfolio/products/ASSETS.md`; render the recorded aspect ratio with
`BoxFit.contain` so responsive layouts never stretch or crop product screens.

## Maintenance Rules

- Do not add a full UI dependency for shadcn/ForUI styling until the Flutter SDK is upgraded enough to support it cleanly.
- Avoid rebuilding card grids, glow gradients, pill-heavy skill areas, or fake phone mockups unless there is a specific product need.
- Keep theme colors inside `LandingTokens`; do not hard-code section colors.
- Add screenshots after visual changes so desktop and mobile regressions are easy to catch.
- Keep authentic product evidence source-proportional and covered by the six-width browser matrix.
