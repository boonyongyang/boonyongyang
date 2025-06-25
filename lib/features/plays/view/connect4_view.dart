import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../shared/widgets/top_nav_bar.dart';
import '../model/connect4_game.dart';

class Connect4View extends StatefulWidget {
  const Connect4View({super.key});

  @override
  State<Connect4View> createState() => _Connect4ViewState();
}

class _Connect4ViewState extends State<Connect4View> {
  late final Connect4Game game;
  int? _hoverColumn;

  @override
  void initState() {
    super.initState();
    game = Connect4Game();
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
    final isSmallScreen = screenSize.width < 350; // For very small screens

    // Calculate optimal board size based on screen dimensions
    final maxBoardWidth =
        isPortrait ? screenSize.width : screenSize.height * 0.9;
    final desiredCellSize = isMobile ? 40.0 : 60.0; // Target cell size
    final minCellSize = isSmallScreen ? 30.0 : 40.0; // Minimum cell size

    // Calculate board size ensuring cells aren't too small
    final calculatedBoardWidth = Connect4Game.columns * desiredCellSize;
    final boardSize = calculatedBoardWidth.clamp(
      Connect4Game.columns * minCellSize,
      maxBoardWidth * (isMobile ? 0.95 : 0.7),
    );

    final cellSize = (boardSize / Connect4Game.columns).floorToDouble();
    final contentPadding = isMobile ? 8.0 : 16.0;
    final boardHeight = cellSize * (Connect4Game.rows + 1); // +1 for drop zone

    return Scaffold(
      appBar: const TopNavBar(title: 'Connect 4'),
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
                        'Connect 4',
                        style: theme.textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.primaryColor,
                        ),
                      ),
                      const Gap(8),
                    ],
                    Text(
                      'Connect four pieces to win!',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.grey[600],
                        fontSize: isSmallScreen ? 14 : null,
                      ),
                    ),
                    SizedBox(height: isMobile ? 16 : 32),
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
                      return StreamBuilder<Player>(
                        stream: game.currentPlayerStream,
                        builder: (context, snapshot) {
                          final currentPlayer =
                              snapshot.data ?? game.currentPlayer;
                          return Text(
                            'Current Turn: ${currentPlayer.name.toUpperCase()}',
                            style: theme.textTheme.headlineMedium?.copyWith(
                              color: currentPlayer == Player.red
                                  ? Colors.red
                                  : Colors.amber,
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  isSmallScreen ? 18 : (isMobile ? 24 : null),
                            ),
                            textAlign: TextAlign.center,
                          );
                        },
                      );
                    case GameState.redWon:
                      statusText = 'Red Wins!';
                      statusColor = Colors.red;
                      break;
                    case GameState.yellowWon:
                      statusText = 'Yellow Wins!';
                      statusColor = Colors.amber;
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
                          fontSize: isSmallScreen ? 18 : (isMobile ? 24 : null),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const Gap(16),
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
                  );
                },
              ),
              SizedBox(height: isMobile ? 16 : 32),

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
                        Connect4Game.rows,
                        (_) => List.filled(Connect4Game.columns, null),
                      );

                  return MouseRegion(
                    onExit: (_) => setState(() => _hoverColumn = null),
                    child: Container(
                      width: boardSize,
                      height: boardHeight,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade800,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Column(
                          children: [
                            // Drop Zone
                            SizedBox(
                              height: cellSize,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children:
                                    List.generate(Connect4Game.columns, (col) {
                                  return MouseRegion(
                                    onEnter: (_) =>
                                        setState(() => _hoverColumn = col),
                                    child: GestureDetector(
                                      onTap: () => game.dropPiece(col),
                                      child: Container(
                                        width: cellSize,
                                        height: cellSize,
                                        color: _hoverColumn == col &&
                                                game.canDropInColumn(col)
                                            ? Colors.blue.shade700
                                            : Colors.transparent,
                                        child: game.canDropInColumn(col)
                                            ? Icon(
                                                Icons.arrow_drop_down,
                                                size: cellSize * 0.8,
                                                color: Colors.white.withOpacity(
                                                  _hoverColumn == col ? 1 : 0.5,
                                                ),
                                              )
                                            : null,
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                            // Game Grid
                            ...List.generate(Connect4Game.rows, (row) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children:
                                    List.generate(Connect4Game.columns, (col) {
                                  final padding =
                                      cellSize * (isSmallScreen ? 0.05 : 0.1);
                                  return Padding(
                                    padding: EdgeInsets.all(padding),
                                    child: _buildCell(
                                      board[row][col],
                                      cellSize - (padding * 2),
                                      isSmallScreen,
                                    ),
                                  );
                                }),
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: isMobile ? 16 : 32),

              // Legend
              Wrap(
                alignment: WrapAlignment.center,
                spacing: isSmallScreen ? 16 : 24,
                runSpacing: isSmallScreen ? 8 : 16,
                children: [
                  _buildLegendItem(
                    title: 'Red',
                    color: Colors.red,
                    theme: theme,
                    isMobile: isMobile,
                    isSmallScreen: isSmallScreen,
                  ),
                  _buildLegendItem(
                    title: 'Yellow',
                    color: Colors.amber,
                    theme: theme,
                    isMobile: isMobile,
                    isSmallScreen: isSmallScreen,
                  ),
                ],
              ),

              // Instructions
              if (!isMobile) ...[
                const Gap(48),
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
                      const Gap(8),
                      Text(
                        'Click on any column to drop your piece. Connect 4 pieces horizontally, vertically, or diagonally to win!',
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

  Widget _buildCell(Player? value, double size, bool isSmallScreen) {
    final borderWidth = isSmallScreen ? 1.0 : 2.0;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.blue.shade900,
          width: borderWidth,
        ),
      ),
      child: value == null
          ? null
          : Container(
              margin: EdgeInsets.all(borderWidth),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: value == Player.red ? Colors.red : Colors.amber,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: isSmallScreen ? 2 : 4,
                    offset: Offset(0, isSmallScreen ? 1 : 2),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildLegendItem({
    required String title,
    required Color color,
    required ThemeData theme,
    required bool isMobile,
    required bool isSmallScreen,
  }) {
    final size = isSmallScreen ? 20.0 : (isMobile ? 24.0 : 32.0);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: isSmallScreen ? 2 : 4,
                offset: Offset(0, isSmallScreen ? 1 : 2),
              ),
            ],
          ),
        ),
        SizedBox(width: isSmallScreen ? 4 : (isMobile ? 6 : 8)),
        Text(
          title,
          style: (isSmallScreen
                  ? theme.textTheme.bodyMedium
                  : (isMobile
                      ? theme.textTheme.titleSmall
                      : theme.textTheme.titleMedium))
              ?.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
