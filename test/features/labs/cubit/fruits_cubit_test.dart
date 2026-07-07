import 'package:bloc_test/bloc_test.dart';
import 'package:boonyongyang/core/errors/app_exceptions.dart';
import 'package:boonyongyang/features/labs/cubit/fruits_cubit.dart';
import 'package:boonyongyang/features/labs/model/fruit_model.dart';
import 'package:boonyongyang/features/labs/repository/fruit_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFruitRepository extends Mock implements FruitRepository {}

void main() {
  late MockFruitRepository mockRepository;

  setUp(() {
    mockRepository = MockFruitRepository();
  });

  final testFruits = [
    Fruit(
      name: 'Apple',
      id: 1,
      family: 'Rosaceae',
      order: 'Rosales',
      genus: 'Malus',
      nutritions: Nutrition(
        calories: 52,
        fat: 0.4,
        sugar: 10.3,
        carbohydrates: 11.4,
        protein: 0.3,
      ),
    ),
    Fruit(
      name: 'Banana',
      id: 2,
      family: 'Musaceae',
      order: 'Zingiberales',
      genus: 'Musa',
      nutritions: Nutrition(
        calories: 96,
        fat: 0.2,
        sugar: 17.2,
        carbohydrates: 22.0,
        protein: 1.0,
      ),
    ),
  ];

  group('FruitsCubit', () {
    test('initial state is FruitsInitial', () {
      final cubit = FruitsCubit(repository: mockRepository);
      expect(cubit.state, isA<FruitsInitial>());
      cubit.close();
    });

    blocTest<FruitsCubit, FruitsState>(
      'emits [FruitsLoading, FruitsLoaded] when fetchFruits succeeds',
      build: () {
        when(() => mockRepository.fetchAllFruits())
            .thenAnswer((_) async => testFruits);
        return FruitsCubit(repository: mockRepository);
      },
      act: (cubit) => cubit.fetchFruits(),
      expect: () => [
        isA<FruitsLoading>(),
        isA<FruitsLoaded>().having(
          (s) => s.fruits.length,
          'fruits count',
          2,
        ),
      ],
      verify: (_) {
        verify(() => mockRepository.fetchAllFruits()).called(1);
      },
    );

    blocTest<FruitsCubit, FruitsState>(
      'emits [FruitsLoading, FruitsError] when fetchFruits fails with NetworkException',
      build: () {
        when(() => mockRepository.fetchAllFruits())
            .thenThrow(const NetworkException('No internet connection.'));
        return FruitsCubit(repository: mockRepository);
      },
      act: (cubit) => cubit.fetchFruits(),
      expect: () => [
        isA<FruitsLoading>(),
        isA<FruitsError>().having(
          (s) => s.message,
          'error message',
          'No internet connection.',
        ),
      ],
    );

    blocTest<FruitsCubit, FruitsState>(
      'emits [FruitsLoading, FruitsLoaded] with empty list',
      build: () {
        when(() => mockRepository.fetchAllFruits()).thenAnswer((_) async => []);
        return FruitsCubit(repository: mockRepository);
      },
      act: (cubit) => cubit.fetchFruits(),
      expect: () => [
        isA<FruitsLoading>(),
        isA<FruitsLoaded>().having(
          (s) => s.fruits,
          'empty list',
          isEmpty,
        ),
      ],
    );
  });
}
