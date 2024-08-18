import 'package:flutter/material.dart';

const List<Map<String, dynamic>> cardData = [
  {
    'imagePath': 'assets/card/card1.png',
    'features': [
      {'icon': Icons.money, 'text': 'Spend and withdraw money anywhere'},
      {'icon': Icons.airplanemode_active, 'text': 'Access airport lounges'},
      {'icon': Icons.card_membership, 'text': 'Unique card design'},
    ],
    'buttonText': 'Order Physical Card',
  },
  {
    'imagePath': 'assets/card/card2.png',
    'features': [
      {'icon': Icons.money, 'text': 'Global Spend with no fees'},
      {'icon': Icons.card_travel, 'text': 'Travel insurance included'},
      {'icon': Icons.upgrade, 'text': 'Upgrade to premium features'},
    ],
    'buttonText': 'Upgrade for \$10.99',
  },
  {
    'imagePath': 'assets/card/card3.png',
    'features': [
      {'icon': Icons.savings, 'text': 'Earn cashback on purchases'},
      {'icon': Icons.local_offer, 'text': 'Exclusive offers and rewards'},
      {'icon': Icons.lock, 'text': 'Advanced card security'},
    ],
    'buttonText': 'Order Physical Card',
  },
];
