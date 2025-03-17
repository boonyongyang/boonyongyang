import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import '../../../core/style/style.dart';
import '../../../shared/widgets/top_nav_bar.dart';
import '../model/brick_breaker_game.dart';

class BrickBreakerView extends StatefulWidget {
  const BrickBreakerView({super.key});

  @override
  State<BrickBreakerView> createState() => _BrickBreakerViewState();
}

class _BrickBreakerViewState extends State<BrickBreakerView>
    with TickerProviderStateMixin {
  late BrickBreakerGame game;
  late AnimationController _animationController;
  final FocusNode _focusNode = FocusNode();
  bool _isPaused = false;

  // Game area position reference (for cursor tracking)
  final GlobalKey _gameAreaKey = GlobalKey();
  Offset _gameAreaPosition = Offset.zero;
  Size _gameAreaSize = Size.zero;

  // Tab controller for info panel
  late TabController _tabController;

  // Define brick type information
  final Map<BrickType, Map<String, dynamic>> _brickInfo = {
    BrickType.normal: {
      'name': 'Normal',
      'color': Colors.blue.shade400,
      'points': '10 pts',
      'description': 'Standard brick that breaks in one hit.',
      'icon': Icons.square,
    },
    BrickType.hard: {
      'name': 'Hard',
      'color': Colors.purple.shade400,
      'points': '20 pts',
      'description': 'Tough brick that requires two hits to break.',
      'icon': Icons.crop_square_sharp,
    },
    BrickType.explosive: {
      'name': 'Explosive',
      'color': Colors.red.shade400,
      'points': '30 pts',
      'description': 'Explodes when hit, destroying nearby bricks!',
      'icon': Icons.flare,
    },
    BrickType.powerUp: {
      'name': 'Power-Up',
      'color': Colors.green.shade400,
      'points': '15 pts',
      'description': 'Contains special power-ups to help you!',
      'icon': Icons.stars,
    },
    BrickType.portal: {
      'name': 'Portal',
      'color': Colors.deepPurple.shade400,
      'points': '25 pts',
      'description': 'Teleports the ball to random location!',
      'icon': Icons.swap_calls,
    },
  };

  // Power-up information
  final Map<PowerUpType, Map<String, dynamic>> _powerUpInfo = {
    PowerUpType.extraLife: {
      'name': 'Extra Life',
      'color': Colors.red,
      'icon': '♥',
      'description': 'Gives you an additional life',
    },
    PowerUpType.expandPaddle: {
      'name': 'Expand Paddle',
      'color': Colors.green,
      'icon': '↔',
      'description': 'Makes your paddle 50% wider for 10 seconds',
    },
    PowerUpType.shrinkPaddle: {
      'name': 'Shrink Paddle',
      'color': Colors.orange,
      'icon': '↕',
      'description': 'Shrinks your paddle, making it harder to play',
    },
    PowerUpType.slowBall: {
      'name': 'Slow Ball',
      'color': Colors.blue,
      'icon': '⏱',
      'description': 'Slows down the ball for 10 seconds',
    },
    PowerUpType.fastBall: {
      'name': 'Fast Ball',
      'color': Colors.purple,
      'icon': '⚡',
      'description': 'Speeds up the ball, increasing difficulty',
    },
    PowerUpType.multiball: {
      'name': 'Multi Ball',
      'color': Colors.yellow,
      'icon': '✧',
      'description': 'Adds two additional balls to the game',
    },
  };

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

    // Initialize tab controller
    _tabController = TabController(length: 2, vsync: this);

    // Schedule a post-frame callback to get the game area position
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateGameAreaPosition();
    });
  }

  void _updateGameAreaPosition() {
    final RenderBox? renderBox =
        _gameAreaKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      setState(() {
        _gameAreaPosition = renderBox.localToGlobal(Offset.zero);
        _gameAreaSize = renderBox.size;
      });
    }
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
    _tabController.dispose();
    super.dispose();
  }

  void _handleKeyEvent(KeyEvent event) {
    if (event is! KeyDownEvent) return;

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
        // Restart the game regardless of game state
        game.restart();
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

  // Add mobile detection helper
  bool _isMobileDevice() {
    // Check if using mobile device based on platform
    return Theme.of(context).platform == TargetPlatform.iOS ||
        Theme.of(context).platform == TargetPlatform.android;
  }

  void _handleMouseMove(PointerEvent event) {
    if (game.gameState != GameState.playing || _isPaused) return;

    // Calculate the relative position within the game area
    if (_gameAreaSize.width > 0) {
      final localX = event.position.dx - _gameAreaPosition.dx;

      // Calculate the paddle center position (paddle width / 2)
      final paddleHalfWidth = game.paddle.width / 2;

      // Convert the cursor position to the game coordinate system
      final gameX = (localX / _gameAreaSize.width) * game.screenWidth;

      // Ensure the paddle stays within bounds
      final targetX = gameX - paddleHalfWidth;
      game.movePaddle(targetX);
    }
  }

  // Separate handler for touch drag
  void _handleTouchDragUpdate(DragUpdateDetails details) {
    if (game.gameState != GameState.playing || _isPaused) return;

    // Only update paddle position for horizontal movement
    double dx = details.delta.dx;

    // Move paddle based on the drag delta
    game.movePaddle(game.paddle.position.x +
        (dx * 1.5)); // Multiply by factor for better responsiveness
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    final isPortrait = screenSize.height > screenSize.width;
    final isMobile = _isMobileDevice() || screenSize.width < 600;

    // Calculate game board size based on screen dimensions
    final gameWidth =
        isPortrait ? screenSize.width * 0.95 : screenSize.width * 0.7;
    final gameHeight =
        isPortrait ? screenSize.height * 0.7 : screenSize.height * 0.8;

    // Update game dimensions if they changed
    game.resize(gameWidth, gameHeight);

    // Schedule the next frame to update game area position
    // This is needed for smoother tracking when scrolling or screen resizing
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateGameAreaPosition();
    });

    return Scaffold(
      appBar: const TopNavBar(title: 'Brick Breaker'),
      body: KeyboardListener(
        focusNode: _focusNode,
        onKeyEvent: _handleKeyEvent,
        child: GestureDetector(
          onTap: () => _focusNode.requestFocus(),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration:
                const BoxDecoration(gradient: AppGradients.cyberHorizon),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Game Status Section with glass effect
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: isMobile ? AppSpacing.sm : AppSpacing.md,
                          vertical: isMobile ? AppSpacing.sm : AppSpacing.md),
                      padding: EdgeInsets.all(
                          isMobile ? AppSpacing.sm : AppSpacing.md),
                      decoration: BoxDecoration(
                        color: AppColors.techNavy.withOpacity(0.15),
                        borderRadius: AppBorders.roundedMedium,
                        border: Border.all(
                          color: AppColors.neonAqua.withOpacity(0.2),
                          width: 1.5,
                        ),
                        boxShadow: AppShadows.neonGlow,
                      ),
                      child: Column(
                        children: [
                          // Score and Lives
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildInfoCard(
                                  context,
                                  title: 'Score',
                                  stream: game.scoreStream,
                                  initialValue: game.score,
                                  color: Colors.blue.shade300,
                                  icon: Icons.score,
                                ),
                                Gap(isMobile ? 8 : 16),
                                _buildInfoCard(
                                  context,
                                  title: 'High Score',
                                  value: BrickBreakerGame.highScore,
                                  color: Colors.purple.shade300,
                                  icon: Icons.emoji_events,
                                ),
                                Gap(isMobile ? 8 : 16),
                                _buildInfoCard(
                                  context,
                                  title: 'Lives',
                                  stream: game.livesStream,
                                  initialValue: game.lives,
                                  color: Colors.red.shade300,
                                  icon: Icons.favorite,
                                ),
                              ],
                            ),
                          ),

                          const Gap(16),

                          // Game Info Tabs
                          DefaultTabController(
                            length: 2,
                            child: Column(
                              children: [
                                TabBar(
                                  tabs: [
                                    Tab(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.grid_view,
                                              size: isMobile ? 16 : 18),
                                          Gap(isMobile ? 4 : 8),
                                          Text(
                                            'Brick Types',
                                            style: TextStyle(
                                                fontSize: isMobile ? 12 : 14),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Tab(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.stars,
                                              size: isMobile ? 16 : 18),
                                          Gap(isMobile ? 4 : 8),
                                          Text(
                                            'Power-Ups',
                                            style: TextStyle(
                                                fontSize: isMobile ? 12 : 14),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                  indicatorColor: Colors.white,
                                  labelColor: Colors.white,
                                  unselectedLabelColor:
                                      Colors.white.withOpacity(0.5),
                                ),
                                const Gap(16),
                                SizedBox(
                                  height: isMobile ? 120 : 100,
                                  child: TabBarView(
                                    children: [
                                      // Brick Types View with drag scrolling
                                      GestureDetector(
                                        onHorizontalDragUpdate: (details) {
                                          // Find the nearest ScrollController
                                          final ScrollController controller =
                                              PrimaryScrollController.of(
                                                  context);
                                          if (controller
                                                  .position.maxScrollExtent >
                                              0) {
                                            controller.position.moveTo(
                                              controller.offset -
                                                  details.delta.dx,
                                              curve: Curves.linear,
                                              duration: Duration.zero,
                                            );
                                          }
                                        },
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          physics:
                                              const BouncingScrollPhysics(),
                                          itemCount: BrickType.values.length,
                                          itemBuilder: (context, index) {
                                            final type =
                                                BrickType.values[index];
                                            return Container(
                                              width: isMobile ? 180 : 230,
                                              margin: EdgeInsets.only(
                                                left: index == 0 ? 0 : 8,
                                                right: index ==
                                                        BrickType
                                                                .values.length -
                                                            1
                                                    ? 0
                                                    : 8,
                                              ),
                                              child: _buildBrickLegendItem(
                                                  type, theme),
                                            );
                                          },
                                        ),
                                      ),
                                      // Power-ups View with drag scrolling
                                      GestureDetector(
                                        onHorizontalDragUpdate: (details) {
                                          final ScrollController? controller =
                                              PrimaryScrollController.of(
                                                  context);
                                          if (controller != null &&
                                              controller.position
                                                      .maxScrollExtent >
                                                  0) {
                                            controller.position.moveTo(
                                              controller.offset -
                                                  details.delta.dx,
                                              curve: Curves.linear,
                                              duration: Duration.zero,
                                            );
                                          }
                                        },
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          physics:
                                              const BouncingScrollPhysics(),
                                          itemCount: PowerUpType.values.length,
                                          itemBuilder: (context, index) {
                                            final type =
                                                PowerUpType.values[index];
                                            return Container(
                                              width: isMobile ? 140 : 180,
                                              margin: EdgeInsets.only(
                                                left: index == 0 ? 0 : 8,
                                                right: index ==
                                                        PowerUpType
                                                                .values.length -
                                                            1
                                                    ? 0
                                                    : 8,
                                              ),
                                              child: _buildPowerUpItem(
                                                  type, theme),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Game Board
                    // Use different control methods based on platform
                    isMobile
                        ? GestureDetector(
                            onHorizontalDragUpdate: _handleTouchDragUpdate,
                            child: _buildGameBoard(
                                gameWidth, gameHeight, isMobile, theme),
                          )
                        : MouseRegion(
                            onHover: _handleMouseMove,
                            child: _buildGameBoard(
                                gameWidth, gameHeight, isMobile, theme),
                          ),

                    // Game Controls Panel
                    Container(
                      margin: EdgeInsets.all(isMobile ? 12 : 20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: -5,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(isMobile ? 12 : 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Game Controls
                                Container(
                                  padding: EdgeInsets.all(isMobile ? 12 : 16),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                        color: Colors.blue.withOpacity(0.2)),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.sports_esports,
                                              color: Colors.blue.shade300),
                                          const Gap(8),
                                          Text(
                                            'Controls',
                                            style: theme.textTheme.titleMedium
                                                ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Gap(16),
                                      // Controls Grid
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          _ControlItem(
                                            icon: Icons.keyboard_arrow_left,
                                            label: 'A / Left',
                                            onPressed: () => _movePaddle(-1),
                                            color: Colors.blue.shade300,
                                          ),
                                          _ControlItem(
                                            icon: Icons.keyboard_arrow_right,
                                            label: 'D / Right',
                                            onPressed: () => _movePaddle(1),
                                            color: Colors.blue.shade300,
                                          ),
                                          _ControlItem(
                                            icon: Icons.space_bar,
                                            label: 'Space',
                                            onPressed: _togglePause,
                                            tooltip: 'Pause/Resume',
                                            color: Colors.amber,
                                          ),
                                          _ControlItem(
                                            icon: Icons.refresh,
                                            label: 'R',
                                            onPressed: game.restart,
                                            tooltip: 'Restart Game',
                                            color: Colors.green,
                                          ),
                                        ],
                                      ),
                                      const Gap(12),
                                      Text(
                                        isMobile
                                            ? 'Touch and drag to move the paddle'
                                            : 'Mouse cursor automatically moves the paddle',
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
                                          color: Colors.white70,
                                          fontStyle: FontStyle.italic,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),

                                const Gap(16),

                                // Speed Control
                                Container(
                                  padding: EdgeInsets.all(
                                      isMobile ? AppSpacing.sm : AppSpacing.md),
                                  decoration: BoxDecoration(
                                    color: AppColors.techNavy.withOpacity(0.1),
                                    borderRadius: AppBorders.roundedMedium,
                                    border: Border.all(
                                      color: AppColors.cyborgPurple
                                          .withOpacity(0.2),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.speed,
                                              color: Colors.purple.shade300),
                                          const Gap(8),
                                          Text(
                                            'Game Speed',
                                            style: theme.textTheme.titleMedium
                                                ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Gap(12),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          _buildSpeedButton(
                                            label: 'Casual',
                                            icon: Icons.directions_walk,
                                            speed: 1.0,
                                            description:
                                                'Standard gameplay speed',
                                            isSelected:
                                                game.speedMultiplier <= 1.0,
                                          ),
                                          _buildSpeedButton(
                                            label: 'Fast',
                                            icon: Icons.directions_run,
                                            speed: 1.5,
                                            description: 'High-paced action',
                                            isSelected:
                                                game.speedMultiplier > 1.0 &&
                                                    game.speedMultiplier < 1.8,
                                          ),
                                          _buildSpeedButton(
                                            label: 'Lightning',
                                            icon: Icons.flash_on,
                                            speed: 2.0,
                                            description: 'Super fast challenge',
                                            isSelected:
                                                game.speedMultiplier >= 1.8,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                const Gap(16),

                                // Difficulty Selection
                                Container(
                                  padding: EdgeInsets.all(isMobile ? 12 : 16),
                                  decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                        color: Colors.green.withOpacity(0.2)),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.bar_chart,
                                              color: Colors.green.shade300),
                                          const Gap(8),
                                          Text(
                                            'Difficulty Level',
                                            style: theme.textTheme.titleMedium
                                                ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Gap(16),
                                      ToggleButtons(
                                        constraints: BoxConstraints(
                                          minWidth: isMobile ? 70 : 90,
                                          minHeight: 40,
                                        ),
                                        isSelected: [
                                          game.difficultyLevel ==
                                              DifficultyLevel.easy,
                                          game.difficultyLevel ==
                                              DifficultyLevel.medium,
                                          game.difficultyLevel ==
                                              DifficultyLevel.hard,
                                        ],
                                        onPressed: (index) {
                                          game.setDifficultyLevel(
                                              DifficultyLevel.values[index]);
                                        },
                                        borderRadius: BorderRadius.circular(12),
                                        selectedColor: Colors.black,
                                        fillColor: Colors.white,
                                        color: Colors.white,
                                        borderColor: Colors.white24,
                                        selectedBorderColor: Colors.white,
                                        children: const [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 12),
                                            child: Row(
                                              children: [
                                                Icon(Icons.sentiment_satisfied,
                                                    size: 16),
                                                Gap(6),
                                                Text('Easy'),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 12),
                                            child: Row(
                                              children: [
                                                Icon(Icons.sentiment_neutral,
                                                    size: 16),
                                                Gap(6),
                                                Text('Medium'),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 12),
                                            child: Row(
                                              children: [
                                                Icon(
                                                    Icons
                                                        .sentiment_very_dissatisfied,
                                                    size: 16),
                                                Gap(6),
                                                Text('Hard'),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                if (isMobile) ...[
                                  const Gap(16),
                                  // Power-ups section for mobile
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.amber.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                          color: Colors.amber.withOpacity(0.2)),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(Icons.stars,
                                                color: Colors.amber),
                                            const Gap(8),
                                            Text(
                                              'Power-Ups',
                                              style: theme.textTheme.titleMedium
                                                  ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Gap(12),
                                        SizedBox(
                                          height: 100,
                                          child: ListView(
                                            scrollDirection: Axis.horizontal,
                                            children: PowerUpType.values
                                                .map((type) => Container(
                                                      width: 140,
                                                      margin: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 8),
                                                      child: _buildPowerUpItem(
                                                          type, theme),
                                                    ))
                                                .toList(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ],
                            ),
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
      ),
    );
  }

  // New brick legend item with improved visual style
  Widget _buildBrickLegendItem(BrickType type, ThemeData theme) {
    final info = _brickInfo[type]!;
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: info['color'].withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: info['color'].withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Brick visual and points
          Row(
            children: [
              Container(
                width: 32,
                height: 20,
                decoration: BoxDecoration(
                  color: info['color'],
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: info['color'].withOpacity(0.5),
                      blurRadius: 4,
                      spreadRadius: 0,
                    ),
                  ],
                ),
              ),
              const Gap(8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: info['color'].withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  info['points'],
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const Gap(8),
          // Name and description
          Row(
            children: [
              Icon(info['icon'], color: info['color'], size: 16),
              const Gap(4),
              Expanded(
                child: Text(
                  info['name'],
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const Gap(4),
          Expanded(
            child: Text(
              info['description'],
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.white70,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // New power-up item with card style
  Widget _buildPowerUpItem(PowerUpType type, ThemeData theme) {
    final info = _powerUpInfo[type]!;
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: info['color'].withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: info['color'].withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: info['color'],
            radius: 16,
            child: Text(
              info['icon'],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Gap(4),
          Text(
            info['name'],
            style: theme.textTheme.bodySmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
          const Gap(2),
          Expanded(
            child: Text(
              info['description'],
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.white70,
                fontSize: 10,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required String title,
    Stream<int>? stream,
    int? value,
    required Color color,
    int? initialValue,
    IconData? icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, color: Colors.white, size: 18),
                const Gap(6),
              ],
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          const Gap(4),
          if (stream != null)
            StreamBuilder<int>(
              stream: stream,
              initialData: initialValue,
              builder: (context, snapshot) {
                return Text(
                  '${snapshot.data ?? 0}',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                );
              },
            )
          else
            Text(
              '$value',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
            ),
        ],
      ),
    );
  }

  Widget _buildGameBoard(
      double gameWidth, double gameHeight, bool isMobile, ThemeData theme) {
    return Container(
      key: _gameAreaKey,
      width: gameWidth,
      height: gameHeight,
      decoration: BoxDecoration(
        color: AppColors.nightShade,
        borderRadius: AppBorders.roundedMedium,
        border: Border.all(
          color: AppColors.neonAqua.withOpacity(0.5),
          width: 2,
        ),
        boxShadow: AppShadows.neonGlow,
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
                        Icons.pause_circle_outlined,
                        size: isMobile ? 64 : 80,
                        color: Colors.white,
                      ),
                      const Gap(16),
                      Text(
                        'PAUSED',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Gap(24),
                      ElevatedButton.icon(
                        onPressed: _togglePause,
                        icon: const Icon(Icons.play_arrow),
                        label: const Text('Resume'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.withOpacity(0.6),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            horizontal: isMobile ? 16 : 24,
                            vertical: isMobile ? 8 : 12,
                          ),
                        ),
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
                            size: isMobile ? 64 : 80,
                            color: gameState == GameState.win
                                ? Colors.amber
                                : Colors.red,
                          ),
                          const Gap(16),
                          Text(
                            gameState == GameState.win
                                ? 'YOU WIN!'
                                : 'GAME OVER',
                            style: theme.textTheme.headlineLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Gap(8),
                          Text(
                            'Score: ${game.score}',
                            style: theme.textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          const Gap(24),
                          ElevatedButton.icon(
                            onPressed: game.restart,
                            icon: const Icon(Icons.refresh),
                            label: const Text('Play Again'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: gameState == GameState.win
                                  ? Colors.amber.withOpacity(0.7)
                                  : Colors.blue.withOpacity(0.6),
                              foregroundColor: gameState == GameState.win
                                  ? Colors.black
                                  : Colors.white,
                              padding: EdgeInsets.symmetric(
                                horizontal: isMobile ? 16 : 24,
                                vertical: isMobile ? 8 : 12,
                              ),
                            ),
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
    );
  }

  Widget _buildSpeedButton({
    required String label,
    required IconData icon,
    required double speed,
    required String description,
    required bool isSelected,
  }) {
    return Tooltip(
      message: description,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 56,
                height: 56,
                margin: const EdgeInsets.only(bottom: 4),
                child: ElevatedButton(
                  onPressed: () => setState(() {
                    // Apply speed with smooth transition
                    game.speedMultiplier = speed;
                  }),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    backgroundColor: isSelected
                        ? Colors.purple.shade400
                        : Colors.purple.withOpacity(0.2),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: isSelected
                            ? Colors.purple.shade300
                            : Colors.purple.withOpacity(0.3),
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    shadowColor: Colors.black.withOpacity(0.3),
                    elevation: isSelected ? 4 : 2,
                  ),
                  child: Icon(
                    icon,
                    size: 28,
                    color: isSelected
                        ? Colors.white
                        : Colors.white.withOpacity(0.7),
                  ),
                ),
              ),
              if (isSelected)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.purple.shade300,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      size: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.white70,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          if (isSelected)
            Container(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.purple.shade300,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${speed}x',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
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
  final String? tooltip;
  final Color color;

  const _ControlItem({
    required this.icon,
    required this.label,
    this.onPressed,
    this.tooltip,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = MediaQuery.of(context).size.width < 600;

    final button = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: isMobile ? 48 : 56,
          height: isMobile ? 48 : 56,
          margin: const EdgeInsets.only(bottom: 4),
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              backgroundColor: color.withOpacity(0.2),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: color.withOpacity(0.3)),
              ),
              shadowColor: Colors.black.withOpacity(0.3),
              elevation: 3,
            ),
            child: Icon(icon, size: isMobile ? 24 : 28),
          ),
        ),
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: Colors.white,
          ),
        ),
      ],
    );

    if (tooltip != null) {
      return Tooltip(
        message: tooltip!,
        child: button,
      );
    }

    return button;
  }
}

class BrickBreakerPainter extends CustomPainter {
  final BrickBreakerGame game;
  final Paint _brickPaint = Paint();
  final Paint _paddlePaint = Paint()..color = Colors.blue;
  final Paint _ballPaint = Paint()..color = Colors.white;
  final Paint _particlePaint = Paint();

  BrickBreakerPainter({required this.game});

  @override
  void paint(Canvas canvas, Size size) {
    // Draw bricks
    for (final brick in game.bricks) {
      // Set brick color based on type
      switch (brick.type) {
        case BrickType.normal:
          _brickPaint.color = AppColors.neonBlue;
          break;
        case BrickType.hard:
          _brickPaint.color = AppColors.cyberpunkPurple;
          break;
        case BrickType.explosive:
          _brickPaint.color = AppColors.errorRed;
          break;
        case BrickType.powerUp:
          _brickPaint.color = AppColors.successGreen;
          break;
        case BrickType.portal:
          _brickPaint.color = AppColors.syntheticIndigo;
          break;
      }

      // Add gradient effect based on brick type
      if (brick.type == BrickType.hard && brick.hitPoints > 1) {
        _brickPaint.shader = const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.cyberpunkPurple,
            AppColors.cyborgPurple,
          ],
        ).createShader(Rect.fromLTWH(
          brick.position.x,
          brick.position.y,
          brick.width,
          brick.height,
        ));
      } else if (brick.type == BrickType.portal) {
        _brickPaint.shader = const RadialGradient(
          center: Alignment.center,
          radius: 0.8,
          colors: [
            AppColors.syntheticIndigo,
            AppColors.cyborgPurple,
            AppColors.cyberpunkPurple,
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

      // Draw the brick
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

      // Draw portal symbol if it's a portal brick
      if (brick.type == BrickType.portal) {
        final iconPainter = TextPainter(
          text: const TextSpan(
            text: '⟿', // Portal symbol
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center,
        );

        iconPainter.layout(minWidth: 0, maxWidth: brick.width);

        // Center the icon in the brick
        final xCenter =
            brick.position.x + brick.width / 2 - iconPainter.width / 2;
        final yCenter =
            brick.position.y + brick.height / 2 - iconPainter.height / 2;

        // Draw the icon
        iconPainter.paint(canvas, Offset(xCenter, yCenter));
      }
    }

    // Draw paddle with gradient
    final paddleGradient = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [AppColors.neonAqua, AppColors.neonBlue],
    ).createShader(Rect.fromLTWH(
      game.paddle.position.x,
      game.paddle.position.y,
      game.paddle.width,
      game.paddle.height,
    ));
    _paddlePaint.shader = paddleGradient;

    // Draw paddle with neon glow effect
    final glowPaint = Paint()
      ..color = AppColors.neonAqua.withOpacity(0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 3);

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
      glowPaint,
    );

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

    // Draw explosion particles
    for (final particle in game.particles) {
      // Calculate opacity based on remaining lifespan
      final opacity =
          (particle.lifespan / particle.maxLifespan).clamp(0.0, 1.0);

      _particlePaint.color = particle.color.withOpacity(opacity);

      // Draw with slight glow effect
      if (opacity > 0.5) {
        final glowPaint = Paint()
          ..color = particle.color.withOpacity(opacity * 0.3)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);

        canvas.drawCircle(
          Offset(particle.position.x, particle.position.y),
          particle.size * 1.5,
          glowPaint,
        );
      }

      // Draw the actual particle
      canvas.drawCircle(
        Offset(particle.position.x, particle.position.y),
        particle.size,
        _particlePaint,
      );
    }

    // Draw balls with glow effect
    for (final ball in game.balls) {
      // Draw outer glow
      final ballGlowPaint = Paint()
        ..color = AppColors.neonAqua.withOpacity(0.3)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

      canvas.drawCircle(
        Offset(
          ball.position.x + ball.radius,
          ball.position.y + ball.radius,
        ),
        ball.radius * 1.5,
        ballGlowPaint,
      );

      // Draw ball with gradient
      final ballGradient = const RadialGradient(
        center: Alignment.topLeft,
        radius: 1.2,
        colors: [AppColors.hologramWhite, AppColors.neonAqua],
      ).createShader(Rect.fromCircle(
        center: Offset(
          ball.position.x + ball.radius,
          ball.position.y + ball.radius,
        ),
        radius: ball.radius,
      ));

      _ballPaint.shader = ballGradient;

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

      // Draw power-up icon with proper centering
      final iconPainter = TextPainter(
        text: TextSpan(
          text: _getPowerUpIcon(powerUp.type),
          style: TextStyle(
            color: AppColors.hologramWhite,
            fontSize: powerUp.radius * 1.2,
            height: 1,
          ),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      );

      // Layout the text
      iconPainter.layout(minWidth: 0, maxWidth: powerUp.radius * 2);

      // Calculate center position for the icon
      final xCenter =
          powerUp.position.x + powerUp.radius - (iconPainter.width / 2);
      final yCenter =
          powerUp.position.y + powerUp.radius - (iconPainter.height / 2);

      // Draw at centered position
      iconPainter.paint(canvas, Offset(xCenter, yCenter));
    }
  }

  Color _getPowerUpColor(PowerUpType type) {
    switch (type) {
      case PowerUpType.extraLife:
        return AppColors.errorRed;
      case PowerUpType.expandPaddle:
        return AppColors.successGreen;
      case PowerUpType.shrinkPaddle:
        return AppColors.laserAmber;
      case PowerUpType.slowBall:
        return AppColors.neonBlue;
      case PowerUpType.fastBall:
        return AppColors.cyberpunkPurple;
      case PowerUpType.multiball:
        return AppColors.syntheticIndigo;
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
