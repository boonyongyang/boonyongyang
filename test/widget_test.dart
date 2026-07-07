import 'package:flutter_test/flutter_test.dart';
import 'package:boonyongyang/apps/app_config.dart';

void main() {
  test('AppConfig defaults to landing mode', () {
    expect(AppConfig.isLanding, isTrue);
    expect(AppConfig.isMainApp, isFalse);
  });
}
