import 'package:flutter/material.dart';
import '../utils/deisgn_system.dart';

class FeatureCardComponent extends StatelessWidget {
  final IconData icon;
  final String label;
  final Function() onTap;

  const FeatureCardComponent({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(
            color: WatWalletDesignSystem.primaryColor.withOpacity(0.2),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: WatWalletDesignSystem.primaryColor, size: 32),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: WatWalletDesignSystem.primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
