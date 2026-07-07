import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/sample_stock_data.dart';
import '../model/stock_item.dart';

part 'charts_state.dart';

/// Cubit that manages the available stock list and selected stock.
class ChartsCubit extends Cubit<ChartsState> {
  ChartsCubit() : super(const ChartsInitial());

  /// Load the stock catalogue from sample data.
  void loadStocks() {
    emit(const ChartsLoading());
    try {
      final stocks = List<StockItem>.unmodifiable(kStocks);
      emit(ChartsLoaded(stocks: stocks));
    } catch (e) {
      emit(ChartsError('Failed to load stocks: $e'));
    }
  }

  /// Select a [stock] for detailed charting.
  void selectStock(StockItem stock) {
    final current = state;
    if (current is ChartsLoaded) {
      emit(ChartsLoaded(stocks: current.stocks, selectedStock: stock));
    }
  }
}
