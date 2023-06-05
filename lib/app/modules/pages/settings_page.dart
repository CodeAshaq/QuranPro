import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quran_pro/app/constants/colors.dart';
import 'package:quran_pro/app/modules/widgets/display_name.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);
  static const settingsPage = '/settings-page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const FaIcon(Icons.person, size: 24),
                  const SizedBox(width: 10),
                  Text('Username', style: kTextStyleBlack(20)),
                ],
              ),
              DisplayName(),
              Divider(thickness: 2, color: Colors.amber.withOpacity(0.3)),
              Text('Get in Touch With Dev', style: kTextStyleBlack(20)),
              Divider(thickness: 2, color: Colors.amber.withOpacity(0.3)),
            ],
          ),
        ),
      ),
    );
  }
}
