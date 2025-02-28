import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';

class PerformanceConfig extends ChangeNotifier {
  bool _reduceAnimations = false;
  bool _enableParallax = true;
  bool _enableBlur = true;
  int _targetFrameRate = 60;
  bool _isHighPerformanceMode = true;

  bool get reduceAnimations => _reduceAnimations;
  bool get enableParallax => _enableParallax && _isHighPerformanceMode;
  bool get enableBlur => _enableBlur && _isHighPerformanceMode;
  int get targetFrameRate => _targetFrameRate;
  bool get isHighPerformanceMode => _isHighPerformanceMode;

  void setHighPerformanceMode(bool enable) {
    if (_isHighPerformanceMode != enable) {
      _isHighPerformanceMode = enable;
      _applyPerformanceSettings();
      notifyListeners();
    }
  }

  void _applyPerformanceSettings() {
    if (_isHighPerformanceMode) {
      SchedulerBinding.instance.resetEpoch();
      _targetFrameRate = 60;
    } else {
      _targetFrameRate = 30;
      _enableBlur = false;
      _enableParallax = false;
    }
  }

  void setReduceAnimations(bool reduce) {
    if (_reduceAnimations != reduce) {
      _reduceAnimations = reduce;
      notifyListeners();
    }
  }

  void optimizeForDevice() {
    if (kIsWeb) {
      // Web-specific optimizations
      if (defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.android) {
        // Mobile web optimizations
        setHighPerformanceMode(false);
        setReduceAnimations(true);
      } else {
        // Desktop web optimizations
        setHighPerformanceMode(true);
        setReduceAnimations(false);
      }
    } else {
      // Native platform optimizations
      setHighPerformanceMode(true);
      setReduceAnimations(false);
    }
  }

  void enableLowPowerMode() {
    setHighPerformanceMode(false);
    setReduceAnimations(true);
  }

  Duration getAnimationDuration(Duration normalDuration) {
    if (_reduceAnimations) {
      return Duration(milliseconds: normalDuration.inMilliseconds ~/ 2);
    }
    return normalDuration;
  }

  // Helper method to determine if expensive effects should be enabled
  bool shouldEnableExpensiveEffects() {
    return _isHighPerformanceMode && !_reduceAnimations;
  }
}
