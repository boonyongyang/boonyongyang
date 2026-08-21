// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html' as html;

import 'landing_theme_storage_guard.dart';
import '../theme/landing_theme.dart';

class LandingThemeStorage {
  static const _key = 'landing_theme_preset';

  static LandingThemePreset? loadPreset() {
    return LandingThemeStorageGuard.loadPreset(
      () => html.window.localStorage[_key],
    );
  }

  static void savePreset(LandingThemePreset preset) {
    LandingThemeStorageGuard.savePreset(
      preset,
      (value) => html.window.localStorage[_key] = value,
    );
  }
}
