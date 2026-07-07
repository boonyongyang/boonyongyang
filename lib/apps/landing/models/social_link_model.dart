import '../config/quick_config.dart';

class SocialLinkModel {
  final String name;
  final String iconName;
  final String url;
  final String displayText;

  const SocialLinkModel({
    required this.name,
    required this.iconName,
    required this.url,
    required this.displayText,
  });

  static List<SocialLinkModel> getAllSocialLinks() {
    return [
      const SocialLinkModel(
        name: 'GitHub',
        iconName: 'code',
        url: QuickConfig.githubUrl,
        displayText: 'GitHub Profile',
      ),
      const SocialLinkModel(
        name: 'LinkedIn',
        iconName: 'work',
        url: QuickConfig.linkedinUrl,
        displayText: 'LinkedIn Profile',
      ),
      const SocialLinkModel(
        name: 'Email',
        iconName: 'email',
        url: 'mailto:${QuickConfig.email}',
        displayText: 'Contact via Email',
      ),
    ];
  }
}

class FooterInfoModel {
  final String copyrightText;
  final String contactTitle;
  final String contactSubtitle;
  final String launchAppText;

  const FooterInfoModel({
    required this.copyrightText,
    required this.contactTitle,
    required this.contactSubtitle,
    required this.launchAppText,
  });

  static FooterInfoModel get current => const FooterInfoModel(
        copyrightText:
            '© ${QuickConfig.copyrightYear} ${QuickConfig.fullName}. Built with Flutter.',
        contactTitle: 'Get in Touch',
        contactSubtitle: QuickConfig.contactSubtitle,
        launchAppText: 'Launch Live App',
      );
}
