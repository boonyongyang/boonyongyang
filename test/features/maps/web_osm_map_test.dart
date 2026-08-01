import 'package:boonyongyang/features/maps/view/osm_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('web map renders OSM tiles, controls, and attribution',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 1280,
            height: 720,
            child: WebOsmMap(
              tileBuilder: (url) => Text(url),
            ),
          ),
        ),
      ),
    );

    expect(
        find.textContaining('tile.openstreetmap.org/14/'), findsNWidgets(49));
    expect(find.text('© OpenStreetMap contributors'), findsOneWidget);
    expect(find.byTooltip('Zoom in'), findsOneWidget);
    expect(find.byTooltip('Zoom out'), findsOneWidget);

    await tester.tap(find.byTooltip('Zoom in'));
    await tester.pump();

    expect(
        find.textContaining('tile.openstreetmap.org/15/'), findsNWidgets(49));
  });
}
