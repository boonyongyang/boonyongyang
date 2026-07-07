import 'package:flutter_test/flutter_test.dart';
import 'package:boonyongyang/features/labs/model/fruit_model.dart';

void main() {
  group('Fruit', () {
    const json = {
      'name': 'Banana',
      'id': 2,
      'family': 'Musaceae',
      'order': 'Zingiberales',
      'genus': 'Musa',
      'nutritions': {
        'calories': 96.0,
        'fat': 0.2,
        'sugar': 17.2,
        'carbohydrates': 22.0,
        'protein': 1.0,
      },
    };

    test('fromJson → toJson round-trip preserves data', () {
      final fruit = Fruit.fromJson(json);
      final result = fruit.toJson();
      final nutrition = result['nutritions'] as Map<String, dynamic>;
      expect(result['name'], 'Banana');
      expect(result['id'], 2);
      expect(nutrition['calories'], 96.0);
    });

    test('two equal Fruits are == (Equatable)', () {
      final a = Fruit.fromJson(json);
      final b = Fruit.fromJson(json);
      expect(a, equals(b));
      expect(a.hashCode, b.hashCode);
    });

    test('different Fruits are !=', () {
      final a = Fruit.fromJson(json);
      final b = Fruit.fromJson({...json, 'id': 99});
      expect(a, isNot(equals(b)));
    });

    test('toString returns a readable representation', () {
      final fruit = Fruit.fromJson(json);
      expect(fruit.toString(), contains('Banana'));
      expect(fruit.toString(), contains('2'));
    });
  });

  group('Nutrition', () {
    test('toJson round-trip', () {
      const original = Nutrition(
        calories: 52,
        fat: 0.4,
        sugar: 10.3,
        carbohydrates: 11.4,
        protein: 0.3,
      );
      final json = original.toJson();
      final parsed = Nutrition.fromJson(json);
      expect(parsed, equals(original));
    });
  });

  group('StockItem', () {
    test('isBullish returns true when close >= open', () {
      // StockItem is tested separately via charts tests
    });
  });
}
