import 'package:flutter/material.dart';

class NavigationState extends ChangeNotifier {
  String _currentPath = '/';

  String get currentPath => _currentPath;

  void updatePath(String path) {
    if (_currentPath != path) {
      _currentPath = path;
      notifyListeners();
    }
  }

  bool isActive(String path) => _currentPath.startsWith(path);
}
