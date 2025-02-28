import 'package:boonyongyang/shared/widgets/top_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopNavBar(title: 'About'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Flutter Web Demo',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Gap(16),
                const Text(
                  'Version: 1.0.0',
                  style: TextStyle(fontSize: 16),
                ),
                const Gap(16),
                const Text(
                  'This is a Flutter web application that demonstrates various widgets and functionalities including:',
                  style: TextStyle(fontSize: 16),
                ),
                const Gap(8),
                ...[
                  'OpenStreetMap integration',
                  'Interactive charts',
                  'Experimental features',
                  'Mini games',
                ].map((feature) => Padding(
                      padding: const EdgeInsets.only(left: 16, bottom: 4),
                      child: Row(
                        children: [
                          const Icon(Icons.check_circle, size: 16),
                          const SizedBox(width: 8),
                          Text(feature),
                        ],
                      ),
                    )),
                const Gap(24),
                const Text(
                  'Links',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Gap(8),
                InkWell(
                  onTap: () => launchUrl(
                    Uri.parse('https://github.com/boonyongyang'),
                  ),
                  child: const Text(
                    'GitHub Repository',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const Gap(24),
                ElevatedButton(
                  onPressed: () {
                    showLicensePage(context: context);
                  },
                  child: const Text('View Licenses'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
