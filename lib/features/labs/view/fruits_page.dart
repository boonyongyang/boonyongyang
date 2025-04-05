import 'package:flutter/material.dart';
import '../model/fruit_model.dart';
import '../services/fruit_service.dart';
import 'fruit_detail_page.dart';

class FruitsPage extends StatefulWidget {
  const FruitsPage({super.key});

  @override
  State<FruitsPage> createState() => _FruitsPageState();
}

class _FruitsPageState extends State<FruitsPage> {
  final FruitService _fruitService = FruitService();
  List<Fruit>? _fruits;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    debugPrint('FruitsPage: initState called');
    _fetchFruits();
  }

  Future<void> _fetchFruits() async {
    debugPrint('FruitsPage: _fetchFruits called');
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      debugPrint('FruitsPage: Calling fruitService.fetchAllFruits()');
      final fruits = await _fruitService.fetchAllFruits();
      debugPrint('FruitsPage: Retrieved ${fruits.length} fruits');

      setState(() {
        _fruits = fruits;
        _isLoading = false;
      });
      debugPrint('FruitsPage: Updated state with fruits data');
    } catch (e) {
      debugPrint('FruitsPage: Error fetching fruits: $e');
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
      debugPrint('FruitsPage: Updated state with error message');
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('FruitsPage: build method called');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fruits'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchFruits,
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    debugPrint(
        'FruitsPage: _buildBody called, isLoading: $_isLoading, hasError: ${_errorMessage != null}');
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_errorMessage != null) {
      debugPrint('FruitsPage: Showing error message: $_errorMessage');
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            SelectableText(
              'Error loading fruits',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            SelectableText(_errorMessage!),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _fetchFruits,
              child: const Text('Try Again'),
            ),
          ],
        ),
      );
    }

    if (_fruits == null || _fruits!.isEmpty) {
      debugPrint('FruitsPage: No fruits found');
      return const Center(
        child: Text('No fruits found'),
      );
    }

    debugPrint('FruitsPage: Building GridView with ${_fruits!.length} fruits');
    return RefreshIndicator(
      onRefresh: _fetchFruits,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final crossAxisCount = (constraints.maxWidth / 200).floor();
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.8,
            ),
            itemCount: _fruits!.length,
            itemBuilder: (context, index) {
              final fruit = _fruits![index];
              return _buildFruitCard(fruit);
            },
          );
        },
      ),
    );
  }

  Widget _buildFruitCard(Fruit fruit) {
    // Generate a color based on the fruit ID for the avatar
    final color = Colors.primaries[fruit.id % Colors.primaries.length];

    return Card(
      child: InkWell(
        onTap: () {
          debugPrint('FruitsPage: Fruit card tapped: ${fruit.name}');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FruitDetailPage(fruit: fruit),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: color,
                child: Text(
                  fruit.name[0],
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                fruit.name,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                'Family: ${fruit.family}',
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
