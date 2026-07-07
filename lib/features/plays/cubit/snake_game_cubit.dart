import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/snake_game.dart';

part 'snake_game_state.dart';

/// Factory signature for creating [SnakeGame] instances.
///
/// Allows injecting a mock or custom game implementation during tests.
typedef SnakeGameFactory = SnakeGame Function();

/// Cubit that bridges the [SnakeGame] model to the UI via reactive state.
class SnakeGameCubit extends Cubit<SnakeGameState> {
  late SnakeGame _game;
  StreamSubscription<GameState>? _gameStateSub;
  StreamSubscription<int>? _scoreSub;
  StreamSubscription<double>? _aiSpeedSub;

  /// Creates a [SnakeGameCubit].
  ///
  /// Accepts an optional [gameFactory] for dependency injection / testability.
  /// Defaults to `SnakeGame.new` when not provided.
  SnakeGameCubit({SnakeGameFactory? gameFactory})
      : super(const SnakeGameState()) {
    _game = (gameFactory ?? SnakeGame.new)();
    _listenToGame();
  }

  SnakeGame get game => _game;

  void _listenToGame() {
    _gameStateSub = _game.gameStateStream.listen((gameState) {
      emit(state.copyWith(
        isGameOver: gameState == GameState.gameOver,
      ));
    });

    _scoreSub = _game.scoreStream.listen((score) {
      emit(state.copyWith(
        score: score,
        highScore: SnakeGame.highScore,
      ));
    });

    _aiSpeedSub = _game.aiSpeedStream.listen((speed) {
      emit(state.copyWith(aiSpeed: speed));
    });
  }

  void changeDirection(Direction direction) {
    _game.changeDirection(direction);
  }

  void restart() {
    _game.restart();
    emit(const SnakeGameState());
  }

  @override
  Future<void> close() {
    _gameStateSub?.cancel();
    _scoreSub?.cancel();
    _aiSpeedSub?.cancel();
    _game.dispose();
    return super.close();
  }
}
