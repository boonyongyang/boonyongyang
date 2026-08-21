import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../core/constants/animation_constants.dart';
import '../../core/theme/color_palette.dart';
import '../../features/labs/view/theme_showcase_page.dart';
import 'elegant_shape.dart';
import 'parallax_container.dart';

const _indigoShapeGradient = <Color>[
  Color(0x266366F1),
  Color(0x006366F1),
];
const _pinkShapeGradient = <Color>[
  Color(0x26EC4899),
  Color(0x00EC4899),
];
const _purpleShapeGradient = <Color>[
  Color(0x268B5CF6),
  Color(0x008B5CF6),
];
const _cyanShapeGradient = <Color>[
  Color(0x2606B6D4),
  Color(0x0006B6D4),
];
const _amberShapeGradient = <Color>[
  Color(0x26F59E0B),
  Color(0x00F59E0B),
];

class AnimatedHeroSection extends StatelessWidget {
  final String badge;
  final String title1;
  final String title2;
  final String description;

  const AnimatedHeroSection({
    super.key,
    required this.badge,
    required this.title1,
    required this.title2,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    final entranceDuration =
        reduceMotion ? Duration.zero : AnimationConstants.longDuration;
    final detailDuration =
        reduceMotion ? Duration.zero : AnimationConstants.mediumDuration;

    return Stack(
      children: [
        // Background gradient
        Positioned.fill(
          child: RepaintBoundary(
            child: Container(
              decoration: BoxDecoration(
                gradient: ColorPalette.heroGradient,
              ),
            ),
          ),
        ),

        // Elegant shapes layer with RepaintBoundary
        const RepaintBoundary(
          child: Stack(
            children: [
              ParallaxContainer(
                multiplier: 1.2,
                position: EdgeInsets.only(left: -50, top: 100),
                child: ElegantShape(
                  width: 600,
                  height: 140,
                  rotate: 12,
                  delay: Duration(milliseconds: 300),
                  gradientColors: _indigoShapeGradient,
                  useRandomColors: false,
                ),
              ),
              ParallaxContainer(
                multiplier: 0.8,
                position: EdgeInsets.only(right: -20, bottom: 100),
                child: ElegantShape(
                  width: 500,
                  height: 120,
                  rotate: -15,
                  delay: Duration(milliseconds: 500),
                  enableGlow: true,
                  gradientColors: _pinkShapeGradient,
                  useRandomColors: false,
                ),
              ),
              ParallaxContainer(
                multiplier: 1.5,
                position: EdgeInsets.only(left: 50, bottom: 50),
                child: ElegantShape(
                  width: 300,
                  height: 80,
                  rotate: -8,
                  delay: Duration(milliseconds: 400),
                  gradientColors: _purpleShapeGradient,
                  useRandomColors: false,
                ),
              ),
              ParallaxContainer(
                multiplier: 0.6,
                position: EdgeInsets.only(right: 100, top: 80),
                child: ElegantShape(
                  width: 200,
                  height: 60,
                  rotate: 20,
                  delay: Duration(milliseconds: 600),
                  gradientColors: _cyanShapeGradient,
                  useRandomColors: false,
                ),
              ),
              ParallaxContainer(
                multiplier: 1.0,
                position: EdgeInsets.only(left: 150, top: 50),
                child: ElegantShape(
                  width: 150,
                  height: 40,
                  rotate: -25,
                  delay: Duration(milliseconds: 700),
                  gradientColors: _amberShapeGradient,
                  useRandomColors: false,
                ),
              ),
            ],
          ),
        ),

        // Content with enhanced performance
        RepaintBoundary(
          child: Center(
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 30, end: 0),
              duration: entranceDuration,
              curve: AnimationConstants.customEasing,
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, value),
                  transformHitTests: false,
                  child: child,
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: detailDuration,
                      curve: AnimationConstants.softEasing,
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: 0.8 + (0.2 * value),
                          child: Opacity(
                            opacity: value,
                            child: child,
                          ),
                        );
                      },
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ThemeShowcasePage(),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: ColorPalette.glassEffect,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: Colors.pink.withOpacity(0.8),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const Gap(8),
                              Text(
                                badge,
                                style: TextStyle(
                                  color: ColorPalette.textSecondary,
                                  fontSize: 14,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Gap(40),

                    // Animated titles with gradient effects
                    ShaderMask(
                      shaderCallback: (bounds) =>
                          ColorPalette.titleGradient.createShader(bounds),
                      child: Text(
                        title1,
                        style:
                            Theme.of(context).textTheme.displayMedium?.copyWith(
                                  color: ColorPalette.textPrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Gap(16),
                    ShaderMask(
                      shaderCallback: (bounds) =>
                          ColorPalette.accentTitleGradient.createShader(bounds),
                      child: Text(
                        title2,
                        style:
                            Theme.of(context).textTheme.displayLarge?.copyWith(
                                  color: ColorPalette.textPrimary,
                                  fontWeight: FontWeight.w900,
                                ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Gap(24),

                    // Animated description
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: entranceDuration,
                      curve: AnimationConstants.softEasing,
                      builder: (context, value, child) {
                        return Opacity(
                          opacity: value,
                          child: Transform.translate(
                            offset: Offset(0, 20 * (1 - value)),
                            transformHitTests: false,
                            child: child,
                          ),
                        );
                      },
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 600),
                        child: Text(
                          description,
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: Colors.white.withOpacity(0.82),
                                    height: 1.5,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Enhanced gradient overlays
        Positioned.fill(
          child: IgnorePointer(
            child: RepaintBoundary(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.8),
                      Colors.transparent,
                      Colors.transparent,
                      Colors.black.withOpacity(0.8),
                    ],
                    stops: const [0.0, 0.2, 0.8, 1.0],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
