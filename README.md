# Boon Yong Yang - Multi-App Flutter Project

A Flutter project with separated architecture for landing page and main application deployment.

## Architecture

This project contains two separate Flutter applications:

### 🏠 Landing Page (`lib/apps/landing/`)
- Lightweight portfolio landing page
- Minimal dependencies 
- Fast loading time
- Deploy to main domain (e.g., `yourdomain.com`)

### 🚀 Main App (`lib/apps/main_app/`)
- Full-featured interactive application
- Games, maps, charts, and experiments
- Complete routing and state management
- Deploy to subdomain (e.g., `app.yourdomain.com`)

## Getting Started

### Development

Run the landing page:
```bash
flutter run -d chrome --target=lib/main_landing.dart
```

Run the main app:
```bash
flutter run -d chrome --target=lib/main_app.dart
```

### Building for Production

Build both apps:
```bash
./build_apps.sh all
```

Build landing page only:
```bash
./build_apps.sh landing
```

Build main app only:
```bash
./build_apps.sh app
```

### Hot Reload Fix

The hot reload issue has been resolved by separating the apps. Each app maintains its own state and routing configuration independently.

## Deployment

See [DEPLOYMENT.md](DEPLOYMENT.md) for detailed deployment instructions.

### Quick Deploy Structure
```
build/
├── landing/    # → yourdomain.com
└── app/        # → app.yourdomain.com
```

## Features

### Landing Page
- ✨ Modern, responsive design with smooth animations
- 💼 Detailed work experience with technical implementations
- 🚀 Passion projects showcase with GitHub integration
- 📱 Mobile-optimized with SEO enhancements
- 🔗 Social media and contact links
- 🎯 Call-to-action to main app

### Main App
- 🎮 Interactive games (Connect 4, Tic-tac-toe, Snake, Brick Breaker)
- 🗺️ Interactive maps with OpenStreetMap
- 📊 Data visualizations and charts
- 🧪 Experimental features and labs
- 📱 Responsive design for all devices

## Technology Stack

- **Flutter Web** - Cross-platform UI framework
- **GoRouter** - Declarative routing (main app)
- **Material 3** - Modern design system
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
