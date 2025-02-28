import 'dart:async';

enum Player { red, yellow }

enum GameState { playing, draw, redWon, yellowWon }

class Connect4Game {
  static const int rows = 6;
  static const int columns = 7;
  static const winLength = 4;

  final List<List<Player?>> _board = List.generate(
    rows,
    (_) => List.filled(columns, null),
  );
  Player _currentPlayer = Player.red;
  GameState _gameState = GameState.playing;
  int _movesCount = 0;

  final StreamController<GameState> _gameStateController =
      StreamController<GameState>.broadcast();
  final StreamController<List<List<Player?>>> _boardController =
      StreamController<List<List<Player?>>>.broadcast();
  final StreamController<Player> _currentPlayerController =
      StreamController<Player>.broadcast();

  Connect4Game() {
    _emitState();
  }

  // Getters
  List<List<Player?>> get board => List.generate(
        rows,
        (i) => List.generate(
          columns,
          (j) => _board[i][j],
        ),
      );
  Player get currentPlayer => _currentPlayer;
  GameState get gameState => _gameState;
  Stream<GameState> get gameStateStream => _gameStateController.stream;
  Stream<List<List<Player?>>> get boardStream => _boardController.stream;
  Stream<Player> get currentPlayerStream => _currentPlayerController.stream;

  bool canDropInColumn(int column) {
    if (column < 0 || column >= columns) return false;
    return _board[0][column] == null;
  }

  void dropPiece(int column) {
    if (_gameState != GameState.playing || !canDropInColumn(column)) return;

    // Find the lowest empty position in the column
    int row = rows - 1;
    while (row >= 0 && _board[row][column] != null) {
      row--;
    }

    // Place the piece
    _board[row][column] = _currentPlayer;
    _movesCount++;

    if (_checkWin(row, column)) {
      _gameState =
          _currentPlayer == Player.red ? GameState.redWon : GameState.yellowWon;
    } else if (_movesCount == rows * columns) {
      _gameState = GameState.draw;
    } else {
      _currentPlayer =
          _currentPlayer == Player.red ? Player.yellow : Player.red;
    }

    _emitState();
  }

  bool _checkWin(int lastRow, int lastCol) {
    final directions = [
      [0, 1], // Horizontal
      [1, 0], // Vertical
      [1, 1], // Diagonal down-right
      [1, -1], // Diagonal down-left
    ];

    for (final direction in directions) {
      int count = 1;
      final player = _board[lastRow][lastCol];

      // Check in positive direction
      int r = lastRow + direction[0];
      int c = lastCol + direction[1];
      while (r >= 0 &&
          r < rows &&
          c >= 0 &&
          c < columns &&
          _board[r][c] == player) {
        count++;
        r += direction[0];
        c += direction[1];
      }

      // Check in negative direction
      r = lastRow - direction[0];
      c = lastCol - direction[1];
      while (r >= 0 &&
          r < rows &&
          c >= 0 &&
          c < columns &&
          _board[r][c] == player) {
        count++;
        r -= direction[0];
        c -= direction[1];
      }

      if (count >= winLength) return true;
    }

    return false;
  }

  void restart() {
    for (var row in _board) {
      row.fillRange(0, columns, null);
    }
    _currentPlayer = Player.red;
    _gameState = GameState.playing;
    _movesCount = 0;
    _emitState();
  }

  void _emitState() {
    _gameStateController.add(_gameState);
    _boardController.add(List.generate(
      rows,
      (i) => List.generate(
        columns,
        (j) => _board[i][j],
      ),
    ));
    _currentPlayerController.add(_currentPlayer);
  }

  void dispose() {
    _gameStateController.close();
    _boardController.close();
    _currentPlayerController.close();
  }
}
