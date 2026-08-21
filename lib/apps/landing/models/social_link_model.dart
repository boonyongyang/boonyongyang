import '../config/quick_config.dart';

class FooterInfoModel {
  final String copyrightText;
  final String contactTitle;
  final String contactSubtitle;

  const FooterInfoModel({
    required this.copyrightText,
    required this.contactTitle,
    required this.contactSubtitle,
  });

  static FooterInfoModel get current => const FooterInfoModel(
        copyrightText:
            '© ${QuickConfig.copyrightYear} ${QuickConfig.fullName}. Built with Flutter.',
        contactTitle: 'Get in Touch',
        contactSubtitle: QuickConfig.contactSubtitle,
      );
}
