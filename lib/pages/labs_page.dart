import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../widgets/embeded_youtube_video.dart';
import '../widgets/top_nav_bar.dart';

class LabsPage extends StatelessWidget {
  const LabsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> buttons = [
      {
        'label': 'OpenStreetMap',
        'route': '/osm',
      },
      {
        'label': 'Gemini',
        'route': '/gemini',
      },
      {
        'label': 'Chart',
        'route': '/chart',
      },
      {
        'label': 'Animate',
        'route': '/animate',
      },
    ];

    return Scaffold(
      appBar: const TopNavBar(title: 'Labs'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: buttons.map((button) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, button['route']!);
                      },
                      child: Text(button['label']!),
                    ),
                  );
                }).toList(),
              ),
            ),
            Center(
              child: DefaultTabController(
                length: 3,
                child: Column(
                  children: [
                    const TabBar(
                      tabs: [
                        Tab(text: 'Video'),
                        Tab(text: 'Random Image'),
                        Tab(text: 'Motivational Quote'),
                      ],
                    ),
                    SizedBox(
                      height: 500, // Set a fixed height for the TabBarView
                      child: TabBarView(
                        children: [
                          const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Gap(20),
                                Expanded(child: EmbededYoutubeVideo()),
                                Gap(20),
                              ],
                            ),
                          ),
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Random Image',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Gap(20),
                                Image.network(
                                  'https://img-cdn.pixlr.com/image-generator/history/65bb506dcb310754719cf81f/ede935de-1138-4f66-8ed7-44bd16efc709/medium.webp',
                                  width: 300,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ],
                            ),
                          ),
                          const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Quote',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                Gap(20),
                                Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Text(
                                    '"The only way to do great work is to love what you do." - Steve Jobs',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
