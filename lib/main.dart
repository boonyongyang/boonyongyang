import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/osm/osm_widget.dart';
import 'pages/plays_page.dart';
import 'pages/labs_page.dart';
import 'pages/about_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'byy',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/plays': (context) => const PlaysPage(),
        '/labs': (context) => const LabsPage(),
        '/osm': (context) => const OsmWidget(),
        '/search': (context) => const SearchPage(),
        '/gemini': (context) => const OsmWidget(),
        '/chart': (context) => const OsmWidget(),
        '/animate': (context) => const OsmWidget(),
        '/about': (context) => const AboutPage(),
      },
    );
  }
}
