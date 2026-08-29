import 'package:boonyongyang/shared/widgets/portfolio_version_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('version menu marks the active surface and exposes every build',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: PortfolioVersionMenu(
              currentSurface: PortfolioSurface.flutterInteractive,
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Versions'));
    await tester.pumpAndSettle();

    expect(find.text('Flutter portfolio'), findsOneWidget);
    expect(find.text('Flutter interactive app'), findsOneWidget);
    expect(find.text('Next.js + Three.js portfolio'), findsOneWidget);
    expect(find.text('V4 Release Dossier'), findsOneWidget);
    expect(find.text('V5 Wildfield'), findsOneWidget);
    expect(find.text('3D themes'), findsOneWidget);
    expect(find.text('Release Bench'), findsOneWidget);
    expect(find.text('Field Manual'), findsOneWidget);
    expect(find.text('Store Review Room'), findsOneWidget);
    expect(find.text('Current'), findsOneWidget);
    expect(find.byIcon(Icons.check), findsOneWidget);
  });

  test('portfolio surfaces use the canonical public URLs', () {
    expect(
      PortfolioSurface.flutterPortfolio.url,
      'https://boonyongyang.com',
    );
    expect(
      PortfolioSurface.flutterInteractive.url,
      'https://app.boonyongyang.com',
    );
    expect(
      PortfolioSurface.nextThree.url,
      'https://3d.boonyongyang.com',
    );
    expect(
      PortfolioSurface.releaseDossier.url,
      'https://v4.boonyongyang.com',
    );
    expect(
      PortfolioSurface.wildfield.url,
      'https://v5.boonyongyang.com',
    );
  });

  test('3D themes use directly shareable canonical URLs', () {
    expect(
      PortfolioThreeTheme.releaseBench.url,
      'https://3d.boonyongyang.com/themes/release-bench/',
    );
    expect(
      PortfolioThreeTheme.fieldManual.url,
      'https://3d.boonyongyang.com/themes/field-manual/',
    );
    expect(
      PortfolioThreeTheme.reviewRoom.url,
      'https://3d.boonyongyang.com/themes/review-room/',
    );
  });
}
