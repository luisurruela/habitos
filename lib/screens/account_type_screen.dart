import 'package:flutter/material.dart';

class AccountType extends StatelessWidget {
  const AccountType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select your account type')),
      body: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () => Navigator.pushNamed(context, 'login'),
              child: const Text('Parent')),
          TextButton(onPressed: () {}, child: const Text('Kid'))
        ],
      )),
    );
  }
}
