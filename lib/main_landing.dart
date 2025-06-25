import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'apps/landing/landing_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Basic system UI setup for landing page
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
    ),
  );

  runApp(const LandingApp());
}
