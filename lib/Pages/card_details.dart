import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_assignment/utils/deisgn_system.dart';

class CardDetailsPage extends StatefulWidget {
  const CardDetailsPage({super.key});

  @override
  CardDetailsPageState createState() => CardDetailsPageState();
}

class CardDetailsPageState extends State<CardDetailsPage> {
  int _currentIndex = 0;

  final List<Map<String, dynamic>> _cardData = [
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

  void _showTermsAndConditions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: WatWalletDesignSystem.arrowBackColor),
          onPressed: () {
            Navigator.pop(context); // Navigate back to dashboard
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
      ),
      body: Column(
        children: [
          CarouselSlider.builder(
            itemCount: _cardData.length,
            itemBuilder: (context, index, realIndex) {
              return Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                child: Image.asset(
                  _cardData[index]['imagePath'],
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
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _cardData.map((url) {
              int index = _cardData.indexOf(url);
              return Container(
                width: _currentIndex == index ? 20.0 : 8.0,
                height: 8.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: _currentIndex == index
                      ? BoxShape.rectangle
                      : BoxShape.circle,
                  borderRadius:
                      _currentIndex == index ? BorderRadius.circular(4) : null,
                  color: _currentIndex == index
                      ? WatWalletDesignSystem.primaryColor
                      : Colors.grey,
                ),
              );
            }).toList(),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _cardData[_currentIndex]['features'].length,
              itemBuilder: (context, i) {
                final feature = _cardData[_currentIndex]['features'][i];
                return ListTile(
                  leading: Icon(
                    feature['icon'],
                    color: WatWalletDesignSystem.primaryColor,
                  ),
                  title: Text(
                    feature['text'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
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
          ),
          const SizedBox(height: 16),
          Padding(
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
                    _cardData[_currentIndex]['buttonText'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
