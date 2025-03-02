import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

enum GameState { playing, gameOver, win, paused }

// Defines difficulty levels for the game
enum DifficultyLevel { easy, medium, hard }

// Position class to track coordinates
class Vector2D {
  double x;
  double y;

  Vector2D(this.x, this.y);

  Vector2D operator +(Vector2D other) => Vector2D(x + other.x, y + other.y);
  Vector2D operator -(Vector2D other) => Vector2D(x - other.x, y - other.y);
  Vector2D operator *(double scalar) => Vector2D(x * scalar, y * scalar);

  double distanceTo(Vector2D other) {
    return sqrt(pow(x - other.x, 2) + pow(y - other.y, 2));
  }

  Vector2D normalized() {
    double mag = sqrt(x * x + y * y);
    return mag > 0 ? Vector2D(x / mag, y / mag) : Vector2D(0, 0);
  }
}

// Ball in the game
class Ball {
  Vector2D position;
  Vector2D velocity;
  double radius;

  // Add angular velocity for spin effect
  double spin = 0.0;
  // Track previous positions for velocity calculations
  Vector2D previousPosition;
  DateTime lastUpdateTime;

  Ball({
    required this.position,
    required this.velocity,
    required this.radius,
  })  : previousPosition = Vector2D(position.x, position.y),
        lastUpdateTime = DateTime.now(),
        spin = 0.0;

  // Calculate actual velocity based on position changes
  Vector2D get actualVelocity {
    return position - previousPosition;
  }

  // Update previous position
  void updatePreviousPosition() {
    previousPosition = Vector2D(position.x, position.y);
    lastUpdateTime = DateTime.now();
  }
}

// Paddle that the player controls
class Paddle {
  Vector2D position;
  double width;
  double height;

  Paddle({required this.position, required this.width, required this.height});
}

// Brick that the player destroys
class Brick {
  Vector2D position;
  double width;
  double height;
  int hitPoints;
  bool isDestroyed;
  int points;
  BrickType type;

  Brick(
      {required this.position,
      required this.width,
      required this.height,
      required this.hitPoints,
      required this.points,
      this.type = BrickType.normal,
      this.isDestroyed = false});
}

// PowerUp that can be collected
class PowerUp {
  Vector2D position;
  Vector2D velocity;
  double radius;
  PowerUpType type;
  bool isActive;
  bool isCollected;

  PowerUp(
      {required this.position,
      required this.velocity,
      required this.radius,
      required this.type,
      this.isActive = false,
      this.isCollected = false});
}

// Types of bricks
enum BrickType { normal, hard, explosive, powerUp }

// Types of power-ups
enum PowerUpType {
  extraLife,
  expandPaddle,
  shrinkPaddle,
  slowBall,
  fastBall,
  multiball
}

// Add a new Particle class for explosion effects
class Particle {
  Vector2D position;
  Vector2D velocity;
  double size;
  double lifespan;
  double maxLifespan;
  Color color;

  Particle({
    required this.position,
    required this.velocity,
    required this.size,
    required this.maxLifespan,
    required this.color,
  }) : lifespan = maxLifespan;
}

class BrickBreakerGame {
  // Constants
  static const int rows = 8;
  static const int columns = 10;
  static const double ballSpeed = 180.0; // Adjusted to match casual speed
  static const double paddleSpeed = 400.0;
  static const double powerUpSpeed = 100.0;
  static const Duration gameLoopInterval =
      Duration(milliseconds: 16); // ~60 FPS

  // Static high score tracking
  static int highScore = 0;

  // Game elements
  List<Ball> balls = [];
  late Paddle paddle;
  List<Brick> bricks = [];
  List<PowerUp> powerUps = [];
  // Add particles list for explosion effects
  List<Particle> particles = [];

  // Game state
  GameState _gameState = GameState.playing;
  int _score = 0;
  int _lives = 3;
  Timer? _gameLoopTimer;
  final Random _random = Random();
  DifficultyLevel _difficultyLevel = DifficultyLevel.medium;
  DateTime? _pauseStartTime;
  Duration _totalPausedTime = Duration.zero;
  DateTime _gameStartTime = DateTime.now();

  // Screen dimensions (normalized to 0-1 range)
  double screenWidth = 1.0;
  double screenHeight = 1.0;

  // Active power-ups
  bool _expandedPaddle = false;
  bool _slowedBall = false;
  Timer? _powerUpTimer;

  // Add speed multiplier
  double _speedMultiplier = 1.0;

  // Add normal paddle width property
  double _normalPaddleWidth = 0.0;

  // Stream controllers
  final StreamController<GameState> _gameStateController =
      StreamController<GameState>.broadcast();
  final StreamController<int> _scoreController =
      StreamController<int>.broadcast();
  final StreamController<int> _livesController =
      StreamController<int>.broadcast();
  final StreamController<List<Ball>> _ballsController =
      StreamController<List<Ball>>.broadcast();
  final StreamController<Paddle> _paddleController =
      StreamController<Paddle>.broadcast();
  final StreamController<List<Brick>> _bricksController =
      StreamController<List<Brick>>.broadcast();
  final StreamController<List<PowerUp>> _powerUpsController =
      StreamController<List<PowerUp>>.broadcast();
  final StreamController<Duration> _gameTimeController =
      StreamController<Duration>.broadcast();

  // Getters
  GameState get gameState => _gameState;
  int get score => _score;
  int get lives => _lives;
  DifficultyLevel get difficultyLevel => _difficultyLevel;
  Stream<GameState> get gameStateStream => _gameStateController.stream;
  Stream<int> get scoreStream => _scoreController.stream;
  Stream<int> get livesStream => _livesController.stream;
  Stream<List<Ball>> get ballsStream => _ballsController.stream;
  Stream<Paddle> get paddleStream => _paddleController.stream;
  Stream<List<Brick>> get bricksStream => _bricksController.stream;
  Stream<List<PowerUp>> get powerUpsStream => _powerUpsController.stream;
  Stream<Duration> get gameTimeStream => _gameTimeController.stream;
  double get speedMultiplier => _speedMultiplier;
  set speedMultiplier(double value) {
    _speedMultiplier = value.clamp(0.5, 2.0); // Limit speed range
    // Update all ball speeds
    for (Ball ball in balls) {
      final currentDirection = atan2(ball.velocity.y, ball.velocity.x);
      final currentSpeed = sqrt(ball.velocity.x * ball.velocity.x +
          ball.velocity.y * ball.velocity.y);
      final targetSpeed = ballSpeed * _speedMultiplier;
      final speedRatio = targetSpeed / ballSpeed;
      ball.velocity.x = cos(currentDirection) * currentSpeed * speedRatio;
      ball.velocity.y = sin(currentDirection) * currentSpeed * speedRatio;
    }
  }

  // Constructor
  BrickBreakerGame({
    required double initialWidth,
    required double initialHeight,
    DifficultyLevel difficultyLevel = DifficultyLevel.medium,
  }) {
    screenWidth = initialWidth;
    screenHeight = initialHeight;
    _difficultyLevel = difficultyLevel;
    _initializeGame();
  }

  // Initialize game elements
  void _initializeGame() {
    _gameStartTime = DateTime.now();
    _totalPausedTime = Duration.zero;
    _pauseStartTime = null;

    // Create paddle with stored normal width
    _normalPaddleWidth = screenWidth * 0.15;
    paddle = Paddle(
        position: Vector2D(
            screenWidth / 2 - _normalPaddleWidth / 2, screenHeight * 0.9),
        width: _expandedPaddle ? _normalPaddleWidth * 1.5 : _normalPaddleWidth,
        height: screenHeight * 0.02);

    // Create initial ball
    _resetBall();

    // Create bricks
    _generateBricks();

    // Clear power-ups
    powerUps = [];

    // Start game loop
    _startGameLoop();

    // Reset game state
    _gameState = GameState.playing;
    _score = 0;
    _lives = _difficultyLevel == DifficultyLevel.easy
        ? 5
        : _difficultyLevel == DifficultyLevel.medium
            ? 3
            : 2;

    // Reset paddle state
    _expandedPaddle = false;

    // Emit initial state
    _emitState();
  }

  void _resetBall() {
    // Clear existing balls and add a new one
    balls.clear();
    double ballRadius = screenWidth * 0.015;
    Vector2D ballPosition = Vector2D(
        paddle.position.x + paddle.width / 2 - ballRadius,
        paddle.position.y - ballRadius * 2);

    // Set initial ball velocity (upwards with slight randomness)
    double angle = (pi * 0.75) + _random.nextDouble() * (pi * 0.5);
    double speed = _slowedBall ? ballSpeed * 0.7 : ballSpeed;
    speed *= _speedMultiplier; // Apply speed multiplier
    Vector2D ballVelocity = Vector2D(cos(angle) * speed, sin(angle) * speed);

    balls.add(Ball(
        position: ballPosition, velocity: ballVelocity, radius: ballRadius));
  }

  void _generateBricks() {
    bricks.clear();
    double brickWidth = screenWidth / columns;
    double brickHeight = (screenHeight * 0.4) / rows;
    double topMargin = screenHeight * 0.1;

    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < columns; c++) {
        // Skip some bricks randomly based on difficulty
        if (_difficultyLevel == DifficultyLevel.easy &&
            _random.nextDouble() < 0.2) {
          continue;
        }

        BrickType type = BrickType.normal;
        int hitPoints = 1;
        int points = 10;

        // Create different types of bricks based on position and randomness
        double rand = _random.nextDouble();

        if (r < 2) {
          // Top rows have harder bricks
          if (rand < 0.3) {
            type = BrickType.hard;
            hitPoints = 2;
            points = 20;
          } else if (rand < 0.4 && _difficultyLevel != DifficultyLevel.easy) {
            type = BrickType.explosive;
            points = 30;
          }
        } else if (r < 4) {
          // Middle-top rows
          if (rand < 0.15) {
            type = BrickType.hard;
            hitPoints = 2;
            points = 20;
          } else if (rand < 0.25) {
            type = BrickType.powerUp;
            points = 15;
          }
        } else {
          // Bottom rows
          if (rand < 0.2) {
            type = BrickType.powerUp;
            points = 15;
          }
        }

        bricks.add(Brick(
            position: Vector2D(c * brickWidth, r * brickHeight + topMargin),
            width: brickWidth * 0.95, // Small gap between bricks
            height: brickHeight * 0.9, // Small gap between bricks
            hitPoints: hitPoints,
            points: points,
            type: type));
      }
    }
  }

  // Start the game loop
  void _startGameLoop() {
    _gameLoopTimer?.cancel();
    _gameLoopTimer = Timer.periodic(gameLoopInterval, _update);
  }

  // Main update loop
  void _update(Timer timer) {
    if (_gameState != GameState.playing) return;

    double dt = gameLoopInterval.inMilliseconds / 1000; // Convert to seconds

    // Update game time
    if (!_gameStateController.isClosed) {
      Duration gameTime =
          DateTime.now().difference(_gameStartTime) - _totalPausedTime;
      _gameTimeController.add(gameTime);
    }

    // Update all balls with improved physics
    for (int i = balls.length - 1; i >= 0; i--) {
      Ball ball = balls[i];

      // Store previous position
      ball.updatePreviousPosition();

      // Apply spin influence to velocity
      if (ball.spin != 0) {
        ball.velocity.x += ball.spin * spinFactor * dt;
        _normalizeVelocity(ball);
      }

      // Update ball position
      ball.position.x += ball.velocity.x * dt;
      ball.position.y += ball.velocity.y * dt;

      // Handle collisions
      _handleWallCollisions(ball);
      _handlePaddleCollisions(ball);
      _handleBrickCollisions(ball);

      // Gradually reduce spin
      ball.spin *= 0.99;

      // Remove ball if it falls below the screen
      if (ball.position.y > screenHeight) {
        balls.removeAt(i);

        // Only lose a life if it's the last ball
        if (balls.isEmpty) {
          _lives--;
          _livesController.add(_lives);

          if (_lives <= 0) {
            _gameOver();
          } else {
            _resetBall();
          }
        }
      }
    }

    // Update power-ups
    _updatePowerUps(dt);

    // Update particles
    _updateParticles(dt);

    // Check win condition
    _checkWinCondition();

    // Emit updated state
    _emitState();
  }

  // Handle ball collisions with walls with improved physics
  void _handleWallCollisions(Ball ball) {
    bool collided = false;

    // Left wall
    if (ball.position.x <= 0) {
      ball.position.x = 0;
      ball.velocity.x = -ball.velocity.x * wallBounceDamping;
      ball.spin *= 0.8; // Reduce spin on wall collision
      collided = true;
    }
    // Right wall
    else if (ball.position.x + ball.radius * 2 >= screenWidth) {
      ball.position.x = screenWidth - ball.radius * 2;
      ball.velocity.x = -ball.velocity.x * wallBounceDamping;
      ball.spin *= 0.8;
      collided = true;
    }

    // Top wall
    if (ball.position.y <= 0) {
      ball.position.y = 0;
      ball.velocity.y = -ball.velocity.y * wallBounceDamping;
      ball.spin *= 0.8;
      collided = true;
    }

    // Apply spin effect after wall collisions
    if (collided && ball.spin != 0) {
      double spinInfluence = ball.spin * spinFactor;
      ball.velocity.x += spinInfluence;
      // Ensure ball maintains minimum speed
      _normalizeVelocity(ball);
    }
  }

  // Handle ball collisions with paddle with improved physics
  void _handlePaddleCollisions(Ball ball) {
    if (ball.velocity.y > 0) {
      bool ballInPaddleXRange =
          ball.position.x + ball.radius > paddle.position.x &&
              ball.position.x + ball.radius < paddle.position.x + paddle.width;
      bool ballInPaddleYRange =
          ball.position.y + ball.radius * 2 >= paddle.position.y &&
              ball.position.y + ball.radius * 2 <=
                  paddle.position.y + paddle.height;

      if (ballInPaddleXRange && ballInPaddleYRange) {
        // Calculate where the ball hit the paddle (0 = left edge, 1 = right edge)
        double hitPosition =
            (ball.position.x + ball.radius - paddle.position.x) / paddle.width;

        // Calculate paddle velocity influence with smoothing
        double paddleVelocityX = _paddleVelocity.x;
        double smoothedVelocity =
            paddleVelocityX * 0.7; // Add velocity smoothing
        double velocityInfluence = smoothedVelocity * paddleSpinInfluence;

        // More controlled angle calculation (reduce extreme angles)
        double baseAngle =
            pi * (-0.65 + (hitPosition * 0.3)); // Reduced angle range

        // Smoother angle modification based on paddle movement
        if (paddleVelocityX.abs() > 30) {
          // Reduced threshold
          double angleModifier =
              (paddleVelocityX / 1200) * pi * 0.2; // Reduced influence
          baseAngle += angleModifier.clamp(-pi * 0.12, pi * 0.12);
        }

        // Speed adjustment with smoother transitions
        double currentSpeed = sqrt(ball.velocity.x * ball.velocity.x +
            ball.velocity.y * ball.velocity.y);
        double speedMultiplier = 1.0;

        // More subtle speed adjustments based on paddle movement
        if ((ball.velocity.x > 0 && paddleVelocityX > 0) ||
            (ball.velocity.x < 0 && paddleVelocityX < 0)) {
          speedMultiplier = 1.1; // Reduced from 1.2
        } else if (paddleVelocityX.abs() > 30) {
          speedMultiplier = 0.95; // Less slowdown
        }

        // Smoother speed transition
        double targetSpeed =
            (currentSpeed * speedMultiplier * paddleBounceDamping)
                .clamp(minBallSpeed, maxBallSpeed);

        // Gradual speed adjustment
        double newSpeed = currentSpeed + (targetSpeed - currentSpeed) * 0.3;

        // Set new velocity with smoother transition
        ball.velocity.x = cos(baseAngle) * newSpeed + velocityInfluence * 0.8;
        ball.velocity.y = sin(baseAngle) * newSpeed;

        // Smoother spin application
        ball.spin =
            (paddleVelocityX / 600).clamp(-0.7, 0.7); // Reduced spin range

        // Move ball just above paddle
        ball.position.y = paddle.position.y - ball.radius * 2;

        // Ensure minimum vertical velocity for better gameplay
        _normalizeVelocity(ball);
      }
    }
  }

  // Ensure ball maintains minimum speed and doesn't exceed maximum speed
  void _normalizeVelocity(Ball ball) {
    double speed = sqrt(
        ball.velocity.x * ball.velocity.x + ball.velocity.y * ball.velocity.y);

    if (speed < minBallSpeed || speed > maxBallSpeed) {
      double targetSpeed = speed.clamp(minBallSpeed, maxBallSpeed);
      // Gradual speed adjustment
      double newSpeed = speed + (targetSpeed - speed) * 0.3;
      double ratio = newSpeed / speed;
      ball.velocity.x *= ratio;
      ball.velocity.y *= ratio;
    }

    // Ensure minimum vertical velocity to prevent horizontal stalemates
    double minVerticalRatio = 0.25; // Increased from 0.2
    if (ball.velocity.y.abs() / speed < minVerticalRatio) {
      double sign = ball.velocity.y.sign;
      if (sign == 0) sign = -1;
      ball.velocity.y = speed * minVerticalRatio * sign;
      // Recalculate horizontal velocity to maintain speed
      double newXSpeed =
          sqrt(speed * speed - ball.velocity.y * ball.velocity.y);
      ball.velocity.x = ball.velocity.x.sign * newXSpeed;
    }
  }

  // Add paddle movement tracking
  Vector2D _previousPaddlePosition = Vector2D(0, 0);
  DateTime _lastPaddleUpdateTime = DateTime.now();
  Vector2D _paddleVelocity = Vector2D(0, 0);

  // Constants for physics
  static const double spinFactor = 0.3;
  static const double paddleSpinInfluence = 0.5;
  static const double minBallSpeed = 200.0; // Base speed for casual gameplay
  static const double maxBallSpeed = 600.0; // Maximum speed for lightning mode
  static const double paddleBounceDamping = 0.98;
  static const double wallBounceDamping = 0.99;
  static const double initialBallSpeed = minBallSpeed;

  // Move paddle
  void movePaddle(double targetX) {
    double currentTime = DateTime.now().millisecondsSinceEpoch.toDouble();
    double deltaTime =
        (currentTime - _lastPaddleUpdateTime.millisecondsSinceEpoch) / 1000;

    Vector2D oldPosition = Vector2D(paddle.position.x, paddle.position.y);

    // Calculate paddle movement based on target position
    double paddleTargetX = max(0, min(screenWidth - paddle.width, targetX));
    paddle.position.x = paddleTargetX;

    // Update paddle velocity
    if (deltaTime > 0) {
      _paddleVelocity = Vector2D(
          (paddle.position.x - _previousPaddlePosition.x) / deltaTime, 0);
    }

    _previousPaddlePosition = oldPosition;
    _lastPaddleUpdateTime = DateTime.now();
    _paddleController.add(paddle);
  }

  // Resize game elements based on new screen dimensions
  void resize(double width, double height) {
    double widthRatio = width / screenWidth;
    double heightRatio = height / screenHeight;

    screenWidth = width;
    screenHeight = height;

    // Update normal paddle width
    _normalPaddleWidth *= widthRatio;

    // Resize paddle
    paddle.position.x *= widthRatio;
    paddle.position.y *= heightRatio;
    paddle.width =
        _expandedPaddle ? _normalPaddleWidth * 1.5 : _normalPaddleWidth;
    paddle.height *= heightRatio;

    // Resize balls
    for (Ball ball in balls) {
      ball.position.x *= widthRatio;
      ball.position.y *= heightRatio;
      ball.radius *= min(widthRatio, heightRatio);

      // Adjust velocity to maintain angle
      double speed = sqrt(ball.velocity.x * ball.velocity.x +
          ball.velocity.y * ball.velocity.y);
      double angle = atan2(ball.velocity.y, ball.velocity.x);
      double newSpeed = speed * min(widthRatio, heightRatio);
      ball.velocity.x = cos(angle) * newSpeed;
      ball.velocity.y = sin(angle) * newSpeed;
    }

    // Resize bricks
    for (Brick brick in bricks) {
      brick.position.x *= widthRatio;
      brick.position.y *= heightRatio;
      brick.width *= widthRatio;
      brick.height *= heightRatio;
    }

    // Resize power-ups
    for (PowerUp powerUp in powerUps) {
      powerUp.position.x *= widthRatio;
      powerUp.position.y *= heightRatio;
      powerUp.radius *= min(widthRatio, heightRatio);
    }

    // Emit updated state
    _emitState();
  }

  // Pause the game
  void pause() {
    if (_gameState == GameState.playing) {
      _pauseStartTime = DateTime.now();
      _gameState = GameState.paused;
      _gameStateController.add(_gameState);
      _gameLoopTimer?.cancel();
    }
  }

  // Resume the game
  void resume() {
    if (_gameState == GameState.paused) {
      if (_pauseStartTime != null) {
        _totalPausedTime += DateTime.now().difference(_pauseStartTime!);
        _pauseStartTime = null;
      }
      _gameState = GameState.playing;
      _gameStateController.add(_gameState);
      _startGameLoop();
    }
  }

  // Restart the game
  void restart() {
    _gameLoopTimer?.cancel();
    _powerUpTimer?.cancel();
    _initializeGame();
  }

  // Set difficulty level
  void setDifficultyLevel(DifficultyLevel level) {
    if (_difficultyLevel != level) {
      _difficultyLevel = level;
      restart();
    }
  }

  // Emit current state to stream controllers
  void _emitState() {
    if (!_scoreController.isClosed) _scoreController.add(_score);
    if (!_livesController.isClosed) _livesController.add(_lives);
    if (!_ballsController.isClosed) _ballsController.add(List.from(balls));
    if (!_paddleController.isClosed) _paddleController.add(paddle);
    if (!_bricksController.isClosed) _bricksController.add(List.from(bricks));
    if (!_powerUpsController.isClosed)
      _powerUpsController.add(List.from(powerUps));
    if (!_gameStateController.isClosed) _gameStateController.add(_gameState);
  }

  // Update particles position and lifespan
  void _updateParticles(double dt) {
    for (int i = particles.length - 1; i >= 0; i--) {
      Particle particle = particles[i];

      // Update position
      particle.position.x += particle.velocity.x * dt;
      particle.position.y += particle.velocity.y * dt;

      // Decrease lifespan
      particle.lifespan -= dt;

      // Remove dead particles
      if (particle.lifespan <= 0) {
        particles.removeAt(i);
      }
    }
  }

  // Handle ball collisions with bricks
  void _handleBrickCollisions(Ball ball) {
    for (int i = bricks.length - 1; i >= 0; i--) {
      Brick brick = bricks[i];
      if (brick.isDestroyed) continue;

      // Check for collision
      if (_checkBallBrickCollision(ball, brick)) {
        // Handle collision based on brick type
        switch (brick.type) {
          case BrickType.explosive:
            _triggerExplosion(brick);
            break;
          case BrickType.powerUp:
            _spawnPowerUp(brick);
            break;
          default:
            // Reduce hit points for normal and hard bricks
            brick.hitPoints--;
            if (brick.hitPoints <= 0) {
              brick.isDestroyed = true;
              _score += brick.points;
              _scoreController.add(_score);
            }
        }

        // Calculate bounce direction (simplified)
        // Determine which side of the brick was hit
        double overlapLeft =
            ball.position.x + ball.radius * 2 - brick.position.x;
        double overlapRight = brick.position.x + brick.width - ball.position.x;
        double overlapTop =
            ball.position.y + ball.radius * 2 - brick.position.y;
        double overlapBottom =
            brick.position.y + brick.height - ball.position.y;

        // Find the smallest overlap
        double minOverlap =
            min(min(overlapLeft, overlapRight), min(overlapTop, overlapBottom));

        if (minOverlap == overlapLeft || minOverlap == overlapRight) {
          ball.velocity.x = -ball.velocity.x;
        } else {
          ball.velocity.y = -ball.velocity.y;
        }
      }
    }

    // Remove destroyed bricks
    bricks.removeWhere((brick) => brick.isDestroyed);
  }

  // Check if a ball collides with a brick
  bool _checkBallBrickCollision(Ball ball, Brick brick) {
    // Find the closest point on the brick to the ball
    double closestX = max(brick.position.x,
        min(ball.position.x + ball.radius, brick.position.x + brick.width));
    double closestY = max(brick.position.y,
        min(ball.position.y + ball.radius, brick.position.y + brick.height));

    // Calculate the distance between the closest point and the center of the ball
    double distanceX = (ball.position.x + ball.radius) - closestX;
    double distanceY = (ball.position.y + ball.radius) - closestY;
    double distanceSquared = (distanceX * distanceX) + (distanceY * distanceY);

    return distanceSquared < (ball.radius * ball.radius);
  }

  // Handle explosive bricks with particle effect
  void _triggerExplosion(Brick explodingBrick) {
    explodingBrick.isDestroyed = true;
    _score += explodingBrick.points;
    _scoreController.add(_score);

    // Create explosion particles
    _addExplosionParticles(explodingBrick);

    // Destroy nearby bricks
    for (Brick brick in bricks) {
      if (!brick.isDestroyed && brick != explodingBrick) {
        double distance = (brick.position - explodingBrick.position)
            .distanceTo(Vector2D(0, 0));
        if (distance < brick.width * 2) {
          brick.isDestroyed = true;
          _score += brick.points ~/
              2; // Half points for bricks destroyed by explosion

          // Add smaller explosion for chain reactions
          if (brick.type == BrickType.explosive) {
            _addExplosionParticles(brick, isSecondary: true);
          }
        }
      }
    }
  }

  // Add particles for explosion effect
  void _addExplosionParticles(Brick brick, {bool isSecondary = false}) {
    final Random random = Random();
    final int particleCount =
        isSecondary ? 15 : 30; // More particles for primary explosion
    final double maxVelocity = isSecondary ? 300.0 : 400.0;
    final double particleSize = screenWidth * 0.01;
    final double maxLifespan = isSecondary ? 0.5 : 0.8; // Seconds

    // Get explosion center position
    final Vector2D center = Vector2D(brick.position.x + brick.width / 2,
        brick.position.y + brick.height / 2);

    // Generate particles with different colors based on brick type
    List<Color> particleColors = [
      Colors.red.shade300,
      Colors.red.shade400,
      Colors.red.shade500,
      Colors.orange.shade300,
      Colors.orange.shade400,
      Colors.yellow.shade300
    ];

    for (int i = 0; i < particleCount; i++) {
      // Random angle for particle direction
      final double angle = random.nextDouble() * pi * 2;
      // Random velocity
      final double velocity = random.nextDouble() * maxVelocity;
      // Random size variation
      final double sizeVariation = random.nextDouble() * 0.5 + 0.5;
      // Random color from available colors
      final Color color = particleColors[random.nextInt(particleColors.length)];

      particles.add(Particle(
        position: Vector2D(center.x, center.y),
        velocity: Vector2D(cos(angle) * velocity, sin(angle) * velocity),
        size: particleSize * sizeVariation,
        maxLifespan: maxLifespan *
            (0.7 + random.nextDouble() * 0.3), // Slight variation in lifespan
        color: color,
      ));
    }
  }

  // Spawn a power-up from a brick
  void _spawnPowerUp(Brick brick) {
    brick.isDestroyed = true;
    _score += brick.points;
    _scoreController.add(_score);

    // Determine power-up type
    List<PowerUpType> availableTypes = [
      PowerUpType.expandPaddle,
      PowerUpType.extraLife,
      PowerUpType.multiball,
      PowerUpType.slowBall,
    ];

    // In hard difficulty, add shrink paddle and fast ball to possible power-ups
    if (_difficultyLevel == DifficultyLevel.hard) {
      availableTypes.add(PowerUpType.shrinkPaddle);
      availableTypes.add(PowerUpType.fastBall);
    }

    PowerUpType type = availableTypes[_random.nextInt(availableTypes.length)];

    // Create power-up
    powerUps.add(PowerUp(
        position: Vector2D(
            brick.position.x + brick.width / 2 - screenWidth * 0.015,
            brick.position.y + brick.height / 2 - screenWidth * 0.015),
        velocity: Vector2D(0, powerUpSpeed),
        radius: screenWidth * 0.015,
        type: type));
  }

  // Update power-ups
  void _updatePowerUps(double dt) {
    for (int i = powerUps.length - 1; i >= 0; i--) {
      PowerUp powerUp = powerUps[i];

      // Update position
      powerUp.position.y += powerUp.velocity.y * dt;

      // Check for collection
      if (_checkPowerUpCollection(powerUp)) {
        _activatePowerUp(powerUp);
        powerUps.removeAt(i);
      }
      // Remove if it falls off screen
      else if (powerUp.position.y > screenHeight) {
        powerUps.removeAt(i);
      }
    }
  }

  // Check if power-up is collected
  bool _checkPowerUpCollection(PowerUp powerUp) {
    return powerUp.position.y + powerUp.radius * 2 >= paddle.position.y &&
        powerUp.position.y <= paddle.position.y + paddle.height &&
        powerUp.position.x + powerUp.radius * 2 >= paddle.position.x &&
        powerUp.position.x <= paddle.position.x + paddle.width;
  }

  // Activate collected power-up
  void _activatePowerUp(PowerUp powerUp) {
    switch (powerUp.type) {
      case PowerUpType.extraLife:
        _lives++;
        _livesController.add(_lives);
        break;
      case PowerUpType.expandPaddle:
        _expandedPaddle = true;
        paddle.width = _normalPaddleWidth * 1.5;
        _paddleController.add(paddle);
        _setPowerUpTimer();
        break;
      case PowerUpType.shrinkPaddle:
        paddle.width = max(screenWidth * 0.08, paddle.width * 0.7);
        _paddleController.add(paddle);
        _setPowerUpTimer();
        break;
      case PowerUpType.slowBall:
        _slowedBall = true;
        for (Ball ball in balls) {
          double speed = sqrt(ball.velocity.x * ball.velocity.x +
              ball.velocity.y * ball.velocity.y);
          double direction = atan2(ball.velocity.y, ball.velocity.x);
          ball.velocity.x = cos(direction) * (speed * 0.7);
          ball.velocity.y = sin(direction) * (speed * 0.7);
        }
        _setPowerUpTimer();
        break;
      case PowerUpType.fastBall:
        for (Ball ball in balls) {
          double speed = sqrt(ball.velocity.x * ball.velocity.x +
              ball.velocity.y * ball.velocity.y);
          double direction = atan2(ball.velocity.y, ball.velocity.x);
          ball.velocity.x = cos(direction) * (speed * 1.3);
          ball.velocity.y = sin(direction) * (speed * 1.3);
        }
        break;
      case PowerUpType.multiball:
        _addMultiBalls();
        break;
    }
  }

  // Add multiple balls (multiball power-up)
  void _addMultiBalls() {
    if (balls.isEmpty) return;

    // Use the main ball as reference
    Ball mainBall = balls[0];
    double speed = sqrt(mainBall.velocity.x * mainBall.velocity.x +
        mainBall.velocity.y * mainBall.velocity.y);

    // Add 2 new balls at different angles
    for (int i = 0; i < 2; i++) {
      double angle = atan2(mainBall.velocity.y, mainBall.velocity.x) +
          (i == 0 ? pi / 6 : -pi / 6); // +/- 30 degrees

      Vector2D velocity = Vector2D(cos(angle) * speed, sin(angle) * speed);

      balls.add(Ball(
          position: Vector2D(mainBall.position.x, mainBall.position.y),
          velocity: velocity,
          radius: mainBall.radius));
    }
  }

  // Set timer for temporary power-ups
  void _setPowerUpTimer() {
    _powerUpTimer?.cancel();
    _powerUpTimer = Timer(const Duration(seconds: 10), () {
      // Reset power-ups
      _expandedPaddle = false;
      _slowedBall = false;
      paddle.width = _normalPaddleWidth;
      _paddleController.add(paddle);

      // Reset ball speeds if they were slowed
      for (Ball ball in balls) {
        double currentSpeed = sqrt(ball.velocity.x * ball.velocity.x +
            ball.velocity.y * ball.velocity.y);
        double normalSpeed = ballSpeed;
        if (currentSpeed < normalSpeed * 0.9) {
          double direction = atan2(ball.velocity.y, ball.velocity.x);
          ball.velocity.x = cos(direction) * normalSpeed;
          ball.velocity.y = sin(direction) * normalSpeed;
        }
      }
    });
  }

  // Check win condition
  void _checkWinCondition() {
    if (bricks.isEmpty || bricks.every((brick) => brick.isDestroyed)) {
      _gameState = GameState.win;
      _gameStateController.add(_gameState);
      _gameLoopTimer?.cancel();

      // Update high score if needed
      if (_score > highScore) {
        highScore = _score;
      }
    }
  }

  // Game over
  void _gameOver() {
    _gameState = GameState.gameOver;
    _gameStateController.add(_gameState);
    _gameLoopTimer?.cancel();

    // Update high score if needed
    if (_score > highScore) {
      highScore = _score;
    }
  }

  // Cleanup resources
  void dispose() {
    _gameLoopTimer?.cancel();
    _powerUpTimer?.cancel();
    _gameStateController.close();
    _scoreController.close();
    _livesController.close();
    _ballsController.close();
    _paddleController.close();
    _bricksController.close();
    _powerUpsController.close();
    _gameTimeController.close();
  }
}
