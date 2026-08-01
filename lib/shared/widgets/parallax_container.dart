import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ParallaxContainer extends StatefulWidget {
  final Widget child;
  final double multiplier;
  final EdgeInsets position;

  const ParallaxContainer({
    super.key,
    required this.child,
    this.multiplier = 1.0,
    required this.position,
  });

  @override
  State<ParallaxContainer> createState() => _ParallaxContainerState();
}

class _ParallaxContainerState extends State<ParallaxContainer> {
  late Offset _position;
  final _defaultPosition = const Offset(0, 0);
  bool _shouldOptimize = false;

  @override
  void initState() {
    super.initState();
    _position = _defaultPosition;
  }

  void _updatePosition(Offset mousePosition) {
    if (!_shouldOptimize) {
      final box = context.findRenderObject() as RenderBox;
      final center = box.size.center(box.localToGlobal(Offset.zero));

      setState(() {
        _position = (mousePosition - center) * 0.01 * widget.multiplier;
      });
    }
  }

  // Throttle updates for better performance
  void _onHover(PointerHoverEvent event) {
    if (!_shouldOptimize) {
      _shouldOptimize = true;
      _updatePosition(event.position);
      Future.delayed(const Duration(milliseconds: 16), () {
        if (mounted) {
          _shouldOptimize = false;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    return Positioned(
      left: widget.position.left,
      top: widget.position.top,
      right: widget.position.right,
      bottom: widget.position.bottom,
      child: MouseRegion(
        onHover: reduceMotion ? null : _onHover,
        onExit: reduceMotion
            ? null
            : (_) => setState(() => _position = _defaultPosition),
        child: RepaintBoundary(
          child: AnimatedContainer(
            duration: reduceMotion
                ? Duration.zero
                : const Duration(milliseconds: 100),
            curve: Curves.easeOutCubic,
            transform: Matrix4.identity()
              ..translate(
                reduceMotion ? 0.0 : _position.dx,
                reduceMotion ? 0.0 : _position.dy,
              ),
            transformAlignment: Alignment.center,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
