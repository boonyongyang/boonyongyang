import 'package:equatable/equatable.dart';

/// Represents a fruit returned by the Fruityvice API.
class Fruit extends Equatable {
  const Fruit({
    required this.name,
    required this.id,
    required this.family,
    required this.order,
    required this.genus,
    required this.nutritions,
  });

  final String name;
  final int id;
  final String family;
  final String order;
  final String genus;
  final Nutrition nutritions;

  factory Fruit.fromJson(Map<String, Object?> json) {
    return Fruit(
      name: _readString(json, 'name'),
      id: _readInt(json, 'id'),
      family: _readString(json, 'family'),
      order: _readString(json, 'order'),
      genus: _readString(json, 'genus'),
      nutritions: Nutrition.fromJson(_readMap(json, 'nutritions')),
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'family': family,
        'order': order,
        'genus': genus,
        'nutritions': nutritions.toJson(),
      };

  @override
  List<Object?> get props => [id, name, family, order, genus, nutritions];

  @override
  String toString() => 'Fruit(id: $id, name: $name, family: $family)';
}

/// Nutritional information for a [Fruit].
class Nutrition extends Equatable {
  const Nutrition({
    required this.calories,
    required this.fat,
    required this.sugar,
    required this.carbohydrates,
    required this.protein,
  });

  final double calories;
  final double fat;
  final double sugar;
  final double carbohydrates;
  final double protein;

  factory Nutrition.fromJson(Map<String, Object?> json) {
    return Nutrition(
      calories: _readDouble(json, 'calories'),
      fat: _readDouble(json, 'fat'),
      sugar: _readDouble(json, 'sugar'),
      carbohydrates: _readDouble(json, 'carbohydrates'),
      protein: _readDouble(json, 'protein'),
    );
  }

  Map<String, dynamic> toJson() => {
        'calories': calories,
        'fat': fat,
        'sugar': sugar,
        'carbohydrates': carbohydrates,
        'protein': protein,
      };

  @override
  List<Object?> get props => [calories, fat, sugar, carbohydrates, protein];

  @override
  String toString() => 'Nutrition(cal: $calories, fat: $fat, sugar: $sugar)';
}

String _readString(Map<String, Object?> json, String key) {
  final value = json[key];
  return value is String ? value : '';
}

int _readInt(Map<String, Object?> json, String key) {
  final value = json[key];
  return value is num ? value.toInt() : 0;
}

double _readDouble(Map<String, Object?> json, String key) {
  final value = json[key];
  return value is num ? value.toDouble() : 0;
}

Map<String, Object?> _readMap(Map<String, Object?> json, String key) {
  final value = json[key];
  if (value is Map<String, Object?>) {
    return value;
  }
  if (value is Map) {
    return value.cast<String, Object?>();
  }
  return const {};
}
