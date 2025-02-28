import 'dart:async';
import 'dart:math';

enum Player { human, ai }

enum GameState { playing, draw, humanWon, aiWon }

class AITicTacToeGame {
  static const int boardSize = 3;
  final List<List<Player?>> _board = List.generate(
    boardSize,
    (_) => List.filled(boardSize, null),
  );
  GameState _gameState = GameState.playing;

  final StreamController<GameState> _gameStateController =
      StreamController<GameState>.broadcast();
  final StreamController<List<List<Player?>>> _boardController =
      StreamController<List<List<Player?>>>.broadcast();

  AITicTacToeGame() {
    _emitState();
  }

  // Getters
  List<List<Player?>> get board => List.generate(
        boardSize,
        (i) => List.generate(
          boardSize,
          (j) => _board[i][j],
        ),
      );
  GameState get gameState => _gameState;
  Stream<GameState> get gameStateStream => _gameStateController.stream;
  Stream<List<List<Player?>>> get boardStream => _boardController.stream;

  bool canMakeMove(int row, int col) {
    return _gameState == GameState.playing && _board[row][col] == null;
  }

  void makeMove(int row, int col) {
    if (!canMakeMove(row, col)) return;

    // Human move
    _board[row][col] = Player.human;
    if (_checkWin(Player.human)) {
      _gameState = GameState.humanWon;
      _emitState();
      return;
    }

    if (_isBoardFull()) {
      _gameState = GameState.draw;
      _emitState();
      return;
    }

    // AI move
    _makeAIMove();
  }

  void _makeAIMove() {
    int bestScore = -1000;
    int bestRow = -1;
    int bestCol = -1;

    // Find the best move using minimax
    for (int i = 0; i < boardSize; i++) {
      for (int j = 0; j < boardSize; j++) {
        if (_board[i][j] == null) {
          _board[i][j] = Player.ai;
          int score = _minimax(0, false);
          _board[i][j] = null;

          if (score > bestScore) {
            bestScore = score;
            bestRow = i;
            bestCol = j;
          }
        }
      }
    }

    if (bestRow != -1 && bestCol != -1) {
      _board[bestRow][bestCol] = Player.ai;
      if (_checkWin(Player.ai)) {
        _gameState = GameState.aiWon;
      } else if (_isBoardFull()) {
        _gameState = GameState.draw;
      }
    }

    _emitState();
  }

  int _minimax(int depth, bool isMaximizing) {
    // Terminal conditions
    if (_checkWin(Player.ai)) return 10 - depth;
    if (_checkWin(Player.human)) return depth - 10;
    if (_isBoardFull()) return 0;

    if (isMaximizing) {
      int bestScore = -1000;
      for (int i = 0; i < boardSize; i++) {
        for (int j = 0; j < boardSize; j++) {
          if (_board[i][j] == null) {
            _board[i][j] = Player.ai;
            bestScore = max(bestScore, _minimax(depth + 1, false));
            _board[i][j] = null;
          }
        }
      }
      return bestScore;
    } else {
      int bestScore = 1000;
      for (int i = 0; i < boardSize; i++) {
        for (int j = 0; j < boardSize; j++) {
          if (_board[i][j] == null) {
            _board[i][j] = Player.human;
            bestScore = min(bestScore, _minimax(depth + 1, true));
            _board[i][j] = null;
          }
        }
      }
      return bestScore;
    }
  }

  bool _checkWin(Player player) {
    // Check rows
    for (int i = 0; i < boardSize; i++) {
      if (_board[i].every((cell) => cell == player)) return true;
    }

    // Check columns
    for (int j = 0; j < boardSize; j++) {
      if (_board.every((row) => row[j] == player)) return true;
    }

    // Check diagonals
    if (_board[0][0] == player &&
        _board[1][1] == player &&
        _board[2][2] == player) return true;

    if (_board[0][2] == player &&
        _board[1][1] == player &&
        _board[2][0] == player) return true;

    return false;
  }

  bool _isBoardFull() {
    for (var row in _board) {
      if (row.contains(null)) return false;
    }
    return true;
  }

  void restart() {
    for (var row in _board) {
      row.fillRange(0, boardSize, null);
    }
    _gameState = GameState.playing;
    _emitState();
  }

  void _emitState() {
    _gameStateController.add(_gameState);
    _boardController.add(List.generate(
      boardSize,
      (i) => List.generate(
        boardSize,
        (j) => _board[i][j],
      ),
    ));
  }

  void dispose() {
    _gameStateController.close();
    _boardController.close();
  }
}
