# Command Guide

This repo has two runnable Flutter surfaces:

| Surface | What it is | Entry point | Use it when |
|---|---|---|---|
| Revamped landing | Portfolio site with the new token-based design system and theme presets | `lib/main_landing.dart` | You are editing the public portfolio site |
| Old/main app | Interactive playground with games, charts, maps, labs, and app routing | `lib/main_app.dart` | You are editing the broader app experience |
| Smart entry | Routes by `AppConfig.currentMode` | `lib/main.dart` | You specifically need the configured default mode |

## Flutter Web

Use these commands by default for this project.

Run the revamped landing app in Chrome:

```bash
make run_landing_web
```

Run the old/main interactive app in Chrome:

```bash
make run_app_web
```

Direct Flutter equivalents:

```bash
flutter run -d chrome --target=lib/main_landing.dart
flutter run -d chrome --target=lib/main_app.dart
```

## Active Simulator Only

Use this only when you explicitly need iOS Simulator behavior. The default local target for this repo is Flutter Web.

Check which simulator is already booted:

```bash
xcrun simctl list devices booted
```

Capture the booted simulator id:

```bash
BOOTED_DEVICE_ID="$(xcrun simctl list devices booted | awk -F '[()]' '/Booted/{print $2; exit}')"
test -n "$BOOTED_DEVICE_ID" && echo "$BOOTED_DEVICE_ID"
```

Run the revamped landing app in the active simulator:

```bash
make run_landing_sim_active
```

Run the old/main interactive app in the active simulator:

```bash
make run_app_sim_active
```

If `BOOTED_DEVICE_ID` is empty, no simulator is currently active. Boot one manually in Simulator first, then rerun the command.

The `LANG` and `LC_ALL` values are included because CocoaPods can fail on macOS with `Unicode Normalization not appropriate for ASCII-8BIT` when the shell is not using UTF-8.

## Build

Build the revamped landing app:

```bash
make build_landing
```

Build the old/main interactive app:

```bash
make build_app
```

Build both web targets:

```bash
make build_all
```

The `make` build targets use `build_apps.sh`, so outputs are written to `build/landing/` and `build/app/`. Direct Flutter commands are useful for a quick local compile check, but they write to Flutter's default `build/web/` directory:

```bash
flutter build web --release --target=lib/main_landing.dart
flutter build web --release --target=lib/main_app.dart
```

## Verification

Run tests:

```bash
make test
```

Run analyzer without failing on existing info-level lint backlog:

```bash
make analyze
```

Format Dart files:

```bash
make format
```

Check formatting without changing files:

```bash
make format_check
```

## CI Equivalent

GitHub Actions uses the same release build path for web outputs:

```bash
make analyze
make test
make format_check
make build_all
```
