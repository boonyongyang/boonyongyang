import 'package:flutter/material.dart';

/// Convenience extensions on [BuildContext] for common lookups.
extension BuildContextX on BuildContext {
  // ── Theme shortcuts ──────────────────────────────────────────────────

  /// Current [ThemeData].
  ThemeData get theme => Theme.of(this);

  /// Current [ColorScheme].
  ColorScheme get colorScheme => theme.colorScheme;

  /// Current [TextTheme].
  TextTheme get textTheme => theme.textTheme;

  /// Whether the app is in dark mode.
  bool get isDarkMode => theme.brightness == Brightness.dark;

  // ── Media query shortcuts ────────────────────────────────────────────

  /// Current [MediaQueryData].
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Screen size.
  Size get screenSize => mediaQuery.size;

  /// Screen width.
  double get screenWidth => screenSize.width;

  /// Screen height.
  double get screenHeight => screenSize.height;

  /// View padding (safe area).
  EdgeInsets get viewPadding => mediaQuery.viewPadding;

  // ── Overlay helpers ──────────────────────────────────────────────────

  /// Show a [SnackBar] with [message].
  void showSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message), duration: duration, action: action),
      );
  }

  /// Show an error [SnackBar].
  void showErrorSnackBar(String message) {
    showSnackBar(message, duration: const Duration(seconds: 4));
  }

  // ── Navigation shortcuts ─────────────────────────────────────────────

  /// Pop the current route.
  void pop<T>([T? result]) => Navigator.of(this).pop(result);

  /// Whether the navigator can pop.
  bool get canPop => Navigator.of(this).canPop();
}
