// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html' as html;

import '../theme/landing_theme.dart';

class LandingThemeStorage {
  static const _key = 'landing_theme_preset';

  static LandingThemePreset? loadPreset() {
    try {
      final value = html.window.localStorage[_key];
      for (final preset in LandingThemePreset.values) {
        if (preset.name == value) {
          return preset;
        }
      }
    } catch (_) {
      return null;
    }

    return null;
  }

  static void savePreset(LandingThemePreset preset) {
    try {
      html.window.localStorage[_key] = preset.name;
    } catch (_) {
      // Storage can be unavailable in private browsing or restricted contexts.
    }
  }
}
