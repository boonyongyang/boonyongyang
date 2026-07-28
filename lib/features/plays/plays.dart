/// Plays feature — Mini-games suite (Snake, Connect4, TicTacToe, BrickBreaker).
///
/// Note: Each game defines its own `GameState` and `Player` enums.
/// Import individual game files directly to access game-specific types.
library;

export 'cubit/snake_game_cubit.dart';
export 'model/snake_game.dart';
export 'model/connect4_game.dart' hide GameState, Player;
export 'model/ai_tic_tac_toe_game.dart' hide GameState, Player;
export 'model/brick_breaker_game.dart' hide GameState;
export 'view/plays_page.dart';
