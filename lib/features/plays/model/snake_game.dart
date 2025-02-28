import 'dart:async';
import 'dart:math';

enum Direction { up, down, left, right }

enum GameState { playing, gameOver }

class Position {
  final int x;
  final int y;

  const Position(this.x, this.y);

  double distanceTo(Position other) {
    return sqrt(pow(x - other.x, 2) + pow(y - other.y, 2));
  }
}

class SnakeGame {
  static const int gridSize = 20;
  static const int gameSpeed = 150;
  static const Duration aiSpawnDelay = Duration(seconds: 5);
  static int highScore = 0;

  // AI Settings with defaults
  double _baseAiSpeed = 0.7;
  double _aiSpeedIncreasePerScore = 0.1;
  double _aiSpeedIncreaseOverTime = 0.05;

  final Random _random = Random();
  final StreamController<GameState> _gameStateController =
      StreamController<GameState>.broadcast();
  final StreamController<int> _scoreController =
      StreamController<int>.broadcast();
  final StreamController<double> _aiSpeedController =
      StreamController<double>.broadcast();

  List<Position> playerSnake = [];
  List<Position> aiSnake = [];
  Position? food;
  Direction _playerDirection = Direction.right;
  Direction _aiDirection = Direction.left;
  Timer? _gameTimer;
  Timer? _aiTimer;
  Timer? _aiSpeedTimer;
  int _score = 0;
  GameState _gameState = GameState.playing;
  double _currentAiSpeed = 0.7;

  // Getters for AI settings
  double get baseAiSpeed => _baseAiSpeed;
  // ignore: unnecessary_getters_setters
  double get aiSpeedIncreasePerScore => _aiSpeedIncreasePerScore;
  // ignore: unnecessary_getters_setters
  double get aiSpeedIncreaseOverTime => _aiSpeedIncreaseOverTime;

  // Setters for AI settings
  set baseAiSpeed(double value) {
    _baseAiSpeed = value;
    if (_gameState == GameState.playing) {
      _currentAiSpeed = _baseAiSpeed;
      _aiSpeedController.add(_currentAiSpeed);
      _startAiLoop();
    }
  }

  set aiSpeedIncreasePerScore(double value) {
    _aiSpeedIncreasePerScore = value;
  }

  set aiSpeedIncreaseOverTime(double value) {
    _aiSpeedIncreaseOverTime = value;
  }

  bool get isAiActive => aiSnake.isNotEmpty;
  int get score => _score;
  GameState get gameState => _gameState;
  Stream<GameState> get gameStateStream => _gameStateController.stream;
  Stream<int> get scoreStream => _scoreController.stream;
  Stream<double> get aiSpeedStream => _aiSpeedController.stream;
  double get aiSpeed => _currentAiSpeed;

  SnakeGame() {
    _initGame();
  }

  void _initGame() {
    _cancelAllTimers();

    // Initialize player snake with 3 segments
    playerSnake = [
      const Position(5, 10),
      const Position(4, 10),
      const Position(3, 10),
    ];

    aiSnake = [];
    _playerDirection = Direction.right;
    _aiDirection = Direction.left;
    _score = 0;
    _gameState = GameState.playing;
    _currentAiSpeed = _baseAiSpeed;

    _spawnFood();
    _startGameLoop();

    _scoreController.add(_score);
    _aiSpeedController.add(_currentAiSpeed);
    _gameStateController.add(_gameState);

    // Spawn AI snake after delay
    Future.delayed(aiSpawnDelay, () {
      if (_gameState == GameState.playing) {
        _spawnAiSnake();
        _startAiLoop();
        _startAiSpeedIncrease();
      }
    });
  }

  void _cancelAllTimers() {
    _gameTimer?.cancel();
    _aiTimer?.cancel();
    _aiSpeedTimer?.cancel();
  }

  void _startGameLoop() {
    _gameTimer?.cancel();
    _gameTimer =
        Timer.periodic(const Duration(milliseconds: gameSpeed), (timer) {
      if (_gameState == GameState.playing) {
        _updateGame();
      }
    });
  }

  void _startAiLoop() {
    _aiTimer?.cancel();
    int aiUpdateInterval = (gameSpeed * (1.5 / _currentAiSpeed)).toInt();
    _aiTimer =
        Timer.periodic(Duration(milliseconds: aiUpdateInterval), (timer) {
      if (_gameState == GameState.playing) {
        _updateAI();
      }
    });
  }

  void _startAiSpeedIncrease() {
    _aiSpeedTimer?.cancel();
    _aiSpeedTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (_gameState == GameState.playing &&
          isAiActive &&
          !_aiSpeedController.isClosed) {
        _currentAiSpeed += _aiSpeedIncreaseOverTime;
        _aiSpeedController.add(_currentAiSpeed);
        _startAiLoop(); // Restart AI loop with new speed
      }
    });
  }

  void _spawnAiSnake() {
    int x, y;
    do {
      x = _random.nextInt(gridSize);
      y = _random.nextInt(gridSize);
    } while (_isPositionOccupied(Position(x, y)));

    aiSnake = [Position(x, y)];
  }

  void _spawnFood() {
    int x, y;
    do {
      x = _random.nextInt(gridSize);
      y = _random.nextInt(gridSize);
    } while (_isPositionOccupied(Position(x, y)));
    food = Position(x, y);
  }

  bool _isPositionOccupied(Position pos) {
    return playerSnake.any((p) => p.x == pos.x && p.y == pos.y) ||
        aiSnake.any((p) => p.x == pos.x && p.y == pos.y) ||
        (food?.x == pos.x && food?.y == pos.y);
  }

  void changeDirection(Direction newDirection) {
    if (_gameState != GameState.playing) return;

    // Prevent 180-degree turns
    bool isOpposite = (_playerDirection == Direction.up &&
            newDirection == Direction.down) ||
        (_playerDirection == Direction.down && newDirection == Direction.up) ||
        (_playerDirection == Direction.left &&
            newDirection == Direction.right) ||
        (_playerDirection == Direction.right && newDirection == Direction.left);

    if (!isOpposite) {
      _playerDirection = newDirection;
    }
  }

  void _updateGame() {
    if (_gameState != GameState.playing) return;

    final head = playerSnake.first;
    Position newHead;

    switch (_playerDirection) {
      case Direction.up:
        newHead = Position(head.x, (head.y - 1 + gridSize) % gridSize);
        break;
      case Direction.down:
        newHead = Position(head.x, (head.y + 1) % gridSize);
        break;
      case Direction.left:
        newHead = Position((head.x - 1 + gridSize) % gridSize, head.y);
        break;
      case Direction.right:
        newHead = Position((head.x + 1) % gridSize, head.y);
        break;
    }

    if (_checkCollision(newHead)) {
      _gameOver();
      return;
    }

    playerSnake.insert(0, newHead);

    if (food != null && newHead.x == food!.x && newHead.y == food!.y) {
      _score++;
      if (_score > highScore) {
        highScore = _score;
      }
      _scoreController.add(_score);

      // Increase AI speed with score
      if (isAiActive) {
        _currentAiSpeed += _aiSpeedIncreasePerScore;
        _aiSpeedController.add(_currentAiSpeed);
        _startAiLoop();
      }
      _spawnFood();
    } else {
      playerSnake.removeLast();
    }
  }

  void _updateAI() {
    if (!isAiActive || _gameState != GameState.playing) return;

    final head = aiSnake.first;
    final playerHead = playerSnake.first;
    Position newHead;

    // Calculate direction to player with smarter pathfinding
    int dx = playerHead.x - head.x;
    int dy = playerHead.y - head.y;

    // Wrap-around distance calculation
    if (dx > gridSize / 2) dx -= gridSize;
    if (dx < -gridSize / 2) dx += gridSize;
    if (dy > gridSize / 2) dy -= gridSize;
    if (dy < -gridSize / 2) dy += gridSize;

    // Determine primary movement direction
    if (dx.abs() > dy.abs()) {
      _aiDirection = dx > 0 ? Direction.right : Direction.left;
      // If blocked, try vertical movement
      Position testHead = _getNextPosition(head, _aiDirection);
      if (_isPositionOccupied(testHead)) {
        _aiDirection = dy > 0 ? Direction.down : Direction.up;
      }
    } else {
      _aiDirection = dy > 0 ? Direction.down : Direction.up;
      // If blocked, try horizontal movement
      Position testHead = _getNextPosition(head, _aiDirection);
      if (_isPositionOccupied(testHead)) {
        _aiDirection = dx > 0 ? Direction.right : Direction.left;
      }
    }

    newHead = _getNextPosition(head, _aiDirection);

    // Check if AI caught the player
    if (playerSnake.any((pos) => pos.x == newHead.x && pos.y == newHead.y)) {
      _gameOver();
      return;
    }

    aiSnake.insert(0, newHead);
    aiSnake.removeLast();
  }

  Position _getNextPosition(Position current, Direction direction) {
    switch (direction) {
      case Direction.up:
        return Position(current.x, (current.y - 1 + gridSize) % gridSize);
      case Direction.down:
        return Position(current.x, (current.y + 1) % gridSize);
      case Direction.left:
        return Position((current.x - 1 + gridSize) % gridSize, current.y);
      case Direction.right:
        return Position((current.x + 1) % gridSize, current.y);
    }
  }

  bool _checkCollision(Position pos) {
    return playerSnake.any((p) => p.x == pos.x && p.y == pos.y) ||
        aiSnake.any((p) => p.x == pos.x && p.y == pos.y);
  }

  void _gameOver() {
    _gameState = GameState.gameOver;
    _gameStateController.add(_gameState);
    _cancelAllTimers();
  }

  void restart() {
    _initGame();
    _gameStateController.add(_gameState);
  }

  void dispose() {
    _cancelAllTimers();
    _gameStateController.close();
    _scoreController.close();
    _aiSpeedController.close();
    _gameTimer?.cancel();
    _aiTimer?.cancel();
    _aiSpeedTimer?.cancel();
  }
}
