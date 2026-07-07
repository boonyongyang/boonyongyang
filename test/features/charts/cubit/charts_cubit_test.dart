import 'package:flutter_test/flutter_test.dart';
import 'package:boonyongyang/features/charts/cubit/charts_cubit.dart';
import 'package:boonyongyang/features/charts/model/stock_item.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  group('ChartsCubit', () {
    late ChartsCubit cubit;

    setUp(() {
      cubit = ChartsCubit();
    });

    tearDown(() => cubit.close());

    test('initial state is ChartsInitial', () {
      expect(cubit.state, isA<ChartsInitial>());
    });

    blocTest<ChartsCubit, ChartsState>(
      'emits [ChartsLoading, ChartsLoaded] when loadStocks is called',
      build: () => ChartsCubit(),
      act: (cubit) => cubit.loadStocks(),
      expect: () => [
        isA<ChartsLoading>(),
        isA<ChartsLoaded>(),
      ],
    );

    blocTest<ChartsCubit, ChartsState>(
      'loaded state contains a non-empty stock list',
      build: () => ChartsCubit(),
      act: (cubit) => cubit.loadStocks(),
      verify: (cubit) {
        final state = cubit.state;
        expect(state, isA<ChartsLoaded>());
        final loaded = state as ChartsLoaded;
        expect(loaded.stocks, isNotEmpty);
        expect(loaded.selectedStock, isNull);
      },
    );

    blocTest<ChartsCubit, ChartsState>(
      'selectStock updates the selectedStock in loaded state',
      build: () => ChartsCubit(),
      seed: () => ChartsLoaded(
        stocks: [
          StockItem(
            name: 'Test',
            symbol: 'TST',
            price: 10,
            change: 1,
            changePercentage: 10,
            volume: 100,
            date: DateTime(2024),
            open: 9,
            high: 11,
            low: 8,
            close: 10,
          ),
        ],
      ),
      act: (cubit) {
        final stock = (cubit.state as ChartsLoaded).stocks.first;
        cubit.selectStock(stock);
      },
      expect: () => [
        isA<ChartsLoaded>().having(
          (s) => s.selectedStock?.symbol,
          'selectedStock.symbol',
          'TST',
        ),
      ],
    );
  });
}
