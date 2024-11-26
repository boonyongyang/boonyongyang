import 'dart:async';
import 'package:flutter/material.dart';

class FakeLocationLoadingWidget extends StatefulWidget {
  const FakeLocationLoadingWidget({super.key});

  @override
  FakeLocationLoadingWidgetState createState() =>
      FakeLocationLoadingWidgetState();
}

class FakeLocationLoadingWidgetState extends State<FakeLocationLoadingWidget> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 15), () {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _isLoading
          ? const CircularProgressIndicator()
          : const Text('haha you got pranked!'),
    );
  }
}
