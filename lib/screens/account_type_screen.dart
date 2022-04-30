import 'package:flutter/material.dart';

class AccountType extends StatelessWidget {
  const AccountType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              gradient: RadialGradient(
                  center: Alignment(-0.3, -0.95),
                  radius: 0.8,
                  colors: [
                Color.fromRGBO(255, 130, 205, 1),
                Color.fromRGBO(62, 40, 201, 1),
              ])),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: const Text(
                  'Select your user type',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: const Text(
                  'Your permissions will be created based on this selection',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w300),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 160,
                child: TextButton(
                  onPressed: () => Navigator.pushNamed(context, 'login'),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "I'm a parent",
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 30,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "I’ll be managing the account",
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: const Color.fromRGBO(50, 32, 161, 1),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 160,
                child: TextButton(
                    onPressed: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "I'm a Kid",
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 30,
                              color: Colors.white),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "You will win points by completing tasks",
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
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
          )),
        ),
      ),
    );
  }
}
