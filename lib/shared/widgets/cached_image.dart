import 'dart:async';

import 'package:flutter/material.dart';

class CachedImage extends StatefulWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Widget? placeholder;
  final Widget? errorWidget;
  final bool useCaching;

  const CachedImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit,
    this.placeholder,
    this.errorWidget,
    this.useCaching = true,
  });

  @override
  State<CachedImage> createState() => _CachedImageState();
}

class _CachedImageState extends State<CachedImage> {
  late ImageProvider _imageProvider;
  bool _isLoading = true;
  bool _hasError = false;
  static final Map<String, ImageProvider> _cache = {};

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    if (widget.useCaching && _cache.containsKey(widget.url)) {
      _imageProvider = _cache[widget.url]!;
      if (mounted) setState(() => _isLoading = false);
      return;
    }

    try {
      _imageProvider = NetworkImage(widget.url);
      if (widget.useCaching) {
        _cache[widget.url] = _imageProvider;
      }

      final imageStream = _imageProvider.resolve(ImageConfiguration.empty);
      final completer = Completer<void>();

      late ImageStreamListener listener;
      listener = ImageStreamListener(
        (info, synchronousCall) {
          imageStream.removeListener(listener);
          if (mounted) {
            setState(() => _isLoading = false);
          }
          completer.complete();
        },
        onError: (dynamic exception, StackTrace? stackTrace) {
          imageStream.removeListener(listener);
          if (mounted) {
            setState(() {
              _isLoading = false;
              _hasError = true;
            });
          }
          completer.completeError(exception);
        },
      );

      imageStream.addListener(listener);
      await completer.future;
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _hasError = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return widget.errorWidget ?? const SizedBox.shrink();
    }

    if (_isLoading) {
      return widget.placeholder ??
          const Center(child: CircularProgressIndicator());
    }

    return Image(
      image: _imageProvider,
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) return child;
        return AnimatedOpacity(
          opacity: frame == null ? 0 : 1,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          child: child,
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return widget.errorWidget ?? const SizedBox.shrink();
      },
    );
  }

  @override
  void dispose() {
    // Clean up resources if needed
    super.dispose();
  }
}
