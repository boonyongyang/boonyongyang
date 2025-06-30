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
        url: 'https://github.com/boonyongyang',
        displayText: 'GitHub Profile',
      ),
      const SocialLinkModel(
        name: 'LinkedIn',
        iconName: 'work',
        url: 'https://www.linkedin.com/in/boon-yong-yang-64096b1aa/',
        displayText: 'LinkedIn Profile',
      ),
      const SocialLinkModel(
        name: 'Email',
        iconName: 'email',
        url: 'mailto:boonyongyang@gmail.com',
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
        copyrightText: '© 2025 Boon Yong Yang. Built with Flutter.',
        contactTitle: 'Get in Touch',
        contactSubtitle: 'Available for Flutter development opportunities',
        launchAppText: 'Launch Live App',
      );
}
