import 'package:flutter/material.dart';

import '../theme/theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Settings Page',
        style: AppTheme.fontTitleWhite,
      ),
    );
  }
}
