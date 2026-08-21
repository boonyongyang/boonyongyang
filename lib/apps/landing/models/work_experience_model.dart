import '../config/quick_config.dart';

class WorkExperienceModel {
  final String jobTitle;
  final String company;
  final String duration;
  final String description;

  const WorkExperienceModel({
    required this.jobTitle,
    required this.company,
    required this.duration,
    required this.description,
  });

  static WorkExperienceModel get current => const WorkExperienceModel(
        jobTitle: QuickConfig.currentPosition,
        company: QuickConfig.currentCompany,
        duration: QuickConfig.workDuration,
        description:
            'Worked across two shipped Flutter products, from architecture and CI/CD through store release and production iteration.',
      );
}
