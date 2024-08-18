import 'package:flutter/material.dart';

class CardFeature {
  final IconData icon;
  final String text;

  CardFeature({required this.icon, required this.text});
}

class CardDetailsModel {
  final String imagePath;
  final List<CardFeature> features;
  final String buttonText;

  CardDetailsModel({
    required this.imagePath,
    required this.features,
    required this.buttonText,
  });

  factory CardDetailsModel.fromMap(Map<String, dynamic> map) {
    return CardDetailsModel(
      imagePath: map['imagePath'],
      features: (map['features'] as List)
          .map((feature) => CardFeature(
                icon: feature['icon'],
                text: feature['text'],
              ))
          .toList(),
      buttonText: map['buttonText'],
    );
  }
}
