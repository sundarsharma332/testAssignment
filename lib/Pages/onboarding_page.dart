import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../data/onboarding_data.dart';
import '../utils/deisgn_system.dart';
import '../components/onboarding_content_widgets.dart';
import 'dashboard.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  OnboardingPageState createState() => OnboardingPageState();
}

class OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoScrollTimer();
  }

  void _startAutoScrollTimer() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_currentIndex < onboardingContents.length - 1) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: SvgPicture.asset(
                  'assets/logo/logo.svg',
                  height: 36, // Logo height
                ),
              ),
              const SizedBox(height: 24), // Space between logo and content
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: onboardingContents.length,
                  onPageChanged: (int index) {
                    setState(() {
                      _currentIndex = index;
                    });
                    _timer?.cancel(); // Cancel the previous timer
                    _startAutoScrollTimer(); // Restart the timer on user interaction
                  },
                  itemBuilder: (context, index) {
                    return OnboardingContentWidget(
                      content: onboardingContents[index],
                    ); // Use the new widget
                  },
                ),
              ),
              const SizedBox(height: 24), // Added space before the indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  onboardingContents.length,
                  (index) => _buildIndicator(index == _currentIndex),
                ),
              ),
              const SizedBox(height: 24), // Added space after the indicator
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: WatWalletDesignSystem
                          .primaryColor, // Use primary color from design system
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (_) => const Dashboard(),
                      ));
                    },
                    child: const Text(
                      'Get Started',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIndicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      height: 12.0, // Make indicator circular
      width: 12.0,
      decoration: BoxDecoration(
        color: isActive
            ? WatWalletDesignSystem.primaryColor
            : const Color(0xFFD8D8D8), // Use primary color from design system
        shape: BoxShape.circle, // Circular indicator
      ),
    );
  }
}
