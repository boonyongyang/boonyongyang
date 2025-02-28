import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/style/style.dart';

class DateTimerWidget extends StatefulWidget {
  const DateTimerWidget({super.key});

  @override
  State<DateTimerWidget> createState() => _DateTimerWidgetState();
}

class _DateTimerWidgetState extends State<DateTimerWidget> {
  late Timer _timer;
  String _currentTime = '';

  @override
  void initState() {
    super.initState();
    _currentTime = _getCurrentTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (mounted) {
        setState(() {
          _currentTime = _getCurrentTime();
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _getCurrentTime() {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md, vertical: AppSpacing.sm),
        decoration: BoxDecoration(
          gradient: AppGradients.cyberHorizon,
          borderRadius: AppBorders.roundedMedium,
          boxShadow: AppShadows.subtle,
        ),
        child: SelectableText(
          _currentTime,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.hologramWhite,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
    );
  }
}
