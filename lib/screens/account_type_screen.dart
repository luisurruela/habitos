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
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
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
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: const Text(
                      'Your permissions will be created based on this selection',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w300),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 130,
                    child: TextButton(
                      onPressed: () => Navigator.pushNamed(context, 'login'),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "I'm a parent",
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 24,
                                color: Colors.white,
                                fontFamily: 'PPAgrandir'),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "I’ll be managing the account",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Color.fromRGBO(255, 255, 255, 1),
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
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 130,
                    child: TextButton(
                        onPressed: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "I'm a Kid",
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontFamily: 'PPAgrandir'),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "You will win points by completing tasks",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Color.fromRGBO(255, 255, 255, 1),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: const Color.fromRGBO(50, 32, 161, 1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
