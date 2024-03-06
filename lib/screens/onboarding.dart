import 'package:flutter/material.dart';
import 'package:front_end/widgets/Onboarding/onboarding_page_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final pageController = PageController(initialPage: 0);
  var _skipButtonContent = 'Skip';

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void changePage(int index) {
    setState(() {
      pageController.animateToPage(index,
          duration: const Duration(milliseconds: 20), curve: Curves.bounceIn);
      if (index == 2) {
        _skipButtonContent = 'Get Started';
      }
      print(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    // const width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          // Positioned(child: (){})),
          Padding(
            padding: const EdgeInsets.only(
              top: 150,
              left: 10,
              right: 10,
            ),
            child: PageView(
              controller: pageController,
              onPageChanged: (index) {
                changePage(index);
              },
              children: const [
                OnboardingWidget(
                    image: 'lib/assets/Onboarding/Onboarding_image_1.png',
                    title: 'Easy, Fast & Trusted',
                    subTitle:
                        'Fast money transfer and guaranteed safe transactions with others'),
                OnboardingWidget(
                    image: 'lib/assets/Onboarding/Onboarding_image_2.png',
                    title: 'Saving your Money',
                    subTitle:
                        'Track the progress of your savings and start a habit of saving with us'),
                OnboardingWidget(
                    image: 'lib/assets/Onboarding/Onboarding_image_3.png',
                    title: 'Free Transactions',
                    subTitle:
                        'Provides a quality of the financial system with free money transactions without any fees'),
              ],
            ),
          ),
          Positioned(
            bottom: 50,
            left: 30,
            child: SmoothPageIndicator(
              onDotClicked: changePage,
              controller: pageController,
              count: 3,
              effect: const ExpandingDotsEffect(
                  activeDotColor: Colors.black, dotHeight: 6),
            ),
          ),
          Positioned(
            bottom: 35,
            right: 30,
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                _skipButtonContent,
                style: TextStyle(color: Colors.black),
              ),
            ),
          )
        ],
      ),
    );
  }
}
