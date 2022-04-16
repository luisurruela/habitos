import 'package:flutter/material.dart';

import 'package:habitos/screens/signin_screen.dart';

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
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Login())),
              child: const Text('Parent')),
          TextButton(onPressed: () {}, child: const Text('Kid'))
        ],
      )),
    );
  }
}
