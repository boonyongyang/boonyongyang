import '../quick_config.dart';

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
            'Led end-to-end mobile development for two production applications from architecture to App Store deployment. '
            'Owned complete technical architecture, implemented robust CI/CD pipelines, and delivered scalable Flutter solutions.',
        keyImplementations: [
          'Architected and built ${QuickConfig.mainAppName} from 0 to ${QuickConfig.currentMetrics['totalDownloads']} downloads',
          'Designed clean architecture with BLoC pattern for scalable codebase',
          'Implemented CI/CD pipeline with automated testing and deployment',
          'Built comprehensive affiliate marketing system with real-time analytics',
          'Integrated Firebase suite for analytics, crashlytics, and notifications',
          'Delivered Cha Ching cashback platform with payment gateway integration',
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
          'Zero critical production bugs in 18+ months',
          'Reduced app crash rate to <0.1%',
          'Improved app performance by 40%',
        ],
      );
}
