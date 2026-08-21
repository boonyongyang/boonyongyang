import '../config/quick_config.dart';

class PersonalInfoModel {
  final String name;
  final String title;
  final String subtitle;
  final String description;

  const PersonalInfoModel({
    required this.name,
    required this.title,
    required this.subtitle,
    required this.description,
  });

  static PersonalInfoModel get current => const PersonalInfoModel(
        name: QuickConfig.fullName,
        title: QuickConfig.currentRole,
        subtitle: QuickConfig.workStatus,
        description: QuickConfig.professionalSummary,
      );
}
