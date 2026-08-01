import 'package:boonyongyang/shared/widgets/elegant_shape.dart';
import 'package:boonyongyang/shared/widgets/gif_carousel_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget reducedMotionApp(Widget child) {
    return MaterialApp(
      home: Builder(
        builder: (context) {
          final mediaQuery = MediaQuery.of(context);
          return MediaQuery(
            data: mediaQuery.copyWith(disableAnimations: true),
            child: Scaffold(body: child),
          );
        },
      ),
    );
  }

  testWidgets('GIF carousel stops autoplay when reduced motion is requested',
      (tester) async {
    await tester.pumpWidget(reducedMotionApp(const GifCarousel()));

    final carousel = tester.widget<CarouselSlider>(find.byType(CarouselSlider));
    expect(carousel.options.autoPlay, isFalse);
  });

  testWidgets('decorative shape renders its stable completed state',
      (tester) async {
    await tester.pumpWidget(
      reducedMotionApp(
        const ElegantShape(
          width: 200,
          height: 80,
          delay: Duration(seconds: 1),
        ),
      ),
    );

    final opacity = tester.widget<Opacity>(find.byType(Opacity));
    expect(opacity.opacity, 1);
  });
}
