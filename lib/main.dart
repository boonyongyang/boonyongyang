import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MyHomePage(title: 'just a demo app');
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
        body: Center(
          child: PageView(
            controller: _pageController,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: _toggleTheme,
                    child: const Text('Toggle Theme'),
                  ),
                  const SelectableText(
                    'u push this button how many times already ',
                  ),
                  Builder(
                    // for theme change to take effect
                    builder: (BuildContext context) {
                      return SelectableText(
                        '$_counter times!',
                        style: Theme.of(context).textTheme.headlineMedium,
                      );
                    },
                  ),
                  const Gap(30.0),
                  // button to go page view 2
                  ElevatedButton(
                    onPressed: () {
                      _pageController.animateToPage(
                        1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: const Text('Go to Page 2'),
                  ),
                  const Gap(30.0),
                  const SelectableText(
                      'Github: https://github.com/boonyongyang'),
                  const Gap(30.0),
                  Image.network(
                    'https://i.giphy.com/media/v1.Y2lkPTc5MGI3NjExMHRyaDE1YXlxdzBqaTk0dGxneDVnZDR1M2Fya3Q1ODBpMW5icXRyeiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/ZdIzhi10ZlKhU8EpDh/giphy.gif',
                    height: MediaQuery.of(context).size.width * 0.2,
                  ),
                  const Gap(30.0),
                  const RunningDateTimer(),
                  const Gap(30.0),
                  const RandomQuote(),
                  const Gap(30.0),
                  const UserIPAddress(),
                  //
                ],
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _pageController.animateToPage(
                          0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: const Text('Go to Page 1'),
                    ),
                    ListView.builder(
                      itemCount: 30,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Image.network(
                          'https://i.giphy.com/media/v1.Y2lkPTc5MGI3NjExMHRyaDE1YXlxdzBqaTk0dGxneDVnZDR1M2Fya3Q1ODBpMW5icXRyeiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/ZdIzhi10ZlKhU8EpDh/giphy.gif',
                          // height: MediaQuery.of(context).size.width * 0.2,
                        );
                      },
                    ),
                    const Gap(30.0),
                  ],
                ),
              ),
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

class RunningDateTimer extends StatefulWidget {
  const RunningDateTimer({super.key});

  @override
  State<RunningDateTimer> createState() => _RunningDateTimerState();
}

class _RunningDateTimerState extends State<RunningDateTimer> {
  late Timer _timer;
  String _currentTime = '';

  @override
  void initState() {
    super.initState();
    _currentTime = _getCurrentTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        _currentTime = _getCurrentTime();
      });
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
      child: Text(
        _currentTime,
        style: const TextStyle(fontSize: 24),
      ),
    );
  }
}

class RandomQuote extends StatefulWidget {
  const RandomQuote({super.key});

  @override
  State<RandomQuote> createState() => _RandomQuoteState();
}

class _RandomQuoteState extends State<RandomQuote> {
  late Timer _timer;
  String _currentQuote = '';
  double _progressValue = 0.0;
  final List<String> _quotes = [
    'The best way to predict the future is to invent it.',
    'Life is 10% what happens to us and 90% how we react to it.',
    'The only way to do great work is to love what you do.',
    'Don\'t watch the clock; do what it does. Keep going.',
    'The future belongs to those who believe in the beauty of their dreams.',
    'It does not matter how slowly you go as long as you do not stop.',
    'The only limit to our realization of tomorrow will be our doubts of today.',
    'The best preparation for tomorrow is doing your best today.',
    'The only thing we have to fear is fear itself.',
    'The only thing that will stop you from fulfilling your dreams is you.',
    'If you are working on something that you really care about, you don\'t have to be pushed. The vision pulls you.',
    'Let us make our future now, and let us make our dreams tomorrow\'s reality.',
    'Believe you can and you\'re halfway there.',
    'The best way to get started is to quit talking and begin doing.',
    'The future belongs to those who believe in the beauty of their dreams.',
    'Don\'t be pushed around by the fears in your mind. Be led by the dreams in your heart.',
    'The only limit to our realization of tomorrow will be our doubts of today.',
    'The best preparation for tomorrow is doing your best today.',
    'The only thing we have to fear is fear itself.',
  ];

  @override
  void initState() {
    super.initState();
    _currentQuote = _getRandomQuote();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (Timer timer) {
      setState(() {
        _progressValue += 0.02;
        if (_progressValue >= 1.0) {
          _progressValue = 0.0;
          _currentQuote = _getRandomQuote();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _getRandomQuote() {
    return _quotes[DateTime.now().second % _quotes.length];
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SelectableText(
            _currentQuote,
            style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          LinearProgressIndicator(value: _progressValue),
          const SizedBox(height: 20),
          Text('${(_progressValue * 100).round()}%'),
          IconButton(
            onPressed: () {
              setState(() {
                _currentQuote = _getRandomQuote();
                _progressValue = 0.0;
              });
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}

class UserIPAddress extends StatefulWidget {
  const UserIPAddress({super.key});

  @override
  UserIPAddressState createState() => UserIPAddressState();
}

class UserIPAddressState extends State<UserIPAddress> {
  String _ipAddress = 'Fetching IP...';

  @override
  void initState() {
    super.initState();
    _fetchIPAddress();
  }

  Future<void> _fetchIPAddress() async {
    final response =
        await http.get(Uri.parse('https://api.ipify.org?format=json'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _ipAddress = data['ip'];
      });
    } else {
      setState(() {
        _ipAddress = 'Failed to fetch IP';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SelectableText('Your IP Address:'),
        SelectableText(_ipAddress),
        const SelectableText('Your Location:'),
        const Gap(10.0),
        const FakeLocationLoadingWidget(),
      ],
    );
  }
}

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
