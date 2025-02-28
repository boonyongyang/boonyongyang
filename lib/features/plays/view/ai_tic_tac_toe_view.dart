import 'package:flutter/material.dart';
import '../../../shared/widgets/top_nav_bar.dart';
import '../model/ai_tic_tac_toe_game.dart';

class AITicTacToeView extends StatefulWidget {
  const AITicTacToeView({super.key});

  @override
  State<AITicTacToeView> createState() => _AITicTacToeViewState();
}

class _AITicTacToeViewState extends State<AITicTacToeView> {
  late final AITicTacToeGame game;
  int? _hoverRow;
  int? _hoverCol;

  @override
  void initState() {
    super.initState();
    game = AITicTacToeGame();
  }

  @override
  void dispose() {
    game.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    final isPortrait = screenSize.height > screenSize.width;
    final isMobile = screenSize.width < 600;

    // Calculate board size based on screen dimensions
    final boardSize = isPortrait
        ? screenSize.width * (isMobile ? 0.9 : 0.7)
        : (screenSize.height * 0.7).clamp(
            400.0,
            screenSize.width * 0.5,
          );

    final cellSize = boardSize / AITicTacToeGame.boardSize;
    final contentPadding = isMobile ? 16.0 : 24.0;

    return Scaffold(
      appBar: const TopNavBar(title: 'Tic Tac Toe vs AI'),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(contentPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Game Info Section
              ConstrainedBox(
                constraints:
                    BoxConstraints(maxWidth: isMobile ? double.infinity : 800),
                child: Column(
                  children: [
                    if (!isMobile) ...[
                      Text(
                        'Tic Tac Toe vs AI',
                        style: theme.textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                    Text(
                      'Can you beat the unbeatable?',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),

              // Game Status
              StreamBuilder<GameState>(
                stream: game.gameStateStream,
                builder: (context, snapshot) {
                  final gameState = snapshot.data ?? game.gameState;
                  String statusText;
                  Color statusColor;

                  switch (gameState) {
                    case GameState.playing:
                      statusText = 'Your Turn';
                      statusColor = Colors.blue;
                      break;
                    case GameState.humanWon:
                      statusText = 'You Won! (Impossible?)';
                      statusColor = Colors.green;
                      break;
                    case GameState.aiWon:
                      statusText = 'AI Wins!';
                      statusColor = Colors.red;
                      break;
                    case GameState.draw:
                      statusText = 'Draw!';
                      statusColor = Colors.orange;
                      break;
                  }

                  return Column(
                    children: [
                      Text(
                        statusText,
                        style: theme.textTheme.headlineMedium?.copyWith(
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                          fontSize: isMobile ? 24 : null,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      if (gameState != GameState.playing) ...[
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: game.restart,
                          icon: const Icon(Icons.refresh),
                          label: const Text('Play Again'),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: isMobile ? 16 : 24,
                              vertical: isMobile ? 8 : 12,
                            ),
                          ),
                        ),
                      ],
                    ],
                  );
                },
              ),
              const SizedBox(height: 32),

              // Game Board
              StreamBuilder<List<List<Player?>>>(
                stream: game.boardStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('Error loading game board'),
                    );
                  }

                  final board = snapshot.data ??
                      List.generate(
                        AITicTacToeGame.boardSize,
                        (_) => List.filled(AITicTacToeGame.boardSize, null),
                      );

                  return MouseRegion(
                    onExit: (_) => setState(() {
                      _hoverRow = null;
                      _hoverCol = null;
                    }),
                    child: Container(
                      width: boardSize,
                      height: boardSize,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                            List.generate(AITicTacToeGame.boardSize, (row) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                                List.generate(AITicTacToeGame.boardSize, (col) {
                              return MouseRegion(
                                onEnter: (_) => setState(() {
                                  _hoverRow = row;
                                  _hoverCol = col;
                                }),
                                child: GestureDetector(
                                  onTap: () => game.makeMove(row, col),
                                  child: Container(
                                    width: cellSize,
                                    height: cellSize,
                                    decoration: BoxDecoration(
                                      color: _hoverRow == row &&
                                              _hoverCol == col &&
                                              game.canMakeMove(row, col)
                                          ? Colors.blue.withOpacity(0.1)
                                          : null,
                                      border: Border(
                                        right: col < 2
                                            ? BorderSide(
                                                color: Colors.grey[300]!)
                                            : BorderSide.none,
                                        bottom: row < 2
                                            ? BorderSide(
                                                color: Colors.grey[300]!)
                                            : BorderSide.none,
                                      ),
                                    ),
                                    child:
                                        _buildCell(board[row][col], cellSize),
                                  ),
                                ),
                              );
                            }),
                          );
                        }),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 32),

              // Legend
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 24,
                runSpacing: 16,
                children: [
                  _buildLegendItem(
                    title: 'You',
                    symbol: 'X',
                    color: Colors.blue,
                    theme: theme,
                    isMobile: isMobile,
                  ),
                  _buildLegendItem(
                    title: 'AI',
                    symbol: 'O',
                    color: Colors.red,
                    theme: theme,
                    isMobile: isMobile,
                  ),
                ],
              ),

              // Instructions
              if (!isMobile) ...[
                const SizedBox(height: 48),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'How to Play',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Click on any empty cell to make your move. The AI will respond immediately.',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: Colors.grey[700],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCell(Player? value, double size) {
    if (value == null) return const SizedBox.shrink();

    final isHuman = value == Player.human;
    return Center(
      child: Icon(
        isHuman ? Icons.close : Icons.circle_outlined,
        size: size * 0.6,
        color: isHuman ? Colors.blue : Colors.red,
      ),
    );
  }

  Widget _buildLegendItem({
    required String title,
    required String symbol,
    required Color color,
    required ThemeData theme,
    required bool isMobile,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: isMobile ? 24 : 32,
          height: isMobile ? 24 : 32,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              symbol,
              style: TextStyle(
                color: color,
                fontSize: isMobile ? 16 : 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(width: isMobile ? 6 : 8),
        Text(
          title,
          style: (isMobile
                  ? theme.textTheme.titleSmall
                  : theme.textTheme.titleMedium)
              ?.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
