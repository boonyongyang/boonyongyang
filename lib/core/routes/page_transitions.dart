import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../constants/animation_constants.dart';

CustomTransitionPage<T> buildPageWithTransition<T>({
  required Widget child,
  required String? name,
  required Object? arguments,
  required String? restorationId,
  LocalKey? key,
  String? title,
}) {
  return CustomTransitionPage<T>(
    key: key,
    name: name,
    arguments: arguments,
    restorationId: restorationId,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final fadeAnimation = CurvedAnimation(
        parent: animation,
        curve: AnimationConstants.customEasing,
      );

      final scaleAnimation = Tween<double>(
        begin: 0.98,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: AnimationConstants.softEasing,
      ));

      final slideAnimation = Tween<Offset>(
        begin: const Offset(0, 10),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: AnimationConstants.customEasing,
      ));

      return FadeTransition(
        opacity: fadeAnimation,
        child: Transform.scale(
          scale: scaleAnimation.value,
          child: Transform.translate(
            offset: Offset(0, slideAnimation.value.dy),
            child: child,
          ),
        ),
      );
    },
    transitionDuration: AnimationConstants.mediumDuration,
  );
}
