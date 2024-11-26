import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'fake_location_loading_widget.dart';

class UserIPAddressWidget extends StatefulWidget {
  const UserIPAddressWidget({super.key});

  @override
  UserIPAddressWidgetState createState() => UserIPAddressWidgetState();
}

class UserIPAddressWidgetState extends State<UserIPAddressWidget> {
  String _ipAddress = 'Fetching IP...';

  @override
  void initState() {
    super.initState();
    _fetchIPAddress();
  }

  Future<void> _fetchIPAddress() async {
    final response =
        await http.get(Uri.parse('https://api.ipify.org?format=json'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _ipAddress = data['ip'];
      });
    } else {
      setState(() {
        _ipAddress = 'Failed to fetch IP';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SelectableText('Your IP Address:'),
        SelectableText(_ipAddress),
        const SelectableText('Your Location:'),
        const Gap(10.0),
        const FakeLocationLoadingWidget(),
      ],
    );
  }
}
