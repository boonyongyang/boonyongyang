import 'package:flutter/material.dart';

/// Utility class for consistent icon and color mapping across the landing page
class LandingPageUtils {
  // Icon mapping for consistent icon usage
  static const Map<String, IconData> iconMap = {
    // Personal & Profile
    'person': Icons.person,
    'email': Icons.email,
    'phone': Icons.phone,
    'location': Icons.location_on,

    // Work & Career
    'work': Icons.work,
    'trending_up': Icons.trending_up,
    'phone_android': Icons.phone_android,
    'code': Icons.code,

    // Technical
    'architecture': Icons.architecture,
    'speed': Icons.speed,
    'security': Icons.security,
    'integration_instructions': Icons.integration_instructions,
    'shopping_bag': Icons.shopping_bag,
    'account_balance_wallet': Icons.account_balance_wallet,

    // Actions
    'launch': Icons.launch,
    'open_in_new': Icons.open_in_new,
    'download': Icons.download,
    'verified': Icons.verified,

    // Social
    'github': Icons.code,
    'linkedin': Icons.work,
    'twitter': Icons.alternate_email,

    // Technology Icons - Mobile
    'flutter': Icons.phone_android,
    'dart': Icons.code,
    'ios': Icons.phone_iphone,
    'android': Icons.android,
    'apple': Icons.phone_iphone,
    'firebase': Icons.whatshot,
    'publish': Icons.publish,

    // Technology Icons - Web
    'web': Icons.web,
    'vue': Icons.web,
    'react': Icons.web,
    'typescript': Icons.code,
    'javascript': Icons.code,
    'html': Icons.code,

    // Technology Icons - Backend
    'laravel': Icons.code,
    'nodejs': Icons.dns,
    'database': Icons.storage,
    'mysql': Icons.storage,
    'mongodb': Icons.storage,
    'api': Icons.api,

    // Technology Icons - Cloud & DevOps
    'cloud': Icons.cloud,
    'docker': Icons.developer_board,
    'sync': Icons.sync,

    // Technology Icons - Development Tools
    'analytics': Icons.analytics,
    'design': Icons.design_services,
    'bug_report': Icons.bug_report,
    'build': Icons.build,
    'task': Icons.task,
    'assignment': Icons.assignment,
    'chat': Icons.chat,
    'storage': Icons.storage,
    'cloud_queue': Icons.cloud_queue,
  };

  // Color mapping for consistent color scheme
  static const Map<String, Color> colorMap = {
    'blue': Colors.blue,
    'green': Colors.green,
    'orange': Colors.orange,
    'purple': Colors.purple,
    'red': Colors.red,
    'teal': Colors.teal,
    'indigo': Colors.indigo,
    'cyan': Colors.cyan,
    'grey': Colors.grey,
    'yellow': Colors.yellow,
    'pink': Colors.pink,
    'deepOrange': Colors.deepOrange,
    'lightBlue': Colors.lightBlue,
    'lightGreen': Colors.lightGreen,
  };

  // Status color mapping
  static const Map<String, Color> statusColorMap = {
    'available': Colors.green,
    'busy': Colors.orange,
    'unavailable': Colors.red,
  };

  /// Get icon by name, with fallback
  static IconData getIcon(String iconName, {IconData fallback = Icons.help}) {
    return iconMap[iconName] ?? fallback;
  }

  /// Get color by name, with fallback
  static Color getColor(String colorName, {Color fallback = Colors.grey}) {
    return colorMap[colorName] ?? fallback;
  }

  /// Get status color by status
  static Color getStatusColor(String status, {Color fallback = Colors.grey}) {
    return statusColorMap[status] ?? fallback;
  }

  /// Format duration text consistently
  static String formatDuration(String duration) {
    return duration;
  }

  /// Format metrics text consistently
  static String formatMetrics(String metrics) {
    return metrics;
  }

  /// Generate consistent chip widgets for technologies
  static Widget buildTechChip(String technology, {Color? color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: (color ?? Colors.blue).withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: (color ?? Colors.blue).withOpacity(0.3),
        ),
      ),
      child: Text(
        technology,
        style: TextStyle(
          color: color ?? Colors.blue,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  /// Generate consistent feature list items
  static Widget buildFeatureListItem(String feature, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            size: 16,
            color: color ?? Colors.green,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              feature,
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Consistent URL validation
  static bool isValidUrl(String? url) {
    if (url == null || url.isEmpty) return false;
    return Uri.tryParse(url) != null;
  }

  /// Consistent email validation
  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  // Proficiency level utilities
  static String getProficiencyText(String proficiencyLevel) {
    switch (proficiencyLevel.toLowerCase()) {
      case 'beginner':
        return 'Beginner';
      case 'intermediate':
        return 'Intermediate';
      case 'advanced':
        return 'Advanced';
      case 'expert':
        return 'Expert';
      default:
        return 'Unknown';
    }
  }

  static Color getProficiencyColor(String proficiencyLevel) {
    switch (proficiencyLevel.toLowerCase()) {
      case 'beginner':
        return Colors.orange;
      case 'intermediate':
        return Colors.blue;
      case 'advanced':
        return Colors.green;
      case 'expert':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  static double getProficiencyProgress(String proficiencyLevel) {
    switch (proficiencyLevel.toLowerCase()) {
      case 'beginner':
        return 0.25;
      case 'intermediate':
        return 0.5;
      case 'advanced':
        return 0.75;
      case 'expert':
        return 1.0;
      default:
        return 0.0;
    }
  }
}
