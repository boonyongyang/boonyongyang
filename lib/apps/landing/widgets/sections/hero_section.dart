import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../services/url_launcher_service.dart';
import '../../utils/responsive_utils.dart';
import '../../models/landing_page_data_provider.dart';
import '../../utils/landing_page_utils.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    // Start pulsing animation
    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = ResponsiveUtils.isMobile(context);
    final personalInfo = LandingPageDataProvider.personalInfo;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.getHorizontalPadding(context),
        vertical: ResponsiveUtils.getVerticalPadding(context),
      ),
      constraints: const BoxConstraints(minHeight: 500),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Enhanced avatar with professional styling
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.primary.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: isMobile ? 60 : 80,
              backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
              child: Icon(
                Icons.person,
                size: isMobile ? 60 : 80,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
          const Gap(32),

          // Name with enhanced typography
          Text(
            personalInfo.name,
            style: theme.textTheme.displayMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: isMobile ? 32 : null,
            ),
            textAlign: TextAlign.center,
          ),
          const Gap(8),

          // Professional title with status indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: LandingPageUtils.getStatusColor(personalInfo.status),
                  shape: BoxShape.circle,
                ),
              ),
              const Gap(8),
              Text(
                personalInfo.subtitle,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: LandingPageUtils.getStatusColor(personalInfo.status),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Gap(16),

          Text(
            personalInfo.title,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
              fontSize: isMobile ? 18 : null,
            ),
            textAlign: TextAlign.center,
          ),
          const Gap(24),

          // Key achievements banner
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.primary.withOpacity(0.1),
                  theme.colorScheme.secondary.withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: theme.colorScheme.primary.withOpacity(0.2),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.verified,
                  size: 20,
                  color: theme.colorScheme.primary,
                ),
                const Gap(8),
                Text(
                  personalInfo.achievementBanner,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const Gap(32),

          // Enhanced description with better formatting
          Container(
            constraints: BoxConstraints(
              maxWidth: ResponsiveUtils.getMaxContentWidth(context),
            ),
            child: Text(
              personalInfo.description,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.8),
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const Gap(48),

          // Enhanced action buttons
          Wrap(
            spacing: isMobile ? 12 : 16,
            runSpacing: isMobile ? 12 : 16,
            alignment: WrapAlignment.center,
            children: [
              // Primary CTA with pulse animation
              AnimatedBuilder(
                animation: _pulseAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _pulseAnimation.value,
                    child: ElevatedButton.icon(
                      onPressed: () => UrlLauncherService.launchApp(context),
                      icon: Icon(Icons.launch, size: isMobile ? 20 : 24),
                      label: Text(isMobile ? 'Launch App' : 'Launch Live App'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor: theme.colorScheme.onPrimary,
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 24 : 32,
                          vertical: isMobile ? 12 : 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  );
                },
              ),
              OutlinedButton.icon(
                onPressed: UrlLauncherService.launchGitHub,
                icon: Icon(Icons.code, size: isMobile ? 20 : 24),
                label: Text(isMobile ? 'GitHub' : 'View GitHub'),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 24 : 32,
                    vertical: isMobile ? 12 : 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: UrlLauncherService.launchEmail,
                icon: Icon(Icons.email, size: isMobile ? 20 : 24),
                label: Text(isMobile ? 'Resume' : 'Get Resume'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.secondary,
                  foregroundColor: theme.colorScheme.onSecondary,
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 24 : 32,
                    vertical: isMobile ? 12 : 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
