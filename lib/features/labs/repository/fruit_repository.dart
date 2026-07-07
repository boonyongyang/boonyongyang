import '../model/fruit_model.dart';

/// Abstract repository for fruit data, enabling testability via dependency injection.
abstract class FruitRepository {
  /// Fetch every fruit from the remote API.
  Future<List<Fruit>> fetchAllFruits();

  /// Fetch a single fruit by its numeric [id].
  Future<Fruit> fetchFruitById(int id);
}
