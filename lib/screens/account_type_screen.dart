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
          Container(
            width: 150,
            height: 150,
            child: TextButton(
              onPressed: () => Navigator.pushNamed(context, 'login'),
              child: const Text(
                'Parent',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.blue),
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.blue.shade50,
              boxShadow: const [
                BoxShadow(color: Colors.lightBlue, spreadRadius: 3),
              ],
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Container(
            width: 150,
            height: 150,
            child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Kid',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.blue),
                )),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.blue.shade50,
              boxShadow: const [
                BoxShadow(color: Colors.lightBlue, spreadRadius: 3),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
