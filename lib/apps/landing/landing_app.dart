import 'package:flutter/material.dart';

import 'pages/landing_page.dart';
import 'services/landing_theme_storage.dart';
import 'theme/landing_theme.dart';

class LandingApp extends StatefulWidget {
  const LandingApp({super.key});

  @override
  State<LandingApp> createState() => _LandingAppState();
}

class _LandingAppState extends State<LandingApp> {
  late LandingThemePreset _preset;

  @override
  void initState() {
    super.initState();
    _preset =
        LandingThemeStorage.loadPreset() ?? LandingThemePreset.studioLight;
  }

  void _setPreset(LandingThemePreset preset) {
    if (_preset == preset) {
      return;
    }

    LandingThemeStorage.savePreset(preset);
    setState(() => _preset = preset);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Boon Yong Yang - Portfolio',
      theme: LandingTheme.themeFor(_preset),
      home: LandingPage(
        activePreset: _preset,
        onThemeChanged: _setPreset,
      ),
    );
  }
}
