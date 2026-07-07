part of 'snake_game_cubit.dart';

class SnakeGameState extends Equatable {
  final int score;
  final int highScore;
  final double aiSpeed;
  final bool isGameOver;

  const SnakeGameState({
    this.score = 0,
    this.highScore = 0,
    this.aiSpeed = 0.7,
    this.isGameOver = false,
  });

  SnakeGameState copyWith({
    int? score,
    int? highScore,
    double? aiSpeed,
    bool? isGameOver,
  }) {
    return SnakeGameState(
      score: score ?? this.score,
      highScore: highScore ?? this.highScore,
      aiSpeed: aiSpeed ?? this.aiSpeed,
      isGameOver: isGameOver ?? this.isGameOver,
    );
  }

  @override
  List<Object?> get props => [score, highScore, aiSpeed, isGameOver];
}
