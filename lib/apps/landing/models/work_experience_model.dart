import '../config/quick_config.dart';

class WorkExperienceModel {
  final String jobTitle;
  final String company;
  final String duration;
  final String companyIconName;
  final String description;
  final List<String> keyImplementations;
  final List<String> technologies;
  final List<String> achievements;

  const WorkExperienceModel({
    required this.jobTitle,
    required this.company,
    required this.duration,
    required this.companyIconName,
    required this.description,
    required this.keyImplementations,
    required this.technologies,
    required this.achievements,
  });

  static WorkExperienceModel get current => WorkExperienceModel(
        jobTitle: QuickConfig.currentPosition,
        company: QuickConfig.currentCompany,
        duration: QuickConfig.workDuration,
        companyIconName: 'phone_android',
        description:
            'Led mobile implementation across two shipped Flutter products, from architecture and CI/CD through store release and production iteration.',
        keyImplementations: [
          'Built ${QuickConfig.mainAppName} from first implementation to ${QuickConfig.currentMetrics['totalDownloads']} downloads',
          'Designed BLoC architecture around practical product delivery',
          'Implemented CI/CD, analytics, crash reporting, and release workflows',
          'Delivered affiliate and cashback flows with real user traffic',
        ],
        technologies: QuickConfig.primaryTechnologies.map((tech) {
          switch (tech) {
            case 'Flutter':
              return 'Flutter & Dart';
            case 'BLoC/Cubit':
              return 'BLoC/Cubit State Management';
            case 'Firebase':
              return 'Firebase Suite (Analytics, Crashlytics, etc.)';
            case 'Clean Architecture':
              return 'Clean Architecture & SOLID Principles';
            case 'CI/CD':
              return 'CI/CD with GitHub Actions';
            default:
              return tech;
          }
        }).toList()
          ..addAll([
            'REST API Integration',
            'App Store & Play Store Deployment',
          ]),
        achievements: [
          '${QuickConfig.currentMetrics['productionApps']} apps successfully launched to production',
          '${QuickConfig.currentMetrics['totalDownloads']} combined downloads across platforms',
          '${QuickConfig.currentMetrics['averageRating']} average rating on app stores',
          'Maintained production feedback loops across analytics and crash reporting',
          'Improved release confidence with automated checks and clearer ownership',
        ],
      );
}
