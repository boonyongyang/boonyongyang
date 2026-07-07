import 'personal_info_model.dart';
import 'work_experience_model.dart';
import 'feature_model.dart';
import 'social_link_model.dart';
import 'project_model.dart';
import 'technical_skills_model.dart';

/// Centralized data provider for landing page content.
class LandingPageDataProvider {
  // Personal Information
  static PersonalInfoModel get personalInfo => PersonalInfoModel.current;

  // Work Experience
  static WorkExperienceModel get workExperience => WorkExperienceModel.current;

  // Technical Features
  static List<FeatureModel> get features => FeatureModel.getAllFeatures();

  // Production Apps
  static List<ProjectModel> get productionApps =>
      ProjectModel.getProductionApps();

  // Personal Projects
  static List<ProjectModel> get personalProjects =>
      ProjectModel.getPersonalProjects();

  // Social Links
  static List<SocialLinkModel> get socialLinks =>
      SocialLinkModel.getAllSocialLinks();

  // Technical Skills
  static List<SkillCategoryModel> get technicalSkills =>
      SkillCategoryModel.getAllSkillCategories();

  // Featured Technologies
  static List<TechnicalSkillModel> get featuredTechnologies =>
      SkillCategoryModel.getFeaturedTechnologies();

  // Footer Information
  static FooterInfoModel get footerInfo => FooterInfoModel.current;

  // Section Titles and Metadata
  static const Map<String, String> sectionTitles = {
    'hero': 'Introduction',
    'workExperience': 'Current Work',
    'productionApps': 'Selected Work',
    'personalProjects': 'Project Index',
    'features': 'Capabilities',
    'footer': 'Contact',
  };

  static const Map<String, String> sectionSubtitles = {
    'features':
        'Grouped by how the work gets shipped: UI, architecture, integrations, release systems, and workflow.',
    'productionApps':
        'Production apps with release pressure, product constraints, and real usage.',
    'personalProjects':
        'Compact references for architecture patterns and app experiments.',
  };

  // App Configuration
  static const Map<String, dynamic> appConfig = {
    'appName': 'Boon Yong Yang Portfolio',
    'version': '1.0.0',
    'lastUpdated': '2026-05-09',
    'builtWith': 'Flutter',
  };

  // Quick access methods for easy updates
  static String get fullName => personalInfo.name;
  static String get jobTitle => personalInfo.title;
  static String get email => personalInfo.email;
  static String get currentStatus => personalInfo.status;
  static String get currentCompany => workExperience.company;
  static String get currentRole => workExperience.jobTitle;
}
