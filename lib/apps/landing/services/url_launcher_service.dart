import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../config/quick_config.dart';

class UrlLauncherService {
  static void launchApp(BuildContext context) {
    // Navigate to the main app
    // APP_URL can override QuickConfig.appUrl for build-time environment.
    const appUrl =
        String.fromEnvironment('APP_URL', defaultValue: QuickConfig.appUrl);

    if (appUrl.startsWith('http')) {
      // Production: redirect to subdomain
      launchUrl(Uri.parse(appUrl));
    } else {
      // Development: show dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Launching App'),
          content: const Text(
            'In production, this opens the separately hosted Flutter app.\n\n'
            'For development, run:\nflutter run -d chrome --target=lib/main_app.dart',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  static Future<void> launchGitHub() async {
    final uri = Uri.parse(QuickConfig.githubUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  static Future<void> launchLinkedIn() async {
    final uri = Uri.parse(QuickConfig.linkedinUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  static Future<void> launchEmail() async {
    final uri = Uri(
      scheme: 'mailto',
      path: QuickConfig.email,
      queryParameters: {'subject': QuickConfig.emailSubject},
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  static Future<void> launchCustomUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
