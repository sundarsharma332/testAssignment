import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../Models/card_details.dart';
import '../components/card_feature_list.dart';
import '../components/cards_carousel.dart';
import '../components/terms_and_conditions.dart';
import '../repositories/card_details_repository.dart';
import '../utils/deisgn_system.dart';

class CardDetailsPage extends StatefulWidget {
  const CardDetailsPage({super.key});

  @override
  CardDetailsPageState createState() => CardDetailsPageState();
}

class CardDetailsPageState extends State<CardDetailsPage> {
  int _currentIndex = 0;
  late final List<CardDetailsModel> _cards;
  final CardRepository _cardRepository = CardRepository();

  @override
  void initState() {
    super.initState();
    _cards = _cardRepository.fetchCardData();
  }

  void _showTermsAndConditions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => const TermsAndConditionsModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          CardCarousel(
            cards: _cards,
            currentIndex: _currentIndex,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          _buildIndicator(),
          CardFeatureList(card: _cards[_currentIndex]),
          _buildTermsAndConditionsText(),
          _buildActionButton(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back,
            color: WatWalletDesignSystem.arrowBackColor),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: SvgPicture.asset(
        'assets/logo/logo.svg',
        height: 32,
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.white,
      actions: [
        IconButton(
          icon: const Icon(Icons.support,
              color: WatWalletDesignSystem.primaryColor),
          onPressed: () {
            // Handle support icon press
          },
        ),
      ],
    );
  }

  Widget _buildIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _cards.map((card) {
        int index = _cards.indexOf(card);
        return Container(
          width: _currentIndex == index ? 20.0 : 8.0,
          height: 8.0,
          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
          decoration: BoxDecoration(
            shape:
                _currentIndex == index ? BoxShape.rectangle : BoxShape.circle,
            borderRadius:
                _currentIndex == index ? BorderRadius.circular(4) : null,
            color: _currentIndex == index
                ? WatWalletDesignSystem.primaryColor
                : Colors.grey,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTermsAndConditionsText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text.rich(
        TextSpan(
          text:
              'This is a yearly subscription. By proceeding you have read and accept the ',
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF5F5F6F),
          ),
          children: [
            TextSpan(
              text: 'Terms & Conditions',
              style: const TextStyle(
                color: WatWalletDesignSystem.primaryColor,
                fontWeight: FontWeight.bold,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = _showTermsAndConditions,
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildActionButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GestureDetector(
        onTap: () {
          // Handle button press based on card
        },
        child: Container(
          height: 56,
          width: double.infinity,
          decoration: BoxDecoration(
            color: WatWalletDesignSystem.primaryColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              _cards[_currentIndex].buttonText,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
