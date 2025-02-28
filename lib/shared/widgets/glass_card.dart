import 'package:flutter/material.dart';
import '../../core/constants/animation_constants.dart';

class GlassCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsets padding;
  final Duration delay;
  final bool elevated;
  final Color? accentColor;

  const GlassCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(24),
    this.delay = Duration.zero,
    this.elevated = true,
    this.accentColor,
  });

  @override
  State<GlassCard> createState() => _GlassCardState();
}

class _GlassCardState extends State<GlassCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: AnimationConstants.mediumDuration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.95,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: AnimationConstants.softEasing,
    ));

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: AnimationConstants.softEasing,
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
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: child,
          ),
        );
      },
      child: MouseRegion(
        cursor: widget.onTap != null
            ? SystemMouseCursors.click
            : SystemMouseCursors.basic,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: AnimationConstants.shortDuration,
            curve: AnimationConstants.softEasing,
            padding: widget.padding,
            transform: Matrix4.identity()
              ..translate(0.0, _isHovered ? -4.0 : 0.0)
              ..scale(_isHovered ? 1.02 : 1.0),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(_isHovered ? 0.05 : 0.03),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: (widget.accentColor ?? Colors.white).withOpacity(
                  _isHovered ? 0.12 : 0.08,
                ),
              ),
              boxShadow: widget.elevated
                  ? [
                      BoxShadow(
                        color: (widget.accentColor ?? Colors.white).withOpacity(
                          _isHovered ? 0.04 : 0.02,
                        ),
                        blurRadius: _isHovered ? 24 : 20,
                        spreadRadius: _isHovered ? -2 : -4,
                      ),
                      BoxShadow(
                        color: Colors.black.withOpacity(
                          _isHovered ? 0.3 : 0.5,
                        ),
                        blurRadius: 20,
                        spreadRadius: -10,
                      ),
                    ]
                  : null,
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
