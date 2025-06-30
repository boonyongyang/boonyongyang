import 'personal_info_model.dart';
import 'work_experience_model.dart';
import 'feature_model.dart';
import 'social_link_model.dart';
import 'project_model.dart';
import 'technical_skills_model.dart';

/// Centralized data provider for all landing page content
/// This makes it extremely easy to update any information by changing it in one place
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
    'hero': 'Hero Section',
    'workExperience': 'Work Experience',
    'productionApps': 'Production Applications',
    'personalProjects': 'Passion Projects',
    'features': 'Technical Excellence',
    'footer': 'Contact & Social',
  };

  static const Map<String, String> sectionSubtitles = {
    'features':
        'Production-ready features and technical capabilities that power scalable applications',
    'productionApps':
        'Live applications serving real users in production environments',
    'personalProjects':
        'Open-source projects showcasing technical expertise and architectural patterns',
  };

  // App Configuration
  static const Map<String, dynamic> appConfig = {
    'appName': 'Boon Yong Yang Portfolio',
    'version': '1.0.0',
    'lastUpdated': '2025-06-27',
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
