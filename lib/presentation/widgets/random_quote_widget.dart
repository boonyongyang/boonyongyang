import 'dart:async';
import 'package:flutter/material.dart';

class RandomQuoteWidget extends StatefulWidget {
  const RandomQuoteWidget({super.key});

  @override
  State<RandomQuoteWidget> createState() => _RandomQuoteWidgetState();
}

class _RandomQuoteWidgetState extends State<RandomQuoteWidget> {
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
