# Main App Architecture

This document describes the structure of the interactive main app (`lib/main_app.dart` target).

## App Entry and Runtime

- Entry point: `lib/main_app.dart`
- App shell: `lib/apps/main_app/main_app.dart`
- Router: `lib/core/routes/app_router.dart`
- DI setup: `lib/core/di/service_locator.dart`
- Performance config: `lib/core/providers/performance_config.dart`

## Feature Organization

The main app uses feature folders under `lib/features/`:

- `about/` - About page
- `charts/` - Financial/chart demos
- `home/` - Main interactive landing for app mode
- `labs/` - Experiments and sample pages
- `maps/` - Map demos and OSM integrations
- `plays/` - Mini games (snake, tic-tac-toe, connect4, brick breaker)

Each feature keeps its own `view/` and optional `model/` / `services/` files.

## Shared Layers

- `lib/core/` - routing, theme, DI, providers, constants, utilities
- `lib/shared/` - reusable widgets, mixins, and shared models

## Data Placement Rule

Feature-specific data should live inside the feature.

Example:

- chart sample data is in `lib/features/charts/data/sample_stock_data.dart`
  (instead of global `lib/data.dart`)

## Maintenance Guidelines

1. Keep imports feature-local when data is feature-specific.
2. Put cross-feature utilities in `lib/core` or `lib/shared`, not in feature folders.
3. Keep route definitions centralized in `app_router.dart`.
4. Avoid placeholder/empty files in feature folders.
