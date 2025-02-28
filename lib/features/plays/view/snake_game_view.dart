import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../shared/widgets/top_nav_bar.dart';
import '../model/snake_game.dart';

class SnakeGameView extends StatefulWidget {
  const SnakeGameView({super.key});

  @override
  State<SnakeGameView> createState() => _SnakeGameViewState();
}

class _SnakeGameViewState extends State<SnakeGameView>
    with SingleTickerProviderStateMixin {
  late SnakeGame game;
  late AnimationController _animationController;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    game = SnakeGame();
    _focusNode.requestFocus();

    // Setup animation controller for continuous updates
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 50), // 20 FPS
    );
    _animationController.repeat();
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
      case LogicalKeyboardKey.keyW:
      case LogicalKeyboardKey.arrowUp:
        game.changeDirection(Direction.up);
        break;
      case LogicalKeyboardKey.keyS:
      case LogicalKeyboardKey.arrowDown:
        game.changeDirection(Direction.down);
        break;
      case LogicalKeyboardKey.keyA:
      case LogicalKeyboardKey.arrowLeft:
        game.changeDirection(Direction.left);
        break;
      case LogicalKeyboardKey.keyD:
      case LogicalKeyboardKey.arrowRight:
        game.changeDirection(Direction.right);
        break;
      case LogicalKeyboardKey.keyR:
        if (game.gameState == GameState.gameOver) {
          game.restart();
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isPortrait = screenSize.height > screenSize.width;

    // Calculate game board size based on screen dimensions
    final gameBoardSize = isPortrait
        ? screenSize.width * 0.9 // 90% of screen width in portrait
        : (screenSize.height * 0.7).clamp(
            // 70% of screen height in landscape
            300.0, // minimum size
            screenSize.width * 0.5, // maximum 50% of screen width
          );

    // Calculate cell size
    final cellSize = gameBoardSize / SnakeGame.gridSize;

    return Scaffold(
      appBar: const TopNavBar(title: 'Snake Battle'),
      body: RawKeyboardListener(
        focusNode: _focusNode,
        onKey: _handleKeyEvent,
        autofocus: true,
        child: GestureDetector(
          onTap: () => _focusNode.requestFocus(),
          child: Center(
            child: SingleChildScrollView(
              child: isPortrait
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildGameContent(
                          context,
                          gameBoardSize,
                          cellSize,
                          isPortrait: true,
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildGameContent(
                          context,
                          gameBoardSize,
                          cellSize,
                          isPortrait: false,
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGameContent(
    BuildContext context,
    double gameBoardSize,
    double cellSize, {
    required bool isPortrait,
  }) {
    final buttonSize = isPortrait ? 50.0 : 60.0;
    final iconSize = isPortrait ? 24.0 : 32.0;
    final spacing = isPortrait ? 12.0 : 20.0;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Score and High Score
        StreamBuilder<int>(
          stream: game.scoreStream,
          builder: (context, snapshot) {
            final textStyle =
                Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontSize: isPortrait ? 20 : 24,
                    );
            return Wrap(
              spacing: spacing * 2,
              children: [
                Text('Score: ${game.score}', style: textStyle),
                Text('High Score: ${SnakeGame.highScore}', style: textStyle),
              ],
            );
          },
        ),
        SizedBox(height: spacing),

        // AI Speed Indicator
        if (game.isAiActive)
          StreamBuilder<double>(
            stream: game.aiSpeedStream,
            builder: (context, snapshot) {
              return Text(
                'AI Speed: ${(game.aiSpeed).toStringAsFixed(1)}x',
                style: TextStyle(
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
                  fontSize: isPortrait ? 16 : 18,
                ),
              );
            },
          ),
        SizedBox(height: spacing),

        // Game Board
        AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Container(
              width: gameBoardSize,
              height: gameBoardSize,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: CustomPaint(
                painter: SnakeGamePainter(
                  game: game,
                  gridSize: SnakeGame.gridSize,
                ),
              ),
            );
          },
        ),
        SizedBox(height: spacing),

        // Direction Pad
        if (game.gameState == GameState.playing)
          Container(
            padding: EdgeInsets.all(spacing / 2),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                // Up button
                SizedBox(
                  width: buttonSize,
                  height: buttonSize,
                  child: ElevatedButton(
                    onPressed: () => game.changeDirection(Direction.up),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Icon(Icons.keyboard_arrow_up, size: iconSize),
                  ),
                ),
                SizedBox(height: spacing / 2),
                // Left, Down, Right buttons in a row
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: buttonSize,
                      height: buttonSize,
                      child: ElevatedButton(
                        onPressed: () => game.changeDirection(Direction.left),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Icon(Icons.keyboard_arrow_left, size: iconSize),
                      ),
                    ),
                    SizedBox(width: spacing / 2),
                    SizedBox(
                      width: buttonSize,
                      height: buttonSize,
                      child: ElevatedButton(
                        onPressed: () => game.changeDirection(Direction.down),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Icon(Icons.keyboard_arrow_down, size: iconSize),
                      ),
                    ),
                    SizedBox(width: spacing / 2),
                    SizedBox(
                      width: buttonSize,
                      height: buttonSize,
                      child: ElevatedButton(
                        onPressed: () => game.changeDirection(Direction.right),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Icon(Icons.keyboard_arrow_right, size: iconSize),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        SizedBox(height: spacing),

        // Game Over Message
        StreamBuilder<GameState>(
          stream: game.gameStateStream,
          builder: (context, snapshot) {
            if (snapshot.data == GameState.gameOver) {
              return Column(
                children: [
                  Text(
                    'Game Over! Score: ${game.score}',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.red,
                          fontSize: isPortrait ? 20 : 24,
                        ),
                  ),
                  SizedBox(height: spacing / 2),
                  ElevatedButton(
                    onPressed: game.restart,
                    child: const Text('Play Again'),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
        SizedBox(height: spacing),

        // Legend and Controls
        Container(
          padding: EdgeInsets.all(spacing),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Text(
                'Controls:',
                style: TextStyle(
                  fontSize: isPortrait ? 16 : 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spacing / 2),
              Text(
                'W A S D or Arrow Keys - Move Snake\n'
                'R - Restart when game over',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: isPortrait ? 14 : 16),
              ),
              SizedBox(height: spacing),
              Wrap(
                spacing: spacing,
                runSpacing: spacing / 2,
                alignment: WrapAlignment.center,
                children: [
                  _LegendItem(
                    color: Colors.green,
                    label: 'Player Snake',
                    fontSize: isPortrait ? 12 : 14,
                  ),
                  _LegendItem(
                    color: Colors.purple,
                    label: 'AI Snake',
                    fontSize: isPortrait ? 12 : 14,
                  ),
                  _LegendItem(
                    color: Colors.red,
                    label: 'Food',
                    fontSize: isPortrait ? 12 : 14,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  final double fontSize;

  const _LegendItem({
    required this.color,
    required this.label,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(fontSize: fontSize),
        ),
      ],
    );
  }
}

class SnakeGamePainter extends CustomPainter {
  final SnakeGame game;
  final int gridSize;

  SnakeGamePainter({
    required this.game,
    required this.gridSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cellWidth = size.width / gridSize;
    final cellHeight = size.height / gridSize;

    // Draw grid
    final gridPaint = Paint()
      ..color = Colors.grey.withOpacity(0.2)
      ..style = PaintingStyle.stroke;

    for (var i = 0; i <= gridSize; i++) {
      canvas.drawLine(
        Offset(i * cellWidth, 0),
        Offset(i * cellWidth, size.height),
        gridPaint,
      );
      canvas.drawLine(
        Offset(0, i * cellHeight),
        Offset(size.width, i * cellHeight),
        gridPaint,
      );
    }

    // Draw player snake
    final playerPaint = Paint()..color = Colors.green;
    for (var pos in game.playerSnake) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            pos.x * cellWidth,
            pos.y * cellHeight,
            cellWidth,
            cellHeight,
          ),
          const Radius.circular(4),
        ),
        playerPaint,
      );
    }

    // Draw AI snake
    if (game.isAiActive) {
      final aiPaint = Paint()..color = Colors.purple;
      for (var pos in game.aiSnake) {
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(
              pos.x * cellWidth,
              pos.y * cellHeight,
              cellWidth,
              cellHeight,
            ),
            const Radius.circular(4),
          ),
          aiPaint,
        );
      }
    }

    // Draw food
    if (game.food != null) {
      final foodPaint = Paint()..color = Colors.red;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            game.food!.x * cellWidth,
            game.food!.y * cellHeight,
            cellWidth,
            cellHeight,
          ),
          const Radius.circular(4),
        ),
        foodPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
