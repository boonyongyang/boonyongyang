import 'package:flutter/material.dart';
import '../../core/providers/performance_config.dart';
import '../../core/di/service_locator.dart';

class RecyclerList extends StatefulWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final double itemExtent;
  final Axis scrollDirection;
  final bool reverse;
  final ScrollController? controller;
  final bool? primary;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final EdgeInsets? padding;

  const RecyclerList({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    required this.itemExtent,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.controller,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
  });

  @override
  State<RecyclerList> createState() => _RecyclerListState();
}

class _RecyclerListState extends State<RecyclerList> {
  final _performanceConfig = getIt<PerformanceConfig>();
  final Set<int> _visibleItems = {};
  final Map<int, Widget> _cachedItems = {};
  bool _isScrolling = false;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: ListView.builder(
        itemCount: widget.itemCount,
        controller: widget.controller,
        scrollDirection: widget.scrollDirection,
        reverse: widget.reverse,
        primary: widget.primary,
        physics: widget.physics,
        shrinkWrap: widget.shrinkWrap,
        padding: widget.padding,
        itemExtent: widget.itemExtent,
        itemBuilder: (context, index) {
          if (!_visibleItems.contains(index)) {
            _visibleItems.add(index);
          }

          if (!_cachedItems.containsKey(index)) {
            _cachedItems[index] = widget.itemBuilder(context, index);

            // Clear cache if it gets too large
            if (_cachedItems.length > 100) {
              _clearUnusedCache();
            }
          }

          return RepaintBoundary(
            child: AnimatedSwitcher(
              duration: _performanceConfig.getAnimationDuration(
                const Duration(milliseconds: 300),
              ),
              child: _isScrolling
                  ? _buildOptimizedItem(index)
                  : _cachedItems[index]!,
            ),
          );
        },
      ),
    );
  }

  Widget _buildOptimizedItem(int index) {
    if (_performanceConfig.isHighPerformanceMode) {
      return _cachedItems[index]!;
    }

    // Return a simplified version during scrolling in low performance mode
    return Container(
      height: widget.itemExtent,
      color: Colors.transparent,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void _clearUnusedCache() {
    final keysToRemove =
        _cachedItems.keys.where((key) => !_visibleItems.contains(key)).toList();

    for (final key in keysToRemove) {
      _cachedItems.remove(key);
    }
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollStartNotification) {
      setState(() => _isScrolling = true);
    } else if (notification is ScrollEndNotification) {
      Future.delayed(
        const Duration(milliseconds: 100),
        () {
          if (mounted) {
            setState(() => _isScrolling = false);
          }
        },
      );
    }
    return false;
  }

  @override
  void dispose() {
    _cachedItems.clear();
    _visibleItems.clear();
    super.dispose();
  }
}
