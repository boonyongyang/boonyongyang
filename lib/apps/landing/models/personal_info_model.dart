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

  static PersonalInfoModel get current => const PersonalInfoModel(
        name: 'Boon Yong Yang',
        title: 'Mobile Engineer & Flutter Expert',
        subtitle: 'Available for Work',
        status: 'available',
        statusColor: 'green',
        description:
            'Specialized in Flutter mobile development with 2+ years delivering production apps.\n'
            'Expert in architectural patterns, CI/CD pipelines, and performance optimization.\n'
            'Dedicated to writing clean code, building scalable solutions, and delivering exceptional user experiences.',
        achievementBanner: '2 Production Apps  |  4+ Years Flutter Experience',
        email: 'boonyongyang@gmail.com',
        avatarUrl: null, // Can be added later
      );
}
