import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/color_palette.dart';
import '../../core/constants/animation_constants.dart';
import 'portfolio_version_menu.dart';

class TopNavBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  const TopNavBar({super.key, required this.title});

  @override
  State<TopNavBar> createState() => _TopNavBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _TopNavBarState extends State<TopNavBar> {
  final _navItems = [
    (icon: Icons.home, path: '/', label: 'Home'),
    (icon: Icons.map, path: '/maps', label: 'Maps'),
    (icon: Icons.show_chart, path: '/charts', label: 'Charts'),
    (icon: Icons.science, path: '/labs', label: 'Labs'),
    (icon: Icons.games, path: '/plays', label: 'Games'),
    (icon: Icons.info, path: '/about', label: 'About'),
  ];

  bool _isMobile = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _isMobile = MediaQuery.of(context).size.width < 768;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentLocation = GoRouterState.of(context).uri.path;

    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withOpacity(0.05),
          ),
        ),
      ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ColorFilter.mode(
            Colors.white.withOpacity(0.01),
            BlendMode.plus,
          ),
          child: AppBar(
            title: ShaderMask(
              shaderCallback: (bounds) =>
                  ColorPalette.titleGradient.createShader(bounds),
              child: Text(
                widget.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              if (!_isMobile) ...[
                const Spacer(),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: theme.dividerColor.withOpacity(0.05),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: _navItems.map((item) {
                      final isActive = currentLocation == item.path ||
                          (item.path != '/' &&
                              currentLocation.startsWith(item.path));
                      return _NavButton(
                        icon: item.icon,
                        label: item.label,
                        isActive: isActive,
                        onPressed: () => context.go(item.path),
                      );
                    }).toList(),
                  ),
                ),
                const Gap(8),
                PortfolioVersionMenu(
                  currentSurface: PortfolioSurface.flutterInteractive,
                  compact: true,
                  foregroundColor: theme.iconTheme.color,
                  borderColor: theme.dividerColor.withOpacity(0.12),
                  backgroundColor: theme.colorScheme.surface.withOpacity(0.05),
                ),
                const Gap(12),
              ] else ...[
                PortfolioVersionMenu(
                  currentSurface: PortfolioSurface.flutterInteractive,
                  compact: true,
                  foregroundColor: theme.iconTheme.color,
                ),
                Theme(
                  data: theme.copyWith(
                    popupMenuTheme: const PopupMenuThemeData(
                      color: ColorPalette.darkSurface,
                      surfaceTintColor: Colors.transparent,
                    ),
                  ),
                  child: PopupMenuButton<String>(
                    icon: const Icon(Icons.menu),
                    position: PopupMenuPosition.under,
                    offset: const Offset(0, 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: Colors.white.withOpacity(0.05),
                      ),
                    ),
                    onSelected: (path) => context.go(path),
                    itemBuilder: (context) => _navItems
                        .map(
                          (item) => PopupMenuItem(
                            value: item.path,
                            child: Row(
                              children: [
                                Icon(
                                  item.icon,
                                  color: currentLocation == item.path
                                      ? theme.primaryColor
                                      : null,
                                ),
                                const Gap(12),
                                Text(
                                  item.label,
                                  style: TextStyle(
                                    color: currentLocation == item.path
                                        ? theme.primaryColor
                                        : null,
                                    fontWeight: currentLocation == item.path
                                        ? FontWeight.bold
                                        : null,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _NavButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onPressed;

  const _NavButton({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onPressed,
  });

  @override
  State<_NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<_NavButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: widget.onPressed,
          child: AnimatedContainer(
            duration: AnimationConstants.shortDuration,
            curve: AnimationConstants.softEasing,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: widget.isActive
                  ? theme.colorScheme.primaryContainer.withOpacity(0.15)
                  : _isHovered
                      ? Colors.white.withOpacity(0.05)
                      : Colors.transparent,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  widget.icon,
                  color: widget.isActive
                      ? theme.colorScheme.primary
                      : theme.iconTheme.color?.withOpacity(
                          _isHovered ? 1 : 0.7,
                        ),
                  size: 20,
                ),
                const Gap(8),
                Text(
                  widget.label,
                  style: TextStyle(
                    color: widget.isActive
                        ? theme.colorScheme.primary
                        : theme.textTheme.bodyLarge?.color?.withOpacity(
                            _isHovered ? 1 : 0.7,
                          ),
                    fontWeight:
                        widget.isActive ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
