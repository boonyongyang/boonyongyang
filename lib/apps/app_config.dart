enum AppMode {
  landing,
  mainApp,
}

class AppConfig {
  static const AppMode currentMode =
      AppMode.landing; // Change this to switch apps

  // In production, you might determine this based on:
  // - Environment variables
  // - URL/domain detection
  // - Build configuration
  // - Command line arguments

  static bool get isLanding => currentMode == AppMode.landing;
  static bool get isMainApp => currentMode == AppMode.mainApp;
}
