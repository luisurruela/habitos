import 'package:flutter/material.dart';

import 'package:flutter_onboard/flutter_onboard.dart';
import 'package:habitos/screens/account_type_screen.dart';

class IntroScreen extends StatelessWidget {
  final PageController _pageController = PageController();

  IntroScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SingleChildScrollView(
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
              child: OnBoard(
                pageController: _pageController,
                // Either Provide onSkip Callback or skipButton Widget to handle skip state
                onSkip: () {
                  // print('skipped');
                },
                // Either Provide onDone Callback or nextButton Widget to handle done state
                onDone: () {},
                imageWidth: MediaQuery.of(context).size.width * 0.85,
                onBoardData: onBoardData,
                titleStyles: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.15,
                ),
                descriptionStyles: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
                pageIndicatorStyle: const PageIndicatorStyle(
                  width: 100,
                  inactiveColor: Color.fromRGBO(255, 205, 235, 1),
                  activeColor: Color.fromRGBO(255, 130, 205, 1),
                  inactiveSize: Size(8, 8),
                  activeSize: Size(12, 12),
                ),
                // Either Provide onSkip Callback or skipButton Widget to handle skip state
                skipButton: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AccountType()));
                  },
                  child: const Text(
                    "Skip",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                // Either Provide onDone Callback or nextButton Widget to handle done state
                nextButton: OnBoardConsumer(
                  builder: (context, ref, child) {
                    final state = ref.watch(onBoardStateProvider);
                    return InkWell(
                      onTap: () {
                        {
                          !state.isLastPage
                              ? _onNextTap(state)
                              : Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AccountType()));
                        }
                      },
                      child: Container(
                        width: 230,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: const Color.fromRGBO(218, 240, 75, 1),
                        ),
                        child: Text(
                          state.isLastPage ? "Get Started" : "Next",
                          style: const TextStyle(
                            color: Color.fromRGBO(12, 8, 40, 1),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onNextTap(OnBoardState onBoardState) {
    if (!onBoardState.isLastPage) {
      _pageController.animateToPage(
        onBoardState.page + 1,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOutSine,
      );
    } else {
      //print("nextButton pressed");
    }
  }
}

final List<OnBoardModel> onBoardData = [
  const OnBoardModel(
    title: "Create a visual list of activities for your child",
    description:
        "Maintain healthy habits, and activities that organize your child’s daily schedule.",
    imgUrl: "assets/images/img_slide_1.png",
  ),
  const OnBoardModel(
    title: "Add amazing rewards for your kids",
    description: "Rewards will keep yout children motivated and on task.",
    imgUrl: 'assets/images/img_slide_2.png',
  ),
  const OnBoardModel(
    title: "Notifications to encourage healthy habits",
    description: "Be aware of all your kid’s actions using push notifications",
    imgUrl: 'assets/images/img_slide_3.png',
  ),
  const OnBoardModel(
    title: "Perfect sync between parent and child",
    description: "Develop new useful habits in your children together",
    imgUrl: 'assets/images/img_slide_4.png',
  ),
];
