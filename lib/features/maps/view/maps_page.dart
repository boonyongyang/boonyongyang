import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../shared/widgets/top_nav_bar.dart';
import 'osm_widget.dart';

class MapsPage extends StatelessWidget {
  const MapsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopNavBar(title: 'Maps'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const _MapView(
                          title: 'OpenStreetMap',
                          child: OsmWidget(),
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.map),
                  label: const Text('OpenStreetMap'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const _MapView(
                          title: 'Location Search',
                          child: Center(child: Text('Location Search')),
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.search),
                  label: const Text('Search'),
                ),
              ],
            ),
            const Gap(16),
            const Expanded(
              child: OsmWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

class _MapView extends StatelessWidget {
  final String title;
  final Widget child;

  const _MapView({
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: child,
    );
  }
}
