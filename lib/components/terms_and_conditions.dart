import 'package:flutter/material.dart';

class TermsAndConditionsModal extends StatelessWidget {
  const TermsAndConditionsModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Terms & Conditions',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'These are the dummy terms and conditions. '
            'Please read them carefully before proceeding. '
            'By accepting, you agree to be bound by these terms and conditions.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
