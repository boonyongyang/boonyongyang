import 'package:flutter/material.dart';
import 'pages/landing_page.dart';
import 'theme/landing_theme.dart';

class LandingApp extends StatelessWidget {
  const LandingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Boon Yong Yang - Portfolio',
      theme: LandingTheme.lightTheme,
      darkTheme: LandingTheme.darkTheme,
      themeMode: ThemeMode.dark,
      home: const LandingPage(),
    );
  }
}
