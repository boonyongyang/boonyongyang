/// Quick Configuration File for Common Landing Page Updates
/// Edit this file for the most frequent content updates
///
/// 🎯 This is your GO-TO file for quick updates!

class QuickConfig {
  // 🚀 PERSONAL INFO - Update these for personal information changes
  static const String fullName = 'Boon Yong Yang';
  static const String currentRole = 'Mobile Engineer & Flutter Expert';
  static const String workStatus =
      'Available for Work'; // Available for Work, Currently Employed, etc.
  static const String statusType = 'available'; // available, busy, unavailable
  static const String email = 'boonyongyang@gmail.com';

  // 🏢 CURRENT JOB - Update these when changing jobs
  static const String currentCompany = 'IA';
  static const String currentPosition = 'Mobile Engineer (Flutter)';
  static const String workDuration =
      'June 2023 – Present (2 years and counting)'; // Update as needed

  // 📊 ACHIEVEMENTS - Update these for your latest achievements
  static const String achievementBanner =
      '2 Production Apps  |  4+ Years Flutter Experience';
  static const String professionalSummary =
      'Specialized in Flutter mobile development with 4+ years of Flutter experience and over 2+ years in delivering production apps.\n'
      'Experienced in architectural patterns, CI/CD pipelines, and performance optimization.\n'
      'Dedicated to writing clean code, building scalable solutions, and delivering exceptional user experiences.';

  // 🔗 SOCIAL LINKS - Update these for social media changes
  static const String githubUrl = 'https://github.com/boonyongyang';
  static const String linkedinUrl =
      'https://www.linkedin.com/in/boon-yong-yang-64096b1aa/';

  // 📱 APP LAUNCH - Update this for your main app showcase
  static const String mainAppName = 'Involve Asia Mobile App';
  static const String mainAppMetrics =
      '50K+ downloads • 4.2★ rating • 500+ brands';

  // 🎨 FOOTER - Update these for footer information
  static const String copyrightYear = '2025';
  static const String contactSubtitle =
      'Available for Flutter development opportunities';

  // ⚙️ TECHNICAL STACK - Update these when you learn new technologies
  static const List<String> primaryTechnologies = [
    'Flutter',
    'BLoC/Cubit',
    'Firebase',
    'Clean Architecture',
    'CI/CD',
  ];

  static const List<String> currentProjects = [
    'Involve Asia Mobile App',
    'Cha Ching - Shop & Get Cashback',
  ];

  // 📈 CURRENT METRICS - Update these with your latest numbers
  static const Map<String, String> currentMetrics = {
    'totalApps': '2',
    'totalDownloads': '50K+',
    'averageRating': '4.2★',
    'yearsExperience': '4+',
    'productionApps': '2',
  };
}

/// 💡 USAGE INSTRUCTIONS:
/// ✅ CONNECTED MODELS (auto-update when you change values above):
/// - PersonalInfoModel ← Uses fullName, currentRole, workStatus, email, etc.
/// - WorkExperienceModel ← Uses currentCompany, currentPosition, workDuration, etc.
/// - SocialLinkModel ← Uses githubUrl, linkedinUrl, email
/// - FooterInfoModel ← Uses copyrightYear, fullName, contactSubtitle
///
/// 🔥 MOST COMMON UPDATES (single source of truth):
/// - Update fullName → Auto-updates everywhere
/// - Update currentRole → Auto-updates title across site  
/// - Update workStatus → Auto-updates availability status
/// - Update currentMetrics → Auto-updates achievements and stats
/// - Update socialLinks → Auto-updates all footer/contact links
///
/// � DEPLOYMENT READY: Just edit this file and rebuild!
