// components/card_feature_list.dart
import 'package:flutter/material.dart';
import '../Models/card_details.dart';
import '../utils/deisgn_system.dart';

class CardFeatureList extends StatelessWidget {
  final CardDetailsModel card;

  const CardFeatureList({
    super.key,
    required this.card,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: card.features.length,
        itemBuilder: (context, i) {
          final feature = card.features[i];
          return ListTile(
            leading: Icon(
              feature.icon,
              color: WatWalletDesignSystem.primaryColor,
            ),
            title: Text(
              feature.text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        },
      ),
    );
  }
}
