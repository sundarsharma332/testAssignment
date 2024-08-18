import 'package:flutter/material.dart';
import '../Models/card_details.dart';

class CardRepository {
  List<CardDetailsModel> fetchCardData() {
    return [
      CardDetailsModel(
        imagePath: 'assets/card/card1.png',
        features: [
          CardFeature(
              icon: Icons.money, text: 'Spend and withdraw money anywhere'),
          CardFeature(
              icon: Icons.airplanemode_active, text: 'Access airport lounges'),
          CardFeature(icon: Icons.card_membership, text: 'Unique card design'),
        ],
        buttonText: 'Order Physical Card',
      ),
      CardDetailsModel(
        imagePath: 'assets/card/card2.png',
        features: [
          CardFeature(icon: Icons.money, text: 'Global Spend with no fees'),
          CardFeature(
              icon: Icons.card_travel, text: 'Travel insurance included'),
          CardFeature(icon: Icons.upgrade, text: 'Upgrade to premium features'),
        ],
        buttonText: 'Upgrade for \$10.99',
      ),
      CardDetailsModel(
        imagePath: 'assets/card/card3.png',
        features: [
          CardFeature(icon: Icons.savings, text: 'Earn cashback on purchases'),
          CardFeature(
              icon: Icons.local_offer, text: 'Exclusive offers and rewards'),
          CardFeature(icon: Icons.lock, text: 'Advanced card security'),
        ],
        buttonText: 'Order Physical Card',
      ),
    ];
  }
}
