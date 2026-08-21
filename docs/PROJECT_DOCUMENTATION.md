# Boon Yong Yang — Portfolio & Playground Project

> Comprehensive technical documentation for the dual-app Flutter web project.
> Last updated: 1 March 2026

---

## Table of Contents

1. [Project Overview](#project-overview)
2. [Architecture](#architecture)
3. [App Entry Points](#app-entry-points)
4. [Landing Page App](#landing-page-app)
5. [Main Interactive App](#main-interactive-app)
6. [Feature Reference](#feature-reference)
7. [Core Infrastructure](#core-infrastructure)
8. [Shared Layer](#shared-layer)
9. [Theming & Design System](#theming--design-system)
10. [Build & Deployment](#build--deployment)
11. [Dependencies](#dependencies)
12. [Testing](#testing)
13. [Documentation Maintenance](#documentation-maintenance)

---

## Project Overview

This is a **dual-app Flutter Web project** that serves two purposes:

| App | Target | Entry Point | Purpose |
|-----|--------|-------------|---------|
| **Landing Page** | `lib/main_landing.dart` | Portfolio website | Lightweight, SEO-optimized personal portfolio showcasing professional experience, production apps, and technical skills |
| **Main App** | `lib/main_app.dart` | Interactive playground | Full-featured app with games, data visualizations, map demos, and experimental features |

Both apps share code from `lib/core/` and `lib/shared/` but maintain independent configuration, themes, and deployment targets.

**Tech Stack**: Flutter Web, Dart 3.0+, Material 3, GoRouter, GetIt DI, flutter_bloc/Cubit, Equatable, Firebase Hosting.

---

## Architecture

### High-Level Structure

```
lib/
├── main.dart                  # Smart entry (routes by AppConfig)
├── main_landing.dart          # Landing-only entry
├── main_app.dart              # Main app entry
├── apps/
│   ├── app_config.dart        # AppMode toggle (landing/mainApp)
│   ├── landing/               # Landing page app
│   └── main_app/              # Main interactive app shell
├── core/                      # Shared infrastructure
│   ├── constants/             # Animation constants
│   ├── di/                    # GetIt service locator
│   ├── errors/                # Typed exception hierarchy
│   ├── providers/             # Performance & navigation state
│   ├── routes/                # GoRouter config & transitions
│   ├── style/                 # Design tokens (colors, gradients)
│   ├── theme/                 # Material 3 dark theme
│   └── utils/                 # Scroll behavior, utilities
├── features/                  # Main app feature modules
│   ├── about/
│   ├── charts/
│   ├── home/
│   ├── labs/
│   ├── maps/
│   └── plays/
└── shared/                    # Cross-feature reusable code
    ├── mixins/
    ├── models/
    └── widgets/
```

### Dual-App Separation

The project uses **separate build targets** to produce two independent web apps:

- `flutter build web --target=lib/main_landing.dart` → lightweight landing page
- `flutter build web --target=lib/main_app.dart` → full interactive app

This separation ensures:
- The landing page loads fast (no game/chart/map code bundled)
- Each app maintains its own hot-reload cycle during development
- Independent deployment to different domains/paths

### Data-Driven Landing Page

The landing page follows a **data-driven architecture** where all content lives in configuration/model files, not in widget code:

```
Content Flow:
  QuickConfig (config/quick_config.dart)
       ↓
  Data Models (models/*.dart)
       ↓
  Data Provider (models/landing_page_data_provider.dart)
       ↓
  Widgets (widgets/sections/*.dart, widgets/components/*.dart)
```

Updating portfolio content requires editing only `quick_config.dart` and `project_model.dart` — no widget code changes needed for content-only updates.

---

## App Entry Points

### `lib/main.dart` — Smart Router

Routes to landing or main app based on `AppConfig.currentMode`. Handles:
- Global error handling (`FlutterError.onError`, `PlatformDispatcher.onError`, `runZonedGuarded`)
- System UI overlay configuration
- Conditional initialization (full DI only for main app)
- Performance config setup

### `lib/main_landing.dart` — Landing Page

Minimal initialization:
- Runs `LandingApp()` directly
- No service locator or DI setup
- Material 3 theme with landing tokens and selectable presets

### `lib/main_app.dart` — Main App

Full initialization:
- Global error handling (`runZonedGuarded`, `FlutterError.onError`)
- Sets up `ServiceLocator` (GetIt) with shared Dio, repositories
- Configures `PerformanceConfig` (adapts to device capabilities)
- Enables render profiling in debug mode
- Runs `MainApp()` with GoRouter navigation

---

## Landing Page App

**Location**: `lib/apps/landing/`

### Page Sections (top to bottom)

| # | Section | Widget | Description |
|---|---------|--------|-------------|
| 1 | **Header** | `HeaderSection` | Compact navigation with contact links and a three-preset theme switcher |
| 2 | **Hero** | `HeroSection` | Editorial intro with name, role, availability, primary actions, and proof metrics |
| 3 | **Work Experience** | `WorkExperienceSection` | Current role timeline with implementation rows and concise capability context |
| 4 | **Production Apps** | `ProductionAppsSection` | Case-study panels covering problem, role, shipped result, metrics, and store links |
| 5 | **Passion Projects** | `PassionProjectsSection` | Compact personal/open-source project index with links and metadata |
| 6 | **Features** | `FeaturesSection` | Grouped capability rows for architecture, delivery, product thinking, and systems work |
| 7 | **Footer** | `FooterSection` | Direct contact strip with email and social actions |

### Configuration System

**Primary config file**: `lib/apps/landing/config/quick_config.dart`

Controls the following from a single file:

| Category | Fields |
|----------|--------|
| Personal Info | `fullName`, `currentRole`, `headerTitle`, `headerSubtitle`, `workStatus`, `email`, `emailSubject` |
| Current Job | `currentCompany`, `currentPosition`, `workDuration` |
| Positioning | `professionalSummary`, availability copy, headline metrics |
| Social Links | `githubUrl`, `linkedinUrl`, `appUrl` |
| Footer | `copyrightYear`, `contactSubtitle` |
| Experience Rows | `experienceImplementations` (list of `QuickExperienceImplementation`) |
| Skill Categories | `skillCategories` (list of `QuickSkillCategory`) |
| Store Links | `productionStoreLinks` (list of `QuickStoreLinks`) |
| Metrics | `currentMetrics` map |

### Data Models

| Model | File | Source |
|-------|------|--------|
| `QuickSkillCategory` | `models/quick_content_models.dart` | Lightweight skill group (title, level, skills list) |
| `QuickStoreLinks` | `models/quick_content_models.dart` | App store URLs matched by project title |
| `QuickExperienceImplementation` | `models/quick_content_models.dart` | Work experience row data (title, icon, description, details, technologies) |
| `PersonalInfoModel` | `models/personal_info_model.dart` | Derives from `QuickConfig` — name, role, status, email |
| `WorkExperienceModel` | `models/work_experience_model.dart` | Derives from `QuickConfig` — company, position, duration |
| `FooterInfoModel` | `models/social_link_model.dart` | Derives footer contact and copyright copy from `QuickConfig` |
| `ProjectModel` | `models/project_model.dart` | Production apps, personal projects, and source-proportion product media |

### Services

| Service | Purpose |
|---------|---------|
| `UrlLauncherService` | Centralized URL opening — GitHub, LinkedIn, email (with proper `Uri` construction), custom URLs, and app navigation |
| `LandingThemeStorage` | Web-only localStorage persistence for the selected landing theme, with a no-op conditional fallback for tests/non-web targets |

### Utilities

| Utility | Purpose |
|---------|---------|
| `ResponsiveUtils` | Breakpoint detection (mobile/tablet/desktop), responsive padding, grid column calculations |

### Landing Page Theme

- **Base**: Material 3 with a repo-local token layer
- **Presets**: Studio Light, Midnight Zinc, Signal Amber
- **Typography**: Inter preference with platform fallbacks
- **Primitives**: `landing_design_system.dart` owns section shells, panels, buttons, badges, metrics, and lists
- **File**: `lib/apps/landing/theme/landing_theme.dart`

### How to Update Landing Content

See `docs/landing/CONTENT_UPDATE_GUIDE.md` for the full workflow. Quick summary:

1. **Profile/links/metrics**: Edit `lib/apps/landing/config/quick_config.dart`
2. **Projects**: Edit `lib/apps/landing/models/project_model.dart`
3. **Product evidence**: Add approved WebP assets and provenance under `assets/portfolio/products/`
4. **Test locally**: `make run_landing_web`
5. **Build**: `make build_landing`

---

## Main Interactive App

**Location**: `lib/apps/main_app/` + `lib/features/`

### Navigation & Routes

Centralized in `lib/core/routes/app_router.dart` using GoRouter:

| Route | Path | Feature |
|-------|------|---------|
| Home | `/` | Dashboard with hero section, carousel, quotes |
| Maps | `/maps` | OpenStreetMap interactive demo |
| Charts | `/charts` | Financial chart selection page |
| Candle Chart | `/charts/candle` | Candlestick chart (receives StockItem via extra) |
| Labs | `/labs` | Experimental features and API demos |
| Plays | `/plays` | Game selection grid |
| Connect 4 | `/plays/connect4` | Connect 4 game |
| Tic-Tac-Toe | `/plays/tic-tac-toe` | Classic Tic-Tac-Toe |
| Snake | `/plays/snake` | Snake vs AI game |
| Brick Breaker | `/plays/brick-breaker` | Arcade brick breaker |
| About | `/about` | App information page |

All routes use custom page transitions defined in `lib/core/routes/page_transitions.dart`.

### Main App Theme

- **Style**: Dark cyberpunk-inspired
- **Primary Colors**: Neon Blue (`#3A7BEF`), Cyberpunk Purple (`#8A49D8`)
- **Accent Colors**: Neon Aqua (`#05D9E8`), Cyborg Purple (`#AB65FF`), Laser Amber (`#FFB52E`)
- **Backgrounds**: Tech Navy (`#1E2740`), Night Shade (`#202438`)
- **Gradients**: Cyber Horizon, Neuro Portal, Synthwave Energy, Neon Dream
- **Files**: `lib/core/theme/app_theme.dart`, `lib/core/style/style.dart`

---

## Feature Reference

### Home (`lib/features/home/`)

The main interactive landing page for the app mode.

- **Animated hero section** with parallax effects
- **GIF carousel** widget
- **Random quote** display
- **Glass-morphism cards** for navigation
- Adapts complexity based on `PerformanceConfig` (reduces animations on low-end devices)

### Charts (`lib/features/charts/`)

Financial data visualization using Syncfusion Flutter Charts.

| Chart Type | File | Description |
|------------|------|-------------|
| Candlestick | `view/candle_chart.dart` | OHLC candlestick chart with date axis |
| Hi-Lo | `view/hilo_chart.dart` | High-low range chart |
| HLOC | `view/hilo_open_close_chart.dart` | High-low-open-close chart |

**Data**: Sample stock data (AAPL, GOOGL, NVDA, AMZN, MSFT, TSLA, META, etc.) in `data/sample_stock_data.dart`.

**Models**:
- `StockItem` — symbol, name, OHLC, change %, volume
- `ChartData` — datetime + OHLC for chart rendering

### Maps (`lib/features/maps/`)

Interactive map demo using OpenStreetMap.

- `MapsPage` — container page
- `OsmWidget` — OpenStreetMap integration via `flutter_osm_plugin`
- Supports location search and interactive markers

### Plays (`lib/features/plays/`)

Collection of 5 interactive mini-games:

| Game | File | Controls | Description |
|------|------|----------|-------------|
| **Snake** | `snake_game_view.dart` | Arrow keys / WASD | Player vs AI snake on 20×20 grid. AI has configurable difficulty (speed increase per food). Score tracking, collision detection, game-over state. |
| **Tic-Tac-Toe** | `tic_tac_toe_view.dart` | Tap | Classic 3×3 board. Two-player turn-based with win/draw detection. |
| **AI Tic-Tac-Toe** | `ai_tic_tac_toe_view.dart` | Tap | Player vs unbeatable AI (minimax algorithm). Optimal move calculation. |
| **Connect 4** | `connect4_view.dart` | Tap column | Two-player Connect Four. Column-based piece dropping with gravity. Horizontal/vertical/diagonal win detection. |
| **Brick Breaker** | `brick_breaker_view.dart` | Mouse/touch | Paddle-and-ball arcade game. Break bricks to score. Power-ups and progressive difficulty. |

Games are accessed via a responsive grid on the Plays page or via direct routes.

### Labs (`lib/features/labs/`)

Experimental features and technical demos:

| Feature | File | Description |
|---------|------|-------------|
| Labs Hub | `labs_page.dart` | Grid of available experiments |
| Fruits API | `fruits_page.dart` | REST API integration demo — uses `FruitsCubit` (BLoC pattern) with repository abstraction and typed error handling |
| Theme Showcase | `theme_showcase_page.dart` | Live preview of all app design tokens, colors, gradients, and typography |

### About (`lib/features/about/`)

Application information page:
- Feature highlights
- Version details
- Technology stack overview

---

## Core Infrastructure

### Dependency Injection (`lib/core/di/`)

Uses **GetIt** service locator pattern:

```dart
// Registered services:
- NavigationState (lazy singleton)       — app-wide navigation state
- PerformanceConfig (lazy singleton)     — adaptive performance settings
- Dio (lazy singleton)                   — shared HTTP client with logging interceptors
- FruitRepository (lazy singleton)       — Fruit API data access (FruitService implementation)
```

### Error Handling (`lib/core/errors/`)

Typed exception hierarchy using Dart sealed classes:

| Exception | Purpose |
|-----------|---------|
| `AppException` (sealed base) | Base for all app-specific errors |
| `NetworkException` | HTTP/connection failures, with `fromDioException()` factory |
| `DataParsingException` | JSON parsing or data mapping failures |
| `NotFoundException` | Resource not found errors |

### State Management

Uses **flutter_bloc** (Cubit pattern) for reactive feature state:

| Cubit | Feature | States |
|-------|---------|--------|
| `FruitsCubit` | Labs → Fruits API | `FruitsInitial`, `FruitsLoading`, `FruitsLoaded`, `FruitsError` |
| `SnakeGameCubit` | Plays → Snake | Tracks `score`, `highScore`, `aiSpeed`, `isGameOver` |

Cubits receive dependencies via constructor injection and use `Equatable` for efficient state comparison.

### Performance Configuration (`lib/core/providers/performance_config.dart`)

Adaptive performance system that detects device capabilities and adjusts:

| Setting | High-Performance | Low-Performance |
|---------|-----------------|-----------------|
| Animations | Full | Reduced |
| Frame Rate | 60 fps | 30 fps |
| Parallax Effects | Enabled | Disabled |
| Blur Effects | Enabled | Disabled |
| Web Optimizations | Standard | Aggressive |

### Navigation State (`lib/core/providers/navigation_state.dart`)

Manages app-wide navigation state for sidebar/drawer synchronization.

### Animation Constants (`lib/core/constants/animation_constants.dart`)

Standardized animation durations and curves used across all features for consistent motion design.

### Scroll Behavior (`lib/core/utils/smooth_scroll_behavior.dart`)

Custom scroll physics with configurable friction and damping for smooth web scrolling.

---

## Shared Layer

**Location**: `lib/shared/`

### Reusable Widgets (`lib/shared/widgets/`)

| Widget | Description |
|--------|-------------|
| `top_nav_bar.dart` | App bar with navigation title and back button |
| `glass_card.dart` | Glass-morphism card with blur and transparency |
| `animated_hero_section.dart` | Hero banner with entrance animations |
| `gif_carousel_widget.dart` | Image/GIF carousel with auto-play |
| `random_quote_widget.dart` | Displays random inspirational quotes |
| `custom_button.dart` | Styled button with consistent theming |
| `parallax_container.dart` | Parallax scrolling effect wrapper |
| `cached_image.dart` | Image with caching support |
| `embeded_youtube_video.dart` | YouTube video embed widget |
| `recycler_list.dart` | RecyclerView-style efficient list |
| `elegant_shape.dart` | Decorative SVG/path shape |
| `user_ip_address.dart` | Displays user's IP address |
| `fake_location_loading_widget.dart` | Themed loading indicator |
| `date_timer_widget.dart` | Live date/time display |

### Shared Models (`lib/shared/models/`)

Data structures used across multiple features.

### Shared Mixins (`lib/shared/mixins/`)

Reusable mixin classes for common widget behaviors.

---

## Theming & Design System

### Landing Page Theme

| Property | Value |
|----------|-------|
| Mode | Studio Light default, plus Midnight Zinc and Signal Amber |
| Design System | Material 3 plus repo-local landing tokens |
| Accent | Preset-specific blue, cyan/green, or amber |
| Font | Inter preference with platform fallbacks |

### Main App Theme (Cyberpunk)

| Token | Value | Hex |
|-------|-------|-----|
| Neon Blue | Primary | `#3A7BEF` |
| Cyberpunk Purple | Secondary | `#8A49D8` |
| Neon Aqua | Accent | `#05D9E8` |
| Cyborg Purple | Accent | `#AB65FF` |
| Laser Amber | Warning | `#FFB52E` |
| Success Green | Success | `#4EFFA4` |
| Tech Navy | Surface | `#1E2740` |
| Night Shade | Background | `#202438` |
| Hologram White | On-surface | `#EBF0FF` |
| Ghost Blue | Secondary text | `#B0C2DE` |

**Named Gradients**: Cyber Horizon, Neuro Portal, Synthwave Energy, Neon Dream, Electric Field, Binary Dusk.

---

## Build & Deployment

### Local Development

```bash
# Run revamped landing page in Chrome
make run_landing_web

# Run old/main app in Chrome
make run_app_web
```

The default local target is Flutter Web. For simulator-only checks, use `docs/COMMANDS.md`. The short version is:

```bash
# Revamped landing on the already booted iOS Simulator
make run_landing_sim_active

# Old/main app on the already booted iOS Simulator
make run_app_sim_active
```

### Build Commands

```bash
# Build landing page only
make build_landing

# Build main app only
make build_app

# Build both
make build_all
```

The `make` build targets call `build_apps.sh` so the outputs are written to the deployment directories below.

Build output:
```
build/
├── landing/     # Landing page artifacts
│   ├── index.html
│   ├── main.dart.js
│   └── robots.txt
└── app/         # Main app artifacts
    ├── index.html
    └── main.dart.js
```

### Firebase Deployment

```bash
# Deploy to Firebase Hosting
make deploy_web

# Deploy to preview channel
make deploy_web_channel CHANNEL=preview-name
```

**Firebase config** (`firebase.json`): Serves the revamped landing site from `build/landing` with SPA rewrites (`**` → `/index.html`).

The old/main interactive app builds to `build/app` and deploys independently to the `boonyongyang-app` Firebase Hosting site. See `DEPLOYMENT.md` for the non-destructive site mapping and custom-domain plan.

### Web HTML Files

| File | Purpose |
|------|---------|
| `web/index.html` | Main app HTML shell with Flutter bootstrap |
| `web/landing.html` | Landing page HTML with SEO metadata, structured data, preconnect hints, and a neutral loading state |

### SEO (Landing Page)

The landing page includes:
- Meta description and keywords
- Open Graph tags (title, description, image)
- Twitter Card tags
- Preconnect to `fonts.googleapis.com`, `github.com`, `linkedin.com`
- Custom loading animation
- Social share image (`icons/Icon-512.png`)

---

## Dependencies

### Runtime Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| `flutter_bloc` | ^8.1.6 | State management (Cubit pattern) |
| `equatable` | ^2.0.5 | Value equality for state classes |
| `go_router` | ^14.8.0 | Declarative routing |
| `get_it` | ^7.6.7 | Service locator / DI |
| `dio` | ^5.8.0+1 | HTTP client |
| `dio_intercept_to_curl` | ^0.2.0 | Curl logging for debugging |
| `pretty_dio_logger` | ^1.4.0 | Pretty HTTP request logging |
| `carousel_slider` | ^5.0.0 | Image/GIF carousel |
| `gap` | ^3.0.1 | Spacing utility widgets |
| `pointer_interceptor` | ^0.10.1+2 | Pointer event interception |
| `cupertino_icons` | ^1.0.2 | iOS-style icons |
| `flutter_osm_plugin` | ^1.3.5 | OpenStreetMap maps |
| `syncfusion_flutter_charts` | ^27.2.4 | Financial chart widgets |
| `intl` | ^0.19.0 | Internationalization/formatting |
| `url_launcher` | ^6.3.1 | Open URLs and emails |

### Dev Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| `flutter_test` | SDK | Widget and unit testing |
| `flutter_lints` | ^3.0.2 | Strict lint rules |
| `bloc_test` | ^9.1.7 | Cubit/BLoC testing utilities |
| `mocktail` | ^1.0.4 | Mock generation for tests |

---

## Testing

### Test Structure

```
test/
├── core/
│   └── errors/
│       └── app_exceptions_test.dart       # Typed exception unit tests
├── features/
│   ├── labs/
│   │   └── cubit/
│   │       └── fruits_cubit_test.dart     # FruitsCubit BLoC tests (with mocked repository)
│   └── plays/
│       └── model/
│           └── snake_game_test.dart       # Snake game logic unit tests
├── widget_test.dart                       # Default widget smoke test
└── counter_test.dart                      # Default counter test
```

### Test Categories

| Category | File | Tests |
|----------|------|-------|
| **Unit** | `snake_game_test.dart` | Game initialization, direction changes, score tracking, Position math, restart |
| **Cubit** | `fruits_cubit_test.dart` | Initial state, loading→loaded flow, network error handling, empty results (uses `bloc_test` + `mocktail`) |
| **Unit** | `app_exceptions_test.dart` | Exception factory methods, message preservation, DioException mapping |

### Running Tests

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Run specific test file
flutter test test/features/labs/cubit/fruits_cubit_test.dart

# Via Makefile
make test
```

### CI/CD

GitHub Actions workflow (`.github/workflows/ci.yml`) runs on every push/PR to `main`:

1. **analyze-and-test** — `flutter analyze`, `flutter test --coverage`, `dart format --set-exit-if-changed`
2. **build-web** — Runs `make build_all` so CI verifies the same `build/landing` and `build/app` outputs used for deployment

---

## Documentation Maintenance

### When to Update This Document

Update this file (`docs/PROJECT_DOCUMENTATION.md`) when:

- A new feature is added under `lib/features/`
- A new section is added to the landing page
- A new route is registered in `app_router.dart`
- A new dependency is added to `pubspec.yaml`
- The build/deployment process changes
- A new shared widget is added to `lib/shared/widgets/`
- The theme or design tokens change

### Related Documentation

| Document | Purpose |
|----------|---------|
| [docs/landing/ARCHITECTURE.md](landing/ARCHITECTURE.md) | Landing page directory structure and component details |
| [docs/landing/CONTENT_UPDATE_GUIDE.md](landing/CONTENT_UPDATE_GUIDE.md) | Step-by-step guide for updating landing page content |
| [docs/main_app/ARCHITECTURE.md](main_app/ARCHITECTURE.md) | Main app structure and data placement rules |
| [docs/COMMANDS.md](COMMANDS.md) | Commands for revamped landing, old/main app, active simulator runs, builds, and verification |
| [docs/ROADMAP.md](ROADMAP.md) | Phased task list for the portfolio revamp and deployment readiness work |
| [docs/STATUS.md](STATUS.md) | Current deploy-readiness state, verified commands, and next phase |
| [DEPLOYMENT.md](../DEPLOYMENT.md) | Build outputs, hosting choices, pre-deploy checklist, and multi-domain deployment notes |
| [README.md](../README.md) | Project overview and quick start |

### Documentation Update Checklist

When adding or modifying a feature:

1. Update the **Feature Reference** section in this document
2. If it's a new route, add it to the **Navigation & Routes** table
3. If it affects the landing page, update `docs/landing/CONTENT_UPDATE_GUIDE.md`
4. If new shared widgets are created, add to the **Shared Layer** table
5. If new dependencies are added, update the **Dependencies** table
6. Run the app locally to verify the feature works as documented
