import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../widgets/top_nav_bar.dart';
import '../widgets/date_timer_widget.dart';
import '../widgets/random_quote_widget.dart';
import '../widgets/user_ip_address.dart';

class PlaysPage extends StatelessWidget {
  const PlaysPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: TopNavBar(title: 'Plays'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Gap(30.0),
            DateTimerWidget(),
            Gap(30.0),
            RandomQuoteWidget(),
            Gap(30.0),
            IPAddressWidget(),
          ],
        ),
      ),
    );
  }
}
