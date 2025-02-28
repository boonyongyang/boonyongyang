import 'package:flutter/material.dart';
import '../../../shared/widgets/top_nav_bar.dart';
import '../model/tic_tac_toe_game.dart';

class TicTacToeView extends StatefulWidget {
  const TicTacToeView({super.key});

  @override
  State<TicTacToeView> createState() => _TicTacToeViewState();
}

class _TicTacToeViewState extends State<TicTacToeView> {
  late final TicTacToeGame game;

  @override
  void initState() {
    super.initState();
    game = TicTacToeGame();
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

    // Calculate board size based on screen dimensions
    final boardSize = isPortrait
        ? screenSize.width * 0.9
        : (screenSize.height * 0.7).clamp(
            300.0,
            screenSize.width * 0.5,
          );

    return Scaffold(
      appBar: const TopNavBar(title: 'Tic Tac Toe'),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Game Status
              StreamBuilder<GameState>(
                stream: game.gameStateStream,
                builder: (context, snapshot) {
                  final gameState = snapshot.data ?? game.gameState;
                  String statusText;
                  Color statusColor;

                  switch (gameState) {
                    case GameState.playing:
                      return StreamBuilder<Player>(
                        stream: game.currentPlayerStream,
                        builder: (context, snapshot) {
                          final currentPlayer =
                              snapshot.data ?? game.currentPlayer;
                          return Text(
                            'Current Turn: ${currentPlayer.name}',
                            style: theme.textTheme.headlineMedium?.copyWith(
                              color: currentPlayer == Player.X
                                  ? Colors.blue
                                  : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      );
                    case GameState.xWon:
                      statusText = 'Player X Wins!';
                      statusColor = Colors.blue;
                      break;
                    case GameState.oWon:
                      statusText = 'Player O Wins!';
                      statusColor = Colors.red;
                      break;
                    case GameState.draw:
                      statusText = 'Draw!';
                      statusColor = Colors.grey;
                      break;
                  }

                  return Column(
                    children: [
                      Text(
                        statusText,
                        style: theme.textTheme.headlineMedium?.copyWith(
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: game.restart,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Play Again'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 32),

              // Game Board
              StreamBuilder<List<Player?>>(
                stream: game.boardStream,
                builder: (context, snapshot) {
                  final board = snapshot.data ?? game.board;
                  return Container(
                    width: boardSize,
                    height: boardSize,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: GridView.builder(
                      padding: const EdgeInsets.all(8),
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                      ),
                      itemCount: 9,
                      itemBuilder: (context, index) {
                        return _buildCell(board[index], index);
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 32),

              // Legend
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLegendItem(
                    player: Player.X,
                    color: Colors.blue,
                    theme: theme,
                  ),
                  const SizedBox(width: 24),
                  _buildLegendItem(
                    player: Player.O,
                    color: Colors.red,
                    theme: theme,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCell(Player? value, int index) {
    return Material(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () => game.makeMove(index),
        borderRadius: BorderRadius.circular(12),
        child: Center(
          child: value == null
              ? null
              : Icon(
                  value == Player.X ? Icons.close : Icons.circle_outlined,
                  size: 48,
                  color: value == Player.X ? Colors.blue : Colors.red,
                ),
        ),
      ),
    );
  }

  Widget _buildLegendItem({
    required Player player,
    required Color color,
    required ThemeData theme,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          player == Player.X ? Icons.close : Icons.circle_outlined,
          color: color,
          size: 24,
        ),
        const SizedBox(width: 8),
        Text(
          'Player ${player.name}',
          style: theme.textTheme.titleMedium?.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
