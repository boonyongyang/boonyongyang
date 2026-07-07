import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../models/landing_page_data_provider.dart';
import '../../models/social_link_model.dart';
import '../../services/url_launcher_service.dart';
import '../../utils/responsive_utils.dart';
import '../components/landing_design_system.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({
    super.key,
    this.background,
  });

  final Color? background;

  @override
  Widget build(BuildContext context) {
    final tokens = context.landingTokens;
    final theme = Theme.of(context);
    final isMobile = ResponsiveUtils.isMobile(context);
    final footerInfo = LandingPageDataProvider.footerInfo;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: background ?? tokens.background,
        border: Border(top: BorderSide(color: tokens.border)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveUtils.getHorizontalPadding(context),
          vertical: isMobile ? 44 : 56,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: tokens.maxWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isMobile)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _footerChildren(context, footerInfo),
                  )
                else
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _footerCopy(context, footerInfo),
                        ),
                      ),
                      const Gap(24),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        alignment: WrapAlignment.end,
                        children: _footerActions(),
                      ),
                    ],
                  ),
                Gap(tokens.spaceXl),
                Divider(color: tokens.border),
                Gap(tokens.spaceMd),
                Text(
                  footerInfo.copyrightText,
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _footerChildren(
    BuildContext context,
    FooterInfoModel footerInfo,
  ) {
    return [
      ..._footerCopy(context, footerInfo),
      Gap(context.landingTokens.spaceLg),
      Wrap(spacing: 12, runSpacing: 12, children: _footerActions()),
    ];
  }

  List<Widget> _footerCopy(
    BuildContext context,
    FooterInfoModel footerInfo,
  ) {
    final theme = Theme.of(context);
    final tokens = context.landingTokens;
    return [
      Text(footerInfo.contactTitle, style: theme.textTheme.headlineSmall),
      Gap(tokens.spaceSm),
      ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560),
        child: Text(
          footerInfo.contactSubtitle,
          style: theme.textTheme.bodyLarge,
        ),
      ),
    ];
  }

  List<Widget> _footerActions() {
    return [
      const LandingButton(
        label: 'Email',
        icon: Icons.mail_outline,
        primary: true,
        onPressed: UrlLauncherService.launchEmail,
      ),
      const LandingButton(
        label: 'GitHub',
        icon: Icons.code,
        onPressed: UrlLauncherService.launchGitHub,
      ),
      const LandingButton(
        label: 'LinkedIn',
        icon: Icons.business_center_outlined,
        onPressed: UrlLauncherService.launchLinkedIn,
      ),
    ];
  }
}
