class Fruit {
  final String name;
  final int id;
  final String family;
  final String order;
  final String genus;
  final Nutrition nutritions;

  Fruit({
    required this.name,
    required this.id,
    required this.family,
    required this.order,
    required this.genus,
    required this.nutritions,
  });

  factory Fruit.fromJson(Map<String, dynamic> json) {
    return Fruit(
      name: json['name'] ?? '',
      id: json['id'] ?? 0,
      family: json['family'] ?? '',
      order: json['order'] ?? '',
      genus: json['genus'] ?? '',
      nutritions: Nutrition.fromJson(json['nutritions'] ?? {}),
    );
  }
}

class Nutrition {
  final double calories;
  final double fat;
  final double sugar;
  final double carbohydrates;
  final double protein;

  Nutrition({
    required this.calories,
    required this.fat,
    required this.sugar,
    required this.carbohydrates,
    required this.protein,
  });

  factory Nutrition.fromJson(Map<String, dynamic> json) {
    return Nutrition(
      calories: (json['calories'] ?? 0).toDouble(),
      fat: (json['fat'] ?? 0).toDouble(),
      sugar: (json['sugar'] ?? 0).toDouble(),
      carbohydrates: (json['carbohydrates'] ?? 0).toDouble(),
      protein: (json['protein'] ?? 0).toDouble(),
    );
  }
}
