import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../widgets/date_timer_widget.dart';
import '../widgets/random_quote_widget.dart';
import '../widgets/user_ip_address_widget.dart';

class HomePage extends StatelessWidget {
  final VoidCallback toggleTheme;
  final int counter;
  final PageController pageController;

  const HomePage({
    super.key,
    required this.toggleTheme,
    required this.counter,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ElevatedButton(
          onPressed: toggleTheme,
          child: const Text('Toggle Theme'),
        ),
        const SelectableText('u push this button how many times already '),
        Builder(
          builder: (BuildContext context) {
            return SelectableText(
              '$counter times!',
              style: Theme.of(context).textTheme.headlineMedium,
            );
          },
        ),
        const Gap(30.0),
        ElevatedButton(
          onPressed: () {
            pageController.animateToPage(
              1,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
          child: const Text('Go to Page 2'),
        ),
        const Gap(30.0),
        const SelectableText('Github: https://github.com/boonyongyang'),
        const Gap(30.0),
        Image.network(
          'https://i.giphy.com/media/v1.Y2lkPTc5MGI3NjExMHRyaDE1YXlxdzBqaTk0dGxneDVnZDR1M2Fya3Q1ODBpMW5icXRyeiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/ZdIzhi10ZlKhU8EpDh/giphy.gif',
          height: MediaQuery.of(context).size.width * 0.2,
        ),
        const Gap(30.0),
        const DateTimerWidget(),
        const Gap(30.0),
        const RandomQuoteWidget(),
        const Gap(30.0),
        const UserIPAddressWidget(),
      ],
    );
  }
}
