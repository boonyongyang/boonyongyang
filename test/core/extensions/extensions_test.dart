import 'package:flutter_test/flutter_test.dart';
import 'package:boonyongyang/core/extensions/string_x.dart';
import 'package:boonyongyang/core/extensions/build_context_x.dart';
import 'package:flutter/material.dart';

void main() {
  group('StringX', () {
    test('capitalised capitalises the first letter', () {
      expect('hello'.capitalised, 'Hello');
    });

    test('capitalised handles empty string', () {
      expect(''.capitalised, '');
    });

    test('capitalised handles single char', () {
      expect('a'.capitalised, 'A');
    });

    test('toTitleCase converts camelCase', () {
      expect('camelCase'.toTitleCase, 'Camel Case');
    });

    test('toTitleCase converts PascalCase', () {
      expect('PascalCase'.toTitleCase, 'Pascal Case');
    });
  });

  group('BuildContextX', () {
    testWidgets('exposes theme and colorScheme', (tester) async {
      late ThemeData capturedTheme;
      late ColorScheme capturedScheme;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.dark(),
          home: Builder(
            builder: (context) {
              capturedTheme = context.theme;
              capturedScheme = context.colorScheme;
              return const SizedBox();
            },
          ),
        ),
      );

      expect(capturedTheme.brightness, Brightness.dark);
      expect(capturedScheme, capturedTheme.colorScheme);
    });

    testWidgets('isDarkMode returns true for dark theme', (tester) async {
      late bool dark;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.dark(),
          home: Builder(
            builder: (context) {
              dark = context.isDarkMode;
              return const SizedBox();
            },
          ),
        ),
      );

      expect(dark, isTrue);
    });

    testWidgets('screenSize returns non-zero size', (tester) async {
      late Size size;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              size = context.screenSize;
              return const SizedBox();
            },
          ),
        ),
      );

      expect(size.width, greaterThan(0));
      expect(size.height, greaterThan(0));
    });
  });
}
