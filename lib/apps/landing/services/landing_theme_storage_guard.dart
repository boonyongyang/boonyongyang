import '../theme/landing_theme.dart';

/// Keeps theme persistence optional when browser storage is unavailable.
class LandingThemeStorageGuard {
  static LandingThemePreset? loadPreset(String? Function() readValue) {
    try {
      final value = readValue();
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

  static void savePreset(
    LandingThemePreset preset,
    void Function(String value) writeValue,
  ) {
    try {
      writeValue(preset.name);
    } catch (_) {
      // Theme persistence is an enhancement, never a render requirement.
    }
  }
}
