import 'package:flutter/material.dart';

import 'package:flutter_onboard/flutter_onboard.dart';
import 'package:provider/provider.dart';
import 'package:scanner/component/navigation_bar.dart';


class OnboardScreen extends StatelessWidget {
  final PageController _pageController = PageController();

  OnboardScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Provider<OnBoardState>(
      create: (_) => OnBoardState(),
      child: Scaffold(
        body: OnBoard(
          pageController: _pageController,
          // Either Provide onSkip Callback or skipButton Widget to handle skip state
          onSkip: () {
            // print('skipped');
          },
          // Either Provide onDone Callback or nextButton Widget to handle done state
          onDone: () {
            // print('done tapped');
            // ignore: avoid_print
            print("Done");
          },
          onBoardData: onBoardData,
          titleStyles: const TextStyle(
            color: Colors.deepOrange,
            fontSize: 18,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.15,
          ),
          descriptionStyles: TextStyle(
            fontSize: 16,
            color: Colors.brown.shade300,
          ),
          pageIndicatorStyle: const PageIndicatorStyle(
            width: 100,
            inactiveColor: Colors.deepOrangeAccent,
            activeColor: Colors.deepOrange,
            inactiveSize: Size(8, 8),
            activeSize: Size(12, 12),
          ),
          // Either Provide onSkip Callback or skipButton Widget to handle skip state
          skipButton: TextButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => const BottomNavigationContainor()),
                (Route<dynamic> route) => false,
              );
            },
            child: const Text(
              "Skip",
              style: TextStyle(color: Colors.deepOrangeAccent),
            ),
          ),
          // Either Provide onDone Callback or nextButton Widget to handle done state
          nextButton: Consumer<OnBoardState>(
            builder: (BuildContext context, OnBoardState state, Widget? child) {
              return InkWell(
                onTap: () => {
                  if (_onNextTap(state))
                    {}
                  else
                    {
                      // addBool(),
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const BottomNavigationContainor()),
                        (Route<dynamic> route) => false,
                      )
                    }
                },
                child: Container(
                  width: 230,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: const LinearGradient(
                      colors: [Colors.redAccent, Colors.deepOrangeAccent],
                    ),
                  ),
                  child: Text(
                    state.isLastPage ? "Done" : "Next",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  _onNextTap(OnBoardState onBoardState) {
    if (!onBoardState.isLastPage) {
      _pageController.animateToPage(
        onBoardState.page + 1,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOutSine,
      );
      return true;
    } else {
      return false;
    }
  }

  // addBool() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setBool('check', true);
  //   print("addBool successfully");
  // }
}

final List<OnBoardModel> onBoardData = [
  const OnBoardModel(
    title: "Set your own goals and get better",
    description: "Goal support your motivation and inspire you to work harder",
    imgUrl: 'assets/onboard1.png',
  ),
  const OnBoardModel(
    title: "Track your progress with statistics",
    description:
        "Analyse personal result with detailed chart and numerical values",
    imgUrl: 'assets/onboard3.png',
  ),
  const OnBoardModel(
    title: "Create photo comparissions and share your results",
    description:
        "Take before and after photos to visualize progress and get the shape that you dream about",
    imgUrl: 'assets/onboard2.png',
  ),
];
