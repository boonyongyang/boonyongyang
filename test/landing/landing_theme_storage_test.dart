import 'package:boonyongyang/apps/landing/services/landing_theme_storage_guard.dart';
import 'package:boonyongyang/apps/landing/theme/landing_theme.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('loads a persisted theme preset by its stable enum name', () {
    expect(
      LandingThemeStorageGuard.loadPreset(() => 'midnightZinc'),
      LandingThemePreset.midnightZinc,
    );
  });

  test('falls back when browser storage is unavailable or invalid', () {
    expect(
      LandingThemeStorageGuard.loadPreset(
        () => throw StateError('storage blocked'),
      ),
      isNull,
    );
    expect(
      LandingThemeStorageGuard.loadPreset(() => 'retired-theme'),
      isNull,
    );
  });

  test('ignores a browser storage write failure', () {
    expect(
      () => LandingThemeStorageGuard.savePreset(
        LandingThemePreset.signalAmber,
        (_) => throw StateError('quota unavailable'),
      ),
      returnsNormally,
    );
  });
}
