import 'package:flutter/material.dart';
import 'package:habitos/theme/theme.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Rewards Page',
        style: AppTheme.fontTitleWhite,
      ),
    );
  }
}
