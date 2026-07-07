import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/errors/app_exceptions.dart';
import '../model/fruit_model.dart';
import '../repository/fruit_repository.dart';

part 'fruits_state.dart';

class FruitsCubit extends Cubit<FruitsState> {
  final FruitRepository _repository;

  FruitsCubit({required FruitRepository repository})
      : _repository = repository,
        super(const FruitsInitial());

  Future<void> fetchFruits() async {
    emit(const FruitsLoading());
    try {
      final fruits = await _repository.fetchAllFruits();
      emit(FruitsLoaded(fruits));
    } on NetworkException catch (e) {
      emit(FruitsError(e.message));
    } on DataParsingException catch (e) {
      emit(FruitsError(e.message));
    } catch (e) {
      emit(FruitsError(e.toString()));
    }
  }
}
