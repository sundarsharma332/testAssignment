import 'package:flutter/material.dart';
import '../Models/onboarding_model.dart';

class OnboardingContentWidget extends StatelessWidget {
  final OnboardingContent content;

  const OnboardingContentWidget({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment:
          CrossAxisAlignment.center, // Aligns content to the center
      children: <Widget>[
        Image.asset(
          content.image,
          height: 200,
        ),
        const SizedBox(height: 40),
        Text(
          content.title,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Text(
            content.description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 16,
                  color: Colors.black.withOpacity(
                      0.7), // Slightly lighter color for description
                ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
