import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

mixin ScrollPerformanceMixin<T extends StatefulWidget> on State<T> {
  // static const _frameInterval = Duration(milliseconds: 16);
  bool _isScrolling = false;
  DateTime? _lastScrollTime;
  int _frameCount = 0;

  void onScrollStart() {
    if (!_isScrolling) {
      _isScrolling = true;
      _frameCount = 0;
      _lastScrollTime = DateTime.now();
      _optimizeForScrolling();
    }
  }

  void onScrollEnd() {
    _isScrolling = false;
    _restoreNormalSettings();
  }

  void _optimizeForScrolling() {
    // Reduce visual quality during scrolling for better performance
    // Reduce frame rate to save resources during scrolling
    SchedulerBinding.instance.scheduleFrameCallback((_) {});

    // Disable animations during scroll
    if (mounted) {
      setState(() {
        // Your state updates for scroll optimization
      });
    }
  }

  void _restoreNormalSettings() {
    if (!mounted) return;

    // Delay restoration slightly to avoid jank
    Future.delayed(const Duration(milliseconds: 100), () {
      if (!_isScrolling && mounted) {
        setState(() {
          // Your state updates for normal mode
        });
      }
    });
  }

  // Call this in your scroll listener
  void handleScroll() {
    final now = DateTime.now();
    _lastScrollTime = now;
    _frameCount++;

    // Check frame rate and optimize if needed
    if (_frameCount > 5) {
      final duration = now.difference(_lastScrollTime ?? now);
      final fps = _frameCount * 1000 / duration.inMilliseconds;

      if (fps < 55) {
        // If frame rate drops below 55 fps
        _optimizeForScrolling();
      }
    }
  }

  @override
  void dispose() {
    _restoreNormalSettings();
    super.dispose();
  }
}
