import 'package:flutter/material.dart';
import '../../../shared/widgets/top_nav_bar.dart';
import 'candle_chart.dart';
import 'stock_item.dart';

class ChartsPage extends StatelessWidget {
  const ChartsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopNavBar(title: 'Charts'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CandleChart(
                          stock: StockItem(
                            name: 'AAPL',
                            symbol: 'AAPL',
                            price: 100,
                            change: 2.5,
                            volume: 1000000,
                            date: DateTime.now(),
                            open: 98.5,
                            high: 101.2,
                            low: 98.0,
                            close: 100.0,
                            changePercentage: 2.5,
                          ),
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.show_chart),
                  label: const Text('Candle Chart'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CandleChart(
                          stock: StockItem(
                            name: 'GOOGL',
                            symbol: 'GOOGL',
                            price: 150,
                            change: -1.2,
                            volume: 500000,
                            date: DateTime.now(),
                            open: 152.0,
                            high: 153.5,
                            low: 149.0,
                            close: 150.0,
                            changePercentage: -1.2,
                          ),
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.candlestick_chart),
                  label: const Text('GOOGL Chart'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
