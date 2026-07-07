import 'package:equatable/equatable.dart';

/// Represents a stock with OHLCV pricing data.
class StockItem extends Equatable {
  const StockItem({
    required this.name,
    required this.symbol,
    required this.price,
    required this.change,
    required this.changePercentage,
    required this.volume,
    required this.date,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
  });

  final String name;
  final String symbol;
  final double price;
  final double change;
  final double changePercentage;
  final int volume;
  final DateTime date;
  final double open;
  final double high;
  final double low;
  final double close;

  /// Whether the stock closed higher than it opened.
  bool get isBullish => close >= open;

  @override
  List<Object?> get props => [
        symbol,
        date,
        open,
        high,
        low,
        close,
        volume,
      ];

  @override
  String toString() =>
      'StockItem($symbol, \$$price, ${change >= 0 ? "+" : ""}$change%)';
}
