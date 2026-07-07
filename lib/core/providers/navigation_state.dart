import 'package:flutter/material.dart';

/// Tracks the current navigation path and notifies listeners on changes.
///
/// Registered as a lazy singleton via [GetIt]. Used by the [NavigationObserver]
/// in [GoRouter] to keep route state observable outside the widget tree.
class NavigationState extends ChangeNotifier {
  String _currentPath = '/';

  /// The currently active route path.
  String get currentPath => _currentPath;

  /// Update the tracked route. Listeners are only notified when the value changes.
  void updatePath(String path) {
    if (_currentPath != path) {
      _currentPath = path;
      notifyListeners();
    }
  }

  /// Whether the given [path] is a prefix of the current route.
  bool isActive(String path) => _currentPath.startsWith(path);
}
