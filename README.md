# Boon Yong Yang - Multi-App Flutter Project

![CI](https://github.com/boonyongyang/boonyongyang/actions/workflows/ci.yml/badge.svg?branch=main)
![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green)
![Platform](https://img.shields.io/badge/Platform-Web%20%7C%20iOS%20%7C%20Android-lightgrey)

A Flutter project with separated architecture for landing page and main application deployment.

## Architecture

This project contains two separate Flutter applications:

### Landing Page (`lib/apps/landing/`)
- Portfolio landing page with a repo-local design system
- Three theme presets: Studio Light, Midnight Zinc, and Signal Amber
- Case-study layout for production apps and compact project index
- Deploy to the main portfolio domain (`boonyongyang.com`)

### Main App (`lib/apps/main_app/`)
- Full-featured interactive application
- Games, maps, charts, and experiments
- Complete routing and state management
- Deploy independently to `boonyongyang-app.web.app`, with `app.boonyongyang.com` reserved as its custom domain

## Getting Started

### Development

Run the revamped landing page:
```bash
make run_landing_web
```

Run the old/main interactive app:
```bash
make run_app_web
```

The default local target is Flutter Web. Use simulator commands only when you specifically need iOS behavior:
```bash
# Revamped landing
BOOTED_DEVICE_ID="$(xcrun simctl list devices booted | awk -F '[()]' '/Booted/{print $2; exit}')"
test -n "$BOOTED_DEVICE_ID" && LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 flutter run -d "$BOOTED_DEVICE_ID" --target=lib/main_landing.dart

# Old/main app
BOOTED_DEVICE_ID="$(xcrun simctl list devices booted | awk -F '[()]' '/Booted/{print $2; exit}')"
test -n "$BOOTED_DEVICE_ID" && LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 flutter run -d "$BOOTED_DEVICE_ID" --target=lib/main_app.dart
```

See `docs/COMMANDS.md` for the full command guide.

### Building for Production

Build both apps:
```bash
make build_all
```

Build landing page only:
```bash
make build_landing
```

Build main app only:
```bash
make build_app
```

### App Separation

Each app maintains its own state and routing configuration independently, so landing-page work can stay focused and the interactive app can keep its broader feature set.

## Deployment

See [DEPLOYMENT.md](DEPLOYMENT.md) for detailed deployment instructions.

## Documentation

- **Full project documentation**: `docs/PROJECT_DOCUMENTATION.md`
- Command guide: `docs/COMMANDS.md`
- Revamp roadmap: `docs/ROADMAP.md`
- Current status: `docs/STATUS.md`
- Landing architecture: `docs/landing/ARCHITECTURE.md`
- Landing content updates: `docs/landing/CONTENT_UPDATE_GUIDE.md`
- Main app architecture: `docs/main_app/ARCHITECTURE.md`

### Quick Deploy Structure
```
build/
├── landing/    # → boonyongyang.com / boonyongyang.web.app
└── app/        # → boonyongyang-app.web.app / future app.boonyongyang.com
```

## Features

### Landing Page
- Token-based Material 3 theme layer for the portfolio surface
- Restrained editorial hero with direct contact actions
- Current-work timeline and production app case-study panels
- Compact project index with GitHub links
- Capability rows grouped by product delivery workflow
- Shared Versions selector for the Flutter portfolio, interactive app, and
  Next.js + Three.js portfolio

### Main App
- Interactive games (Connect 4, Tic-tac-toe, Snake, Brick Breaker)
- Interactive maps with OpenStreetMap
- Data visualizations and charts
- Experimental features and labs
- Responsive design for all devices
- Compact Versions selector in the application header

## Technology Stack

- **Flutter Web** - Cross-platform UI framework
- **GoRouter** - Declarative routing (main app)
- **Material 3** - Theme foundation for the landing design system
- **OpenStreetMap** - Interactive mapping
- **Syncfusion Charts** - Data visualization
- **Get It** - Dependency injection

## Project Structure

```
lib/
├── apps/
│   ├── landing/           # Landing page app
│   │   ├── pages/
│   │   ├── theme/
│   │   └── landing_app.dart
│   ├── main_app/          # Main application
│   │   └── main_app.dart
│   └── app_config.dart    # App configuration
├── core/                  # Shared core functionality
├── features/              # Main app features
├── main.dart             # Combined entry point
├── main_landing.dart     # Landing page entry point
└── main_app.dart         # Main app entry point
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is open source and available under the [MIT License](LICENSE).
