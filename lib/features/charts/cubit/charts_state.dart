part of 'charts_cubit.dart';

/// Base state for the charts feature.
sealed class ChartsState extends Equatable {
  const ChartsState();

  @override
  List<Object?> get props => [];
}

/// No data loaded yet.
final class ChartsInitial extends ChartsState {
  const ChartsInitial();
}

/// Stocks are being fetched / prepared.
final class ChartsLoading extends ChartsState {
  const ChartsLoading();
}

/// Stocks loaded successfully.
final class ChartsLoaded extends ChartsState {
  const ChartsLoaded({required this.stocks, this.selectedStock});

  /// The full list of available stocks.
  final List<StockItem> stocks;

  /// The currently selected stock (null = none).
  final StockItem? selectedStock;

  @override
  List<Object?> get props => [stocks, selectedStock];
}

/// Something went wrong loading stock data.
final class ChartsError extends ChartsState {
  const ChartsError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
