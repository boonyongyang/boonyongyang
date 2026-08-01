import 'package:boonyongyang/apps/landing/landing_app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('landing page renders the revamped hero and capability copy',
      (tester) async {
    await tester.pumpWidget(const LandingApp());
    await tester.pumpAndSettle();

    expect(find.text('Boon Yong Yang'), findsWidgets);
    expect(
      find.text('Flutter engineer shipping production mobile products'),
      findsOneWidget,
    );
    expect(find.text('A focused Flutter stack, not a wall of badges.'),
        findsOneWidget);
    expect(find.text('Technical Excellence'), findsNothing);
  });

  testWidgets('theme menu switches from Studio Light to Signal Amber',
      (tester) async {
    await tester.pumpWidget(const LandingApp());
    await tester.pumpAndSettle();

    expect(find.text('Light'), findsOneWidget);

    await tester.tap(find.text('Light'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Signal Amber').last);
    await tester.pumpAndSettle();

    expect(find.text('Amber'), findsOneWidget);
  });

  testWidgets('versions menu exposes every independently hosted surface',
      (tester) async {
    await tester.pumpWidget(const LandingApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Versions'));
    await tester.pumpAndSettle();

    expect(find.text('Flutter portfolio'), findsOneWidget);
    expect(find.text('Flutter interactive app'), findsOneWidget);
    expect(find.text('Next.js + Three.js portfolio'), findsOneWidget);
    expect(find.text('3D themes'), findsOneWidget);
    expect(find.text('Release Bench'), findsOneWidget);
    expect(find.text('Field Manual'), findsOneWidget);
    expect(find.text('Store Review Room'), findsOneWidget);
    expect(find.text('Current'), findsOneWidget);
  });

  testWidgets('production app proof stays inline on the landing page',
      (tester) async {
    await tester.pumpWidget(const LandingApp());
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Involve Asia Mobile App'));
    await tester.pumpAndSettle();

    expect(find.text('iOS and Android'), findsWidgets);
    expect(find.textContaining('50K+'), findsNothing);
    expect(find.text('App Store'), findsWidgets);
    expect(find.text('Google Play'), findsWidgets);
    expect(find.text('Case Study'), findsNothing);
  });
}
