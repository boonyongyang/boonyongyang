import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../models/project_model.dart';
import '../../services/url_launcher_service.dart';

class ProjectCard extends StatefulWidget {
  final ProjectModel project;

  const ProjectCard({
    super.key,
    required this.project,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  late Animation<double> _elevationAnimation;
  late Animation<double> _scaleAnimation;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _elevationAnimation = Tween<double>(
      begin: 2.0,
      end: 8.0,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeInOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.02,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = _getColorFromName(widget.project.colorName);
    final icon = _getIconFromName(widget.project.iconName);
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return AnimatedBuilder(
      animation: _hoverController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: MouseRegion(
            onEnter: (_) {
              setState(() => _isHovering = true);
              _hoverController.forward();
            },
            onExit: (_) {
              setState(() => _isHovering = false);
              _hoverController.reverse();
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.2),
                    blurRadius: _elevationAnimation.value * 2,
                    offset: Offset(0, _elevationAnimation.value),
                  ),
                ],
              ),
              child: Card(
                elevation: 0,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(isMobile ? 16 : 24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        color.withOpacity(0.05),
                        color.withOpacity(0.02),
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header with icon and status
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(isMobile ? 10 : 12),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [color, color.withOpacity(0.8)],
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              icon,
                              color: Colors.white,
                              size: isMobile ? 20 : 24,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: isMobile ? 8 : 12,
                              vertical: isMobile ? 4 : 6,
                            ),
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: color.withOpacity(0.3)),
                            ),
                            child: Text(
                              widget.project.status,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: color,
                                fontWeight: FontWeight.bold,
                                fontSize: isMobile ? 11 : 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: isMobile ? 16 : 20),

                      // Title and subtitle
                      Text(
                        widget.project.title,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: color,
                          fontSize: isMobile ? 20 : 24,
                        ),
                      ),
                      const Gap(4),
                      Text(
                        widget.project.subtitle,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.7),
                          fontWeight: FontWeight.w500,
                          fontSize: isMobile ? 14 : 16,
                        ),
                      ),
                      SizedBox(height: isMobile ? 12 : 16),

                      // Description
                      Text(
                        widget.project.description,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.8),
                          height: 1.5,
                          fontSize: isMobile ? 13 : 14,
                        ),
                        maxLines: isMobile ? 3 : 4,
                      ),
                      SizedBox(height: isMobile ? 16 : 20),

                      // Key achievements (show first 3)
                      Text(
                        'Key Achievements',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: isMobile ? 14 : 16,
                        ),
                      ),
                      SizedBox(height: isMobile ? 6 : 8),
                      ...widget.project.achievements.take(3).map((achievement) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.check_circle,
                                size: 16,
                                color: color,
                              ),
                              const Gap(8),
                              Expanded(
                                child: Text(
                                  achievement,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.onSurface
                                        .withOpacity(0.9),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      const Gap(20),

                      // Technologies
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: widget.project.technologies.map((tech) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: color.withOpacity(0.3)),
                            ),
                            child: Text(
                              tech,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: color,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const Gap(20),

                      // Metrics
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: color.withOpacity(0.2)),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.analytics, color: color, size: 16),
                            const Gap(8),
                            Expanded(
                              child: Text(
                                widget.project.metrics,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: color,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(20),

                      // Action buttons
                      Row(
                        children: [
                          if (widget.project.githubUrl != null) ...[
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () =>
                                    UrlLauncherService.launchCustomUrl(
                                        widget.project.githubUrl!),
                                icon: const Icon(Icons.code, size: 16),
                                label: const Text('GitHub'),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: color,
                                  side: BorderSide(color: color),
                                ),
                              ),
                            ),
                            if (widget.project.liveUrl != null) const Gap(8),
                          ],
                          if (widget.project.liveUrl != null)
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () =>
                                    UrlLauncherService.launchCustomUrl(
                                        widget.project.liveUrl!),
                                icon: const Icon(Icons.launch, size: 16),
                                label: const Text('Live Demo'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: color,
                                  foregroundColor: Colors.white,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

Color _getColorFromName(String colorName) {
  switch (colorName.toLowerCase()) {
    case 'blue':
      return Colors.blue;
    case 'orange':
      return Colors.orange;
    case 'green':
      return Colors.green;
    case 'purple':
      return Colors.purple;
    case 'red':
      return Colors.red;
    default:
      return Colors.blue;
  }
}

IconData _getIconFromName(String iconName) {
  switch (iconName.toLowerCase()) {
    case 'trending_up':
      return Icons.trending_up;
    case 'shopping_bag':
      return Icons.shopping_bag;
    case 'account_balance_wallet':
      return Icons.account_balance_wallet;
    case 'architecture':
      return Icons.architecture;
    case 'phone_android':
      return Icons.phone_android;
    default:
      return Icons.apps;
  }
}
