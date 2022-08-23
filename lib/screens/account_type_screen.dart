import 'package:flutter/material.dart';
import 'package:habitos/theme/theme.dart';

class AccountType extends StatelessWidget {
  const AccountType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: height,
          width: width,
          decoration: AppTheme.backgroundGradient,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Title(context),
                  const SizedBox(
                    height: 30,
                  ),
                  const Subtitle(),
                  const SizedBox(
                    height: 50,
                  ),
                  const TypeCard(
                    title: "I'm a Parent",
                    body: "I'll be managing the account",
                    route: 'login',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const TypeCard(
                    title: "I'm a Kid",
                    body: "You will win points by completing tasks",
                    route: '',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget Title(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: const Text(
        'Select your user type',
        style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w500,
            fontFamily: 'PPAgrandir'),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class Subtitle extends StatelessWidget {
  const Subtitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: const Text(
        'Your permissions will be created based on this selection',
        style: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.w300),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class TypeCard extends StatelessWidget {
  const TypeCard({
    Key? key,
    required this.title,
    required this.body,
    this.route,
  }) : super(key: key);
  final String title;
  final String body;
  final String? route;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 130,
      child: TextButton(
        onPressed: () => route != null
            ? route!.isNotEmpty
                ? Navigator.pushNamed(context, route!)
                : null
            : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 24,
                  color: Colors.white,
                  fontFamily: 'PPAgrandir'),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              body,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: AppTheme.primary,
      ),
    );
  }
}
