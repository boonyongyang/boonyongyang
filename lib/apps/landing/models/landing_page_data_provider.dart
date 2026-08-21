import 'personal_info_model.dart';
import 'work_experience_model.dart';
import 'social_link_model.dart';

/// Small compatibility boundary for the three composed landing-page models.
class LandingPageDataProvider {
  static PersonalInfoModel get personalInfo => PersonalInfoModel.current;

  static WorkExperienceModel get workExperience => WorkExperienceModel.current;

  static FooterInfoModel get footerInfo => FooterInfoModel.current;
}
