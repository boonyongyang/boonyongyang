import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherService {
  static void launchApp(BuildContext context) {
    // Navigate to the main app
    // In production, this would be a different subdomain
    const appUrl = String.fromEnvironment('APP_URL',
        defaultValue: 'https://app.yourdomain.com');

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
            'In production, this would redirect to app.yourdomain.com\n\n'
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
    final uri = Uri.parse('https://github.com/boonyongyang');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  static Future<void> launchLinkedIn() async {
    final uri = Uri.parse('https://linkedin.com/in/boonyongyang');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  static Future<void> launchEmail() async {
    final uri = Uri.parse('mailto:boonyongyang@gmail.com?subject=Hello');
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
