// In cards_carousel.dart
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../Models/card_details.dart';

class CardCarousel extends StatelessWidget {
  final List<CardDetailsModel> cards;
  final int currentIndex;
  final ValueChanged<int> onPageChanged;

  const CardCarousel({
    super.key,
    required this.cards,
    required this.currentIndex,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: cards.length,
      itemBuilder: (context, index, realIndex) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Image.asset(
            cards[index].imagePath,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        );
      },
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height * 0.4,
        enlargeCenterPage: false,
        viewportFraction: 1.0,
        onPageChanged: (index, reason) {
          onPageChanged(index); // Update this callback to match the signature
        },
      ),
    );
  }
}
