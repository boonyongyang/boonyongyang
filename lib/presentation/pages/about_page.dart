import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AboutPage extends StatelessWidget {
  final PageController pageController;

  const AboutPage({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              pageController.animateToPage(
                0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            child: const Text('Go to Page 1'),
          ),
          ListView.builder(
            itemCount: 30,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Image.network(
                'https://i.giphy.com/media/v1.Y2lkPTc5MGI3NjExMHRyaDE1YXlxdzBqaTk0dGxneDVnZDR1M2Fya3Q1ODBpMW5icXRyeiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/ZdIzhi10ZlKhU8EpDh/giphy.gif',
              );
            },
          ),
          const Gap(30.0),
        ],
      ),
    );
  }
}
