import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../shared/widgets/top_nav_bar.dart';
import '../cubit/snake_game_cubit.dart';
import '../model/snake_game.dart';

class SnakeGameView extends StatelessWidget {
  const SnakeGameView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SnakeGameCubit(),
      child: const _SnakeGameBody(),
    );
  }
}

class _SnakeGameBody extends StatefulWidget {
  const _SnakeGameBody();

  @override
  State<_SnakeGameBody> createState() => _SnakeGameBodyState();
}

class _SnakeGameBodyState extends State<_SnakeGameBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 50),
    );
    _animationController.repeat();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _animationController.dispose();
    super.dispose();
  }

  KeyEventResult _handleKeyEvent(KeyEvent event) {
    if (event is! KeyDownEvent) {
      return KeyEventResult.ignored;
    }

    final cubit = context.read<SnakeGameCubit>();

    switch (event.logicalKey) {
      case LogicalKeyboardKey.keyW:
      case LogicalKeyboardKey.arrowUp:
        cubit.changeDirection(Direction.up);
        break;
      case LogicalKeyboardKey.keyS:
      case LogicalKeyboardKey.arrowDown:
        cubit.changeDirection(Direction.down);
        break;
      case LogicalKeyboardKey.keyA:
      case LogicalKeyboardKey.arrowLeft:
        cubit.changeDirection(Direction.left);
        break;
      case LogicalKeyboardKey.keyD:
      case LogicalKeyboardKey.arrowRight:
        cubit.changeDirection(Direction.right);
        break;
      case LogicalKeyboardKey.keyR:
        if (cubit.state.isGameOver) {
          cubit.restart();
        }
        break;
      default:
        return KeyEventResult.ignored;
    }

    return KeyEventResult.handled;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isPortrait = screenSize.height > screenSize.width;

    final gameBoardSize = isPortrait
        ? screenSize.width * 0.9
        : (screenSize.height * 0.7).clamp(300.0, screenSize.width * 0.5);

    final cellSize = gameBoardSize / SnakeGame.gridSize;

    return Scaffold(
      appBar: const TopNavBar(title: 'Snake Battle'),
      body: KeyboardListener(
        focusNode: _focusNode,
        onKeyEvent: _handleKeyEvent,
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
    final cubit = context.read<SnakeGameCubit>();
    final game = cubit.game;

    return BlocBuilder<SnakeGameCubit, SnakeGameState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Score and High Score
            Wrap(
              spacing: spacing * 2,
              children: [
                Text(
                  'Score: ${state.score}',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontSize: isPortrait ? 20 : 24,
                      ),
                ),
                Text(
                  'High Score: ${state.highScore}',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontSize: isPortrait ? 20 : 24,
                      ),
                ),
              ],
            ),
            SizedBox(height: spacing),

            // AI Speed Indicator
            if (game.isAiActive)
              Text(
                'AI Speed: ${state.aiSpeed.toStringAsFixed(1)}x',
                style: TextStyle(
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
                  fontSize: isPortrait ? 16 : 18,
                ),
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
            if (!state.isGameOver)
              Container(
                padding: EdgeInsets.all(spacing / 2),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      width: buttonSize,
                      height: buttonSize,
                      child: ElevatedButton(
                        onPressed: () => cubit.changeDirection(Direction.up),
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
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: buttonSize,
                          height: buttonSize,
                          child: ElevatedButton(
                            onPressed: () =>
                                cubit.changeDirection(Direction.left),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child:
                                Icon(Icons.keyboard_arrow_left, size: iconSize),
                          ),
                        ),
                        SizedBox(width: spacing / 2),
                        SizedBox(
                          width: buttonSize,
                          height: buttonSize,
                          child: ElevatedButton(
                            onPressed: () =>
                                cubit.changeDirection(Direction.down),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child:
                                Icon(Icons.keyboard_arrow_down, size: iconSize),
                          ),
                        ),
                        SizedBox(width: spacing / 2),
                        SizedBox(
                          width: buttonSize,
                          height: buttonSize,
                          child: ElevatedButton(
                            onPressed: () =>
                                cubit.changeDirection(Direction.right),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Icon(Icons.keyboard_arrow_right,
                                size: iconSize),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            SizedBox(height: spacing),

            // Game Over Message
            if (state.isGameOver)
              Column(
                children: [
                  Text(
                    'Game Over! Score: ${state.score}',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.red,
                          fontSize: isPortrait ? 20 : 24,
                        ),
                  ),
                  SizedBox(height: spacing / 2),
                  ElevatedButton(
                    onPressed: cubit.restart,
                    child: const Text('Play Again'),
                  ),
                ],
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
      },
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
        const Gap(8),
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
