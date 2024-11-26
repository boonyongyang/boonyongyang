import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../widgets/drawer_widget.dart';
import 'about_page.dart';
import 'home_page.dart';

class Index extends StatefulWidget {
  const Index({super.key, required this.title});

  final String title;

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  int _counter = 0;
  ThemeMode _themeMode = ThemeMode.light;
  final PageController _pageController = PageController(initialPage: 0);

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: _themeMode,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: SelectableText(widget.title),
        ),
        drawer: DrawerWidget(pageController: _pageController),
        body: Center(
          child: PageView(
            controller: _pageController,
            children: [
              HomePage(
                toggleTheme: _toggleTheme,
                counter: _counter,
                pageController: _pageController,
              ),
              AboutPage(pageController: _pageController),
            ],
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: _incrementCounter,
              tooltip: 'plus one',
              child: const Icon(Icons.add),
            ),
            const Gap(10.0),
            FloatingActionButton(
              onPressed: _decrementCounter,
              tooltip: 'minus one',
              child: const Icon(Icons.remove),
            ),
          ],
        ),
      ),
    );
  }
}
