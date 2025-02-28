/// A placeholder class that represents a stock.
class StockItem {
  const StockItem({
    required this.name,
    required this.price,
    required this.change,
    required this.volume,
    required this.date,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.symbol,
    required this.changePercentage,
  });

  final String name;
  final double price;
  final double change;
  final int volume;
  final DateTime date;
  final double open;
  final double high;
  final double low;
  final double close;
  final String symbol;
  final double changePercentage;
}
