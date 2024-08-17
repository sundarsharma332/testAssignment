import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:test_assignment/utils/deisgn_system.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  int _activeTabIndex = 0;
  bool _isTabLoading = false;

  final List<String> _carouselImages = [
    'assets/card/card1.png',
    'assets/card/card2.png',
    'assets/card/card3.png',
  ];

  @override
  void initState() {
    super.initState();
    _loadInitialTabContent();
  }

  void _loadInitialTabContent() {
    setState(() {
      _isTabLoading = true;
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
              items: _carouselImages.map((imagePath) {
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
                            color: const Color(0xFF3E1676), // Updated color
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: WatWalletDesignSystem.primaryColor
                                    .withOpacity(0.1),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
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
                                '\$150.00 USD',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 50, // Adjusted to 70 for better positioning
                          left: 0,
                          right: 0,
                          child: Image.asset(
                            imagePath,
                            height:
                                300, // Increase the height to ensure the full image is visible
                            fit: BoxFit
                                .contain, // Ensure the image fits within its bounds
                          ),
                        ),
                      ],
                    );
                  },
                );
              }).toList(),
              options: CarouselOptions(
                height: 300, // Adjusted height to accommodate the full image
                enlargeCenterPage:
                    false, // Ensure only the center item is shown
                viewportFraction: 1.0, // Show only one item at a time
                autoPlay: false,
                onPageChanged: (index, reason) {
                  _onCarouselChanged(index);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _carouselImages.map((url) {
                int index = _carouselImages.indexOf(url);
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
                    child: _buildFeatureCard(Icons.add, 'Top Up'),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildFeatureCard(Icons.credit_card, 'Card Details'),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildFeatureCard(Icons.lock, 'Freeze'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      _buildTab('Transactions', index: 0),
                      _buildTab('Manage Card', index: 1),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _isTabLoading
                      ? _buildShimmerForTabContent()
                      : _activeTabIndex == 0
                          ? _buildTransactionsList()
                          : _buildManageCardContent(),
                ],
              ),
            ),
          ],
        ),
      ),
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
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionsList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.shopping_cart_outlined,
              color: WatWalletDesignSystem.primaryColor),
          title: Text('Transaction Type $index'),
          trailing: const Text('\$12.45'),
        );
      },
    );
  }

  Widget _buildManageCardContent() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          // Handle delete card
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: WatWalletDesignSystem.primaryColor,
        ),
        child: const Text('Delete Card'),
      ),
    );
  }

  Widget _buildShimmerForTabContent() {
    return Shimmer.fromColors(
      baseColor: WatWalletDesignSystem.primaryColor.withOpacity(0.3),
      highlightColor: WatWalletDesignSystem.primaryColor.withOpacity(0.1),
      child: Column(
        children: [
          Container(
            height: 100,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            color: Colors.white,
          ),
          Container(
            height: 100,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
