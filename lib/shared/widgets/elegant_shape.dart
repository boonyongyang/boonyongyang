import 'package:flutter/material.dart';
import '../../core/constants/animation_constants.dart';
import '../../core/theme/random_colors.dart';

class ElegantShape extends StatefulWidget {
  final double width;
  final double height;
  final double rotate;
  final Duration delay;
  final List<Color>? gradientColors;
  final bool enableGlow;
  final bool useRandomColors;

  const ElegantShape({
    super.key,
    required this.width,
    required this.height,
    this.rotate = 0,
    this.delay = Duration.zero,
    this.gradientColors,
    this.enableGlow = true,
    this.useRandomColors = true,
  });

  @override
  State<ElegantShape> createState() => _ElegantShapeState();
}

class _ElegantShapeState extends State<ElegantShape>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _rotateAnimation;
  late Animation<double> _scaleAnimation;
  late List<Color> _colors;

  @override
  void initState() {
    super.initState();
    _colors = widget.gradientColors ?? RandomColors.getRandomGradient();

    _controller = AnimationController(
      duration: AnimationConstants.extraLongDuration,
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.5, curve: AnimationConstants.customEasing),
    ));

    _slideAnimation = Tween<double>(
      begin: -150.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 1.0, curve: AnimationConstants.customEasing),
    ));

    _rotateAnimation = Tween<double>(
      begin: widget.rotate - 15,
      end: widget.rotate,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 1.0, curve: AnimationConstants.customEasing),
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 1.0, curve: AnimationConstants.softEasing),
    ));

    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform(
            transform: Matrix4.identity()
              ..rotateZ(_rotateAnimation.value * (3.14159 / 180))
              ..scale(_scaleAnimation.value),
            alignment: Alignment.center,
            child: Opacity(
              opacity: _fadeAnimation.value,
              child: Transform.translate(
                offset: Offset(0, _slideAnimation.value),
                child: SizedBox(
                  width: widget.width,
                  height: widget.height,
                  child: CustomPaint(
                    painter: _ElegantShapePainter(
                      colors: _colors,
                      enableGlow: widget.enableGlow,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ElegantShapePainter extends CustomPainter {
  final List<Color> colors;
  final bool enableGlow;

  _ElegantShapePainter({
    required this.colors,
    required this.enableGlow,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(100));

    // Draw shadow if enabled
    if (enableGlow) {
      final shadowPaint = Paint()
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 16);
      canvas.drawRRect(
          rrect, shadowPaint..color = colors.first.withOpacity(0.2));
    }

    // Draw gradient background
    final gradientPaint = Paint()
      ..shader = LinearGradient(
        colors: colors,
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).createShader(rect);
    canvas.drawRRect(rrect, gradientPaint);

    // Draw border
    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Colors.white.withOpacity(0.15);
    canvas.drawRRect(rrect, borderPaint);

    // Draw glass effect
    final glassRect = rrect.deflate(2);
    final glassPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.white.withOpacity(0.1),
          Colors.white.withOpacity(0.05),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(rect);
    canvas.drawRRect(glassRect, glassPaint);

    // Draw radial highlight
    final highlightPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.white.withOpacity(0.2),
          Colors.transparent,
        ],
        stops: const [0.0, 0.7],
      ).createShader(rect);
    canvas.drawRRect(glassRect, highlightPaint);
  }

  @override
  bool shouldRepaint(_ElegantShapePainter oldDelegate) =>
      colors != oldDelegate.colors || enableGlow != oldDelegate.enableGlow;
}
