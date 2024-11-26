import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/top_nav_bar.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopNavBar(title: 'About'),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Gap(10),
              const SelectableText('Version: 0.0.1'),
              const Gap(10),
              const SelectableText(
                'This is a simple Flutter web application that demonstrates '
                'for experimenting with various widgets and functionalities.',
              ),
              const Gap(10),
              GestureDetector(
                onTap: () {
                  launchUrl(Uri.parse('https://github.com/boonyongyang'));
                },
                child: const Text(
                  'https://github.com/boonyongyang',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const Gap(10),
              ElevatedButton(
                onPressed: () {
                  showLicensePage(context: context);
                },
                child: const Text('License'),
              ),
              const Gap(10),
            ],
          ),
        ),
      ),
    );
  }
}
