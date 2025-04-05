import 'package:flutter/material.dart';
import '../model/fruit_model.dart';

class FruitDetailPage extends StatelessWidget {
  final Fruit fruit;

  const FruitDetailPage({super.key, required this.fruit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(fruit.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoCard(context),
            const SizedBox(height: 16),
            _buildNutritionCard(context),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Biological Information',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Divider(),
            _buildInfoRow('Name', fruit.name),
            _buildInfoRow('Family', fruit.family),
            _buildInfoRow('Order', fruit.order),
            _buildInfoRow('Genus', fruit.genus),
          ],
        ),
      ),
    );
  }

  Widget _buildNutritionCard(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nutritional Information',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Divider(),
            _buildNutritionRow(
                'Calories', fruit.nutritions.calories, Colors.red),
            _buildNutritionRow(
                'Carbohydrates', fruit.nutritions.carbohydrates, Colors.orange),
            _buildNutritionRow('Sugar', fruit.nutritions.sugar, Colors.amber),
            _buildNutritionRow('Fat', fruit.nutritions.fat, Colors.blue),
            _buildNutritionRow(
                'Protein', fruit.nutritions.protein, Colors.green),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildNutritionRow(String label, double value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ${value.toStringAsFixed(1)} g',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: value / 100, // Normalized value for progress indicator
            backgroundColor: color.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 10,
          ),
        ],
      ),
    );
  }
}
