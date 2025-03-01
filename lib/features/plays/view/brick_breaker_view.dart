import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../shared/widgets/top_nav_bar.dart';
import '../model/brick_breaker_game.dart';

class BrickBreakerView extends StatefulWidget {
  const BrickBreakerView({super.key});

  @override
  State<BrickBreakerView> createState() => _BrickBreakerViewState();
}

class _BrickBreakerViewState extends State<BrickBreakerView>
    with SingleTickerProviderStateMixin {
  late BrickBreakerGame game;
  late AnimationController _animationController;
  final FocusNode _focusNode = FocusNode();
  bool _isPaused = false;

  // Touch control variables
  bool _isDragging = false;
  double? _lastTouchX;

  @override
  void initState() {
    super.initState();
    _initializeGame();
    _focusNode.requestFocus();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 16), // ~60 FPS
    );
    _animationController.repeat();
  }

  void _initializeGame() {
    // Initialize with temporary size, will be updated in build
    game = BrickBreakerGame(
      initialWidth: 800,
      initialHeight: 600,
      difficultyLevel: DifficultyLevel.medium,
    );
  }

  @override
  void dispose() {
    game.dispose();
    _focusNode.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _handleKeyEvent(RawKeyEvent event) {
    if (event is! RawKeyDownEvent) return;

    switch (event.logicalKey) {
      case LogicalKeyboardKey.arrowLeft:
      case LogicalKeyboardKey.keyA:
        _movePaddle(-1);
        break;
      case LogicalKeyboardKey.arrowRight:
      case LogicalKeyboardKey.keyD:
        _movePaddle(1);
        break;
      case LogicalKeyboardKey.space:
        _togglePause();
        break;
      case LogicalKeyboardKey.keyR:
        if (game.gameState != GameState.playing) {
          game.restart();
        }
        break;
      case LogicalKeyboardKey.digit1:
        game.setDifficultyLevel(DifficultyLevel.easy);
        break;
      case LogicalKeyboardKey.digit2:
        game.setDifficultyLevel(DifficultyLevel.medium);
        break;
      case LogicalKeyboardKey.digit3:
        game.setDifficultyLevel(DifficultyLevel.hard);
        break;
    }
  }

  void _movePaddle(int direction) {
    if (game.gameState == GameState.playing && !_isPaused) {
      final movement = direction * (game.screenWidth * 0.03);
      game.movePaddle(game.paddle.position.x + movement);
    }
  }

  void _togglePause() {
    setState(() {
      _isPaused = !_isPaused;
      if (_isPaused) {
        game.pause();
      } else {
        game.resume();
      }
    });
  }

  void _handlePanUpdate(DragUpdateDetails details) {
    if (!_isDragging) return;

    final double currentX = details.globalPosition.dx;
    if (_lastTouchX != null) {
      final double delta = currentX - _lastTouchX!;
      game.movePaddle(game.paddle.position.x + delta);
    }
    _lastTouchX = currentX;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    final isPortrait = screenSize.height > screenSize.width;
    final isMobile = screenSize.width < 600;

    // Calculate game board size based on screen dimensions
    final gameWidth =
        isPortrait ? screenSize.width * 0.95 : screenSize.width * 0.7;
    final gameHeight =
        isPortrait ? screenSize.height * 0.7 : screenSize.height * 0.8;

    // Update game dimensions if they changed
    game.resize(gameWidth, gameHeight);

    return Scaffold(
      appBar: const TopNavBar(title: 'Brick Breaker'),
      body: RawKeyboardListener(
        focusNode: _focusNode,
        onKey: _handleKeyEvent,
        child: GestureDetector(
          onTap: () => _focusNode.requestFocus(),
          onPanStart: (details) {
            _isDragging = true;
            _lastTouchX = details.globalPosition.dx;
          },
          onPanUpdate: _handlePanUpdate,
          onPanEnd: (_) {
            _isDragging = false;
            _lastTouchX = null;
          },
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Game Status Section
                  Container(
                    margin: EdgeInsets.all(isMobile ? 8 : 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildInfoCard(
                          context,
                          title: 'Score',
                          stream: game.scoreStream,
                          initialValue: game.score,
                          color: Colors.blue,
                        ),
                        SizedBox(width: isMobile ? 8 : 16),
                        _buildInfoCard(
                          context,
                          title: 'High Score',
                          value: BrickBreakerGame.highScore,
                          color: Colors.purple,
                        ),
                        SizedBox(width: isMobile ? 8 : 16),
                        _buildInfoCard(
                          context,
                          title: 'Lives',
                          stream: game.livesStream,
                          initialValue: game.lives,
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ),

                  // Game Board
                  Container(
                    width: gameWidth,
                    height: gameHeight,
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.blue.withOpacity(0.5),
                        width: 2,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Stack(
                        children: [
                          // Game Canvas
                          AnimatedBuilder(
                            animation: _animationController,
                            builder: (context, _) => CustomPaint(
                              size: Size(gameWidth, gameHeight),
                              painter: BrickBreakerPainter(game: game),
                            ),
                          ),

                          // Pause Overlay
                          if (_isPaused)
                            Container(
                              color: Colors.black54,
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.pause_circle_outline,
                                      size: isMobile ? 48 : 64,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      'PAUSED',
                                      style: theme.textTheme.headlineMedium
                                          ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                    ElevatedButton.icon(
                                      onPressed: _togglePause,
                                      icon: const Icon(Icons.play_arrow),
                                      label: const Text('Resume'),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                          // Game Over Overlay
                          StreamBuilder<GameState>(
                            stream: game.gameStateStream,
                            builder: (context, snapshot) {
                              final gameState = snapshot.data ?? game.gameState;
                              if (gameState == GameState.gameOver ||
                                  gameState == GameState.win) {
                                return Container(
                                  color: Colors.black54,
                                  child: Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          gameState == GameState.win
                                              ? Icons.emoji_events
                                              : Icons.warning_amber,
                                          size: isMobile ? 48 : 64,
                                          color: gameState == GameState.win
                                              ? Colors.amber
                                              : Colors.red,
                                        ),
                                        const SizedBox(height: 16),
                                        Text(
                                          gameState == GameState.win
                                              ? 'YOU WIN!'
                                              : 'GAME OVER',
                                          style: theme.textTheme.headlineMedium
                                              ?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Score: ${game.score}',
                                          style: theme.textTheme.titleLarge
                                              ?.copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(height: 24),
                                        ElevatedButton.icon(
                                          onPressed: game.restart,
                                          icon: const Icon(Icons.refresh),
                                          label: const Text('Play Again'),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Controls Section
                  Container(
                    margin: EdgeInsets.all(isMobile ? 8 : 16),
                    padding: EdgeInsets.all(isMobile ? 12 : 16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Controls',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 16,
                          runSpacing: 8,
                          children: [
                            _ControlItem(
                              icon: Icons.keyboard_arrow_left,
                              label: 'A / Left',
                              onPressed: () => _movePaddle(-1),
                            ),
                            _ControlItem(
                              icon: Icons.keyboard_arrow_right,
                              label: 'D / Right',
                              onPressed: () => _movePaddle(1),
                            ),
                            _ControlItem(
                              icon: Icons.space_bar,
                              label: 'Space',
                              onPressed: _togglePause,
                            ),
                            _ControlItem(
                              icon: Icons.refresh,
                              label: 'R',
                              onPressed: game.gameState != GameState.playing
                                  ? game.restart
                                  : null,
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        _buildSpeedControl(theme, isMobile),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Difficulty:',
                              style: theme.textTheme.titleMedium,
                            ),
                            const SizedBox(width: 16),
                            ToggleButtons(
                              isSelected: [
                                game.difficultyLevel == DifficultyLevel.easy,
                                game.difficultyLevel == DifficultyLevel.medium,
                                game.difficultyLevel == DifficultyLevel.hard,
                              ],
                              onPressed: (index) {
                                game.setDifficultyLevel(
                                    DifficultyLevel.values[index]);
                              },
                              borderRadius: BorderRadius.circular(8),
                              children: const [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  child: Text('Easy'),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  child: Text('Medium'),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  child: Text('Hard'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSpeedControl(ThemeData theme, bool isMobile) {
    return Column(
      children: [
        Text(
          'Ball Speed: ${(game.speedMultiplier).toStringAsFixed(1)}x',
          style: theme.textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: isMobile ? 200 : 300,
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Colors.blue.shade300,
              inactiveTrackColor: Colors.blue.shade100,
              thumbColor: Colors.blue,
              overlayColor: Colors.blue.withOpacity(0.3),
            ),
            child: Slider(
              value: game.speedMultiplier,
              min: 0.5,
              max: 2.0,
              divisions: 15,
              label: '${game.speedMultiplier}x',
              onChanged: (value) {
                setState(() {
                  game.speedMultiplier = value;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required String title,
    Stream<int>? stream,
    int? value,
    required Color color,
    int? initialValue,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
          ),
          if (stream != null)
            StreamBuilder<int>(
              stream: stream,
              initialData: initialValue,
              builder: (context, snapshot) {
                return Text(
                  '${snapshot.data ?? 0}',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: color,
                        fontWeight: FontWeight.w500,
                      ),
                );
              },
            )
          else
            Text(
              '$value',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w500,
                  ),
            ),
        ],
      ),
    );
  }
}

class _ControlItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onPressed;

  const _ControlItem({
    required this.icon,
    required this.label,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: isMobile ? 40 : 48,
          height: isMobile ? 40 : 48,
          margin: const EdgeInsets.only(bottom: 4),
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Icon(icon),
          ),
        ),
        Text(
          label,
          style: theme.textTheme.bodySmall,
        ),
      ],
    );
  }
}

class BrickBreakerPainter extends CustomPainter {
  final BrickBreakerGame game;
  final Paint _brickPaint = Paint();
  final Paint _paddlePaint = Paint()..color = Colors.blue;
  final Paint _ballPaint = Paint()..color = Colors.white;

  BrickBreakerPainter({required this.game});

  @override
  void paint(Canvas canvas, Size size) {
    // Draw bricks
    for (final brick in game.bricks) {
      // Set brick color based on type
      switch (brick.type) {
        case BrickType.normal:
          _brickPaint.color = Colors.blue.shade400;
          break;
        case BrickType.hard:
          _brickPaint.color = Colors.purple.shade400;
          break;
        case BrickType.explosive:
          _brickPaint.color = Colors.red.shade400;
          break;
        case BrickType.powerUp:
          _brickPaint.color = Colors.green.shade400;
          break;
      }

      // Add gradient effect based on hit points
      if (brick.type == BrickType.hard && brick.hitPoints > 1) {
        _brickPaint.shader = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.purple.shade400,
            Colors.purple.shade600,
          ],
        ).createShader(Rect.fromLTWH(
          brick.position.x,
          brick.position.y,
          brick.width,
          brick.height,
        ));
      } else {
        _brickPaint.shader = null;
      }

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            brick.position.x,
            brick.position.y,
            brick.width,
            brick.height,
          ),
          const Radius.circular(4),
        ),
        _brickPaint,
      );
    }

    // Draw paddle with gradient
    final paddleGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.blue.shade300, Colors.blue.shade700],
    ).createShader(Rect.fromLTWH(
      game.paddle.position.x,
      game.paddle.position.y,
      game.paddle.width,
      game.paddle.height,
    ));
    _paddlePaint.shader = paddleGradient;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          game.paddle.position.x,
          game.paddle.position.y,
          game.paddle.width,
          game.paddle.height,
        ),
        const Radius.circular(8),
      ),
      _paddlePaint,
    );

    // Draw balls with glow effect
    for (final ball in game.balls) {
      // Draw glow
      final glowPaint = Paint()
        ..color = Colors.blue.withOpacity(0.3)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
      canvas.drawCircle(
        Offset(
          ball.position.x + ball.radius,
          ball.position.y + ball.radius,
        ),
        ball.radius * 1.5,
        glowPaint,
      );

      // Draw ball
      canvas.drawCircle(
        Offset(
          ball.position.x + ball.radius,
          ball.position.y + ball.radius,
        ),
        ball.radius,
        _ballPaint,
      );
    }

    // Draw power-ups
    for (final powerUp in game.powerUps) {
      final powerUpPaint = Paint()..color = _getPowerUpColor(powerUp.type);
      canvas.drawCircle(
        Offset(
          powerUp.position.x + powerUp.radius,
          powerUp.position.y + powerUp.radius,
        ),
        powerUp.radius,
        powerUpPaint,
      );

      // Draw power-up icon
      TextPainter(
        text: TextSpan(
          text: _getPowerUpIcon(powerUp.type),
          style: TextStyle(
            color: Colors.white,
            fontSize: powerUp.radius * 1.2,
            fontFamily: 'MaterialIcons',
          ),
        ),
        textDirection: TextDirection.ltr,
      )
        ..layout()
        ..paint(
          canvas,
          Offset(
            powerUp.position.x,
            powerUp.position.y,
          ),
        );
    }
  }

  Color _getPowerUpColor(PowerUpType type) {
    switch (type) {
      case PowerUpType.extraLife:
        return Colors.red;
      case PowerUpType.expandPaddle:
        return Colors.green;
      case PowerUpType.shrinkPaddle:
        return Colors.orange;
      case PowerUpType.slowBall:
        return Colors.blue;
      case PowerUpType.fastBall:
        return Colors.purple;
      case PowerUpType.multiball:
        return Colors.yellow;
    }
  }

  String _getPowerUpIcon(PowerUpType type) {
    switch (type) {
      case PowerUpType.extraLife:
        return '♥';
      case PowerUpType.expandPaddle:
        return '↔';
      case PowerUpType.shrinkPaddle:
        return '↕';
      case PowerUpType.slowBall:
        return '⏱';
      case PowerUpType.fastBall:
        return '⚡';
      case PowerUpType.multiball:
        return '✧';
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
