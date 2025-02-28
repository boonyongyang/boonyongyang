import 'dart:async';

enum Player { X, O }

enum GameState { playing, draw, xWon, oWon }

class TicTacToeGame {
  static const winPatterns = [
    // Rows
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    // Columns
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    // Diagonals
    [0, 4, 8],
    [2, 4, 6],
  ];

  final List<Player?> _board = List.filled(9, null);
  Player _currentPlayer = Player.X;
  GameState _gameState = GameState.playing;
  int _movesCount = 0;

  final StreamController<GameState> _gameStateController =
      StreamController<GameState>.broadcast();
  final StreamController<List<Player?>> _boardController =
      StreamController<List<Player?>>.broadcast();
  final StreamController<Player> _currentPlayerController =
      StreamController<Player>.broadcast();

  TicTacToeGame() {
    _emitState();
  }

  // Getters
  List<Player?> get board => List.unmodifiable(_board);
  Player get currentPlayer => _currentPlayer;
  GameState get gameState => _gameState;
  Stream<GameState> get gameStateStream => _gameStateController.stream;
  Stream<List<Player?>> get boardStream => _boardController.stream;
  Stream<Player> get currentPlayerStream => _currentPlayerController.stream;

  void makeMove(int index) {
    if (_gameState != GameState.playing || _board[index] != null) return;

    _board[index] = _currentPlayer;
    _movesCount++;

    if (_checkWin()) {
      _gameState = _currentPlayer == Player.X ? GameState.xWon : GameState.oWon;
    } else if (_movesCount == 9) {
      _gameState = GameState.draw;
    } else {
      _currentPlayer = _currentPlayer == Player.X ? Player.O : Player.X;
    }

    _emitState();
  }

  bool _checkWin() {
    for (final pattern in winPatterns) {
      if (_board[pattern[0]] != null &&
          _board[pattern[0]] == _board[pattern[1]] &&
          _board[pattern[1]] == _board[pattern[2]]) {
        return true;
      }
    }
    return false;
  }

  void restart() {
    _board.fillRange(0, 9, null);
    _currentPlayer = Player.X;
    _gameState = GameState.playing;
    _movesCount = 0;
    _emitState();
  }

  void _emitState() {
    _gameStateController.add(_gameState);
    _boardController.add(_board);
    _currentPlayerController.add(_currentPlayer);
  }

  void dispose() {
    _gameStateController.close();
    _boardController.close();
    _currentPlayerController.close();
  }
}
