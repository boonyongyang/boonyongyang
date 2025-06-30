import '../quick_config.dart';

class PersonalInfoModel {
  final String name;
  final String title;
  final String subtitle;
  final String status;
  final String statusColor;
  final String description;
  final String achievementBanner;
  final String email;
  final String? avatarUrl;

  const PersonalInfoModel({
    required this.name,
    required this.title,
    required this.subtitle,
    required this.status,
    required this.statusColor,
    required this.description,
    required this.achievementBanner,
    required this.email,
    this.avatarUrl,
  });

  static PersonalInfoModel get current => PersonalInfoModel(
        name: QuickConfig.fullName,
        title: QuickConfig.currentRole,
        subtitle: QuickConfig.workStatus,
        status: QuickConfig.statusType,
        statusColor: _getStatusColor(QuickConfig.statusType),
        description: QuickConfig.professionalSummary,
        achievementBanner: QuickConfig.achievementBanner,
        email: QuickConfig.email,
        avatarUrl: null, // Can be added later
      );

  static String _getStatusColor(String status) {
    switch (status) {
      case 'available':
        return 'green';
      case 'busy':
        return 'orange';
      case 'unavailable':
        return 'red';
      default:
        return 'gray';
    }
  }
}
