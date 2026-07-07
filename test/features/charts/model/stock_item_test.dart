import 'package:flutter_test/flutter_test.dart';
import 'package:boonyongyang/features/charts/model/stock_item.dart';

void main() {
  group('StockItem', () {
    test('isBullish is true when close >= open', () {
      final stock = StockItem(
        name: 'Apple',
        symbol: 'AAPL',
        price: 150,
        change: 2,
        changePercentage: 1.5,
        volume: 1000000,
        date: DateTime(2024),
        open: 148,
        high: 152,
        low: 147,
        close: 150,
      );
      expect(stock.isBullish, isTrue);
    });

    test('isBullish is false when close < open', () {
      final stock = StockItem(
        name: 'Apple',
        symbol: 'AAPL',
        price: 147,
        change: -2,
        changePercentage: -1.5,
        volume: 1000000,
        date: DateTime(2024),
        open: 150,
        high: 151,
        low: 146,
        close: 147,
      );
      expect(stock.isBullish, isFalse);
    });

    test('two stocks with same OHLCV are equal', () {
      final date = DateTime(2024, 1, 1);
      final a = StockItem(
        name: 'X',
        symbol: 'X',
        price: 10,
        change: 0,
        changePercentage: 0,
        volume: 100,
        date: date,
        open: 10,
        high: 11,
        low: 9,
        close: 10,
      );
      final b = StockItem(
        name: 'X',
        symbol: 'X',
        price: 10,
        change: 0,
        changePercentage: 0,
        volume: 100,
        date: date,
        open: 10,
        high: 11,
        low: 9,
        close: 10,
      );
      expect(a, equals(b));
    });

    test('toString includes symbol and price', () {
      final stock = StockItem(
        name: 'Google',
        symbol: 'GOOGL',
        price: 150,
        change: 2,
        changePercentage: 1.5,
        volume: 500000,
        date: DateTime(2024),
        open: 148,
        high: 153,
        low: 147,
        close: 150,
      );
      expect(stock.toString(), contains('GOOGL'));
      expect(stock.toString(), contains('150'));
    });
  });
}
