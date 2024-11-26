import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../data.dart';
import '../widgets/gif_carousel_widget.dart';
import '../widgets/top_nav_bar.dart';
import 'chart/candle_chart.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopNavBar(title: 'Home'),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SelectableText('Welcome to the Home Page'),
              const Gap(16),
              const GifCarousel(),
              const Gap(16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/plays');
                },
                child: const Text('Start'),
              ),
              const Gap(16),
              SizedBox(
                height: 300,
                child: CandleChart(stock: kStocks[0]),
              ),
              const Gap(500),
            ],
          ),
        ),
      ),
    );
  }
}
