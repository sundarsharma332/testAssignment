import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:test_assignment/utils/deisgn_system.dart';

import 'card_details.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  int _activeTabIndex = 0;
  bool _isTabLoading = true;

  final List<Map<String, dynamic>> _carouselData = [
    {
      'imagePath': 'assets/card/card1.png',
      'backgroundColor': const Color(0xFF3E1676),
      'balance': '\$150.00 USD',
    },
    {
      'imagePath': 'assets/card/card2.png',
      'backgroundColor': const Color(0xFF16763E),
      'balance': '\$200.00 USD',
    },
    {
      'imagePath': 'assets/card/card3.png',
      'backgroundColor': const Color(0xFF76163E),
      'balance': '\$250.00 USD',
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadInitialTabContent();
  }

  void _loadInitialTabContent() {
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isTabLoading = false;
      });
    });
  }

  void _onCarouselChanged(int index) {
    setState(() {
      _currentIndex = index;
      _isTabLoading = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isTabLoading = false;
      });
    });
  }

  void _onTabTap(int index) {
    setState(() {
      _activeTabIndex = index;
    });
  }

  void _openTopUpPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TopUpPage()),
    );
  }

  void _openCardDetailsPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CardDetailsPage()),
    );
  }

  void _openFreezeModalSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const FreezeModalSheet();
      },
    );
  }

  void _openTerminateCardModalSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (BuildContext context) {
        return const TerminateCardModalSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                CarouselSlider(
                  items: _carouselData.map((data) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 16),
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: 120,
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: data['backgroundColor'],
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: WatWalletDesignSystem.primaryColor
                                        .withOpacity(0.1),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                      'Available Balance',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    data['balance'],
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 50,
                              left: 0,
                              right: 0,
                              child: Image.asset(
                                data['imagePath'],
                                height: 300,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }).toList(),
                  options: CarouselOptions(
                    height: 300,
                    enlargeCenterPage: false,
                    viewportFraction: 1.0,
                    autoPlay: false,
                    onPageChanged: (index, reason) {
                      _onCarouselChanged(index);
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _carouselData.map((url) {
                    int index = _carouselData.indexOf(url);
                    return Container(
                      width: 8.0,
                      height: 4.0,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: _currentIndex == index
                            ? WatWalletDesignSystem.primaryColor
                            : Colors.grey,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: _openTopUpPage,
                          child: _buildFeatureCard(Icons.add, 'Top Up'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: GestureDetector(
                          onTap: _openCardDetailsPage,
                          child: _buildFeatureCard(
                              Icons.credit_card, 'Card Details'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: GestureDetector(
                          onTap: _openFreezeModalSheet,
                          child: _buildFeatureCard(Icons.lock, 'Freeze'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _buildBottomModalSheet(),
        ],
      ),
    );
  }

  Widget _buildBottomModalSheet() {
    return DraggableScrollableSheet(
      initialChildSize: 0.4,
      minChildSize: 0.4,
      maxChildSize: 0.75,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          padding: const EdgeInsets.only(top: 4, left: 16, right: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            children: [
              const SizedBox(height: 8),
              Container(
                width: 50,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.black.withOpacity(0.1),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      _buildTab('Transactions', index: 0),
                      _buildTab('Manage Card', index: 1),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: _isTabLoading
                        ? _buildShimmerForTabContent()
                        : _activeTabIndex == 0
                            ? _buildTransactionsList()
                            : _buildManageCardContent(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTab(String label, {required int index}) {
    bool isActive = _activeTabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => _onTabTap(index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          decoration: BoxDecoration(
            color: isActive
                ? WatWalletDesignSystem.primaryColor
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard(IconData icon, String label) {
    return Container(
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
    );
  }

  Widget _buildTransactionsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Text(
            'Today',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        _buildTransactionItem('Grocery Shopping', '11:00 AM', '-\$50.00',
            'assets/history/walmart.png', Colors.red),
        _buildTransactionItem('Online Subscription', '1:00 PM', '-\$10.00',
            'assets/history/netflix.png', Colors.red),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Text(
            'Yesterday',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        _buildTransactionItem('Dining Out', '7:00 PM', '-\$30.00',
            'assets/history/noon.png', Colors.red),
        _buildTransactionItem('Fuel', '9:00 PM', '-\$40.00',
            'assets/history/google.png', Colors.red),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Text(
            'This Week',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        _buildTransactionItem('Gym Membership', '11:00 AM', '-\$25.00',
            'assets/history/walmart.png', Colors.red),
        _buildTransactionItem('Incoming Transfer', '2:00 PM', '+\$100.00',
            'assets/history/google.png', Colors.green),
      ],
    );
  }

  Widget _buildTransactionItem(String title, String time, String price,
      String imagePath, Color badgeColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: SizedBox(
        height: 72,
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    time,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
              decoration: BoxDecoration(
                color: badgeColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                price,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildManageCardContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            // Handle Add to Apple Wallet
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              children: [
                Icon(Icons.apple, color: Colors.white),
                Spacer(),
                Text(
                  'Add to Apple Wallet',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
        _buildManageCardList(),
      ],
    );
  }

  Widget _buildManageCardList() {
    final List<Map<String, dynamic>> cardItems = [
      {'title': 'Spending Currencies', 'color': Colors.black},
      {'title': 'Spending Limit', 'color': Colors.black},
      {'title': 'Change PIN', 'color': Colors.black},
      {'title': 'Order History', 'color': Colors.black},
      {'title': 'Terminate Card', 'color': Colors.red},
    ];

    return Column(
      children: cardItems.map((item) {
        bool isLast = item == cardItems.last;
        return GestureDetector(
          onTap: item['title'] == 'Terminate Card'
              ? _openTerminateCardModalSheet
              : null,
          child: _buildManageCardItem(item['title'], item['color'], !isLast),
        );
      }).toList(),
    );
  }

  Widget _buildManageCardItem(String title, Color color, bool addBorder) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: addBorder
            ? Border(
                bottom: BorderSide(color: Colors.grey.shade300, width: 1),
              )
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 16, color: color),
        ],
      ),
    );
  }

  Widget _buildShimmerForTabContent() {
    return Shimmer.fromColors(
      baseColor: WatWalletDesignSystem.shimmerColor,
      highlightColor: WatWalletDesignSystem.primaryColor.withOpacity(0.05),
      child: Column(
        children: [
          Container(
            height: 100,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          Container(
            height: 100,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ],
      ),
    );
  }
}

// Top Up Page
class TopUpPage extends StatelessWidget {
  const TopUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Up'),
        backgroundColor: WatWalletDesignSystem.primaryColor,
      ),
      body: const Center(
        child: Text('Top Up Page Content'),
      ),
    );
  }
}

// Freeze Modal Sheet
class FreezeModalSheet extends StatelessWidget {
  const FreezeModalSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Freeze Card',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const Text('Freeze your card to prevent any unauthorized usage.'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: WatWalletDesignSystem.primaryColor,
            ),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }
}

// Terminate Card Modal Sheet
class TerminateCardModalSheet extends StatelessWidget {
  const TerminateCardModalSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Terminate Card',
                  style: TextStyle(
                    fontSize: 24,
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
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Do you wish to terminate your card?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Note: This process cannot be undone.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF5F5F6F), // The gray color for the note
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () {
                // Handle Terminate Card
              },
              child: Container(
                width: double.infinity,
                height: 56,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFEF4444),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    'Terminate Card',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: double.infinity,
                height: 56,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: WatWalletDesignSystem.primaryColor),
                ),
                child: const Center(
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: WatWalletDesignSystem.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
