import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../core/di/service_locator.dart';
import '../../../features/labs/repository/fruit_repository.dart';
import '../cubit/fruits_cubit.dart';
import '../model/fruit_model.dart';
import 'fruit_detail_page.dart';

class FruitsPage extends StatelessWidget {
  const FruitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FruitsCubit(
        repository: getIt<FruitRepository>(),
      )..fetchFruits(),
      child: const _FruitsView(),
    );
  }
}

class _FruitsView extends StatelessWidget {
  const _FruitsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fruits'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<FruitsCubit>().fetchFruits(),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: BlocBuilder<FruitsCubit, FruitsState>(
        builder: (context, state) => switch (state) {
          FruitsInitial() || FruitsLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
          FruitsError(:final message) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const Gap(16),
                  SelectableText(
                    'Error loading fruits',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Gap(8),
                  SelectableText(message),
                  const Gap(16),
                  ElevatedButton(
                    onPressed: () => context.read<FruitsCubit>().fetchFruits(),
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            ),
          FruitsLoaded(:final fruits) => fruits.isEmpty
              ? const Center(child: Text('No fruits found'))
              : RefreshIndicator(
                  onRefresh: () => context.read<FruitsCubit>().fetchFruits(),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final crossAxisCount =
                          (constraints.maxWidth / 200).floor();
                      return GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: fruits.length,
                        itemBuilder: (context, index) =>
                            _FruitCard(fruit: fruits[index]),
                      );
                    },
                  ),
                ),
        },
      ),
    );
  }
}

class _FruitCard extends StatelessWidget {
  final Fruit fruit;

  const _FruitCard({required this.fruit});

  @override
  Widget build(BuildContext context) {
    final color = Colors.primaries[fruit.id % Colors.primaries.length];

    return Card(
      child: InkWell(
        onTap: () {
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
              const Gap(8),
              Text(
                fruit.name,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const Gap(4),
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
