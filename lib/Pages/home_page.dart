import 'package:flutter/material.dart';
import '../components/carousel_slider_component.dart';
import '../components/feature_card_component.dart';
import '../components/bottom_modal_sheet_component.dart';
import '../components/topup_freeze_modals_component.dart';
import '../repositories/carousel_repository.dart';
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

  final CarouselRepository _carouselRepository = CarouselRepository();

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

  void _openCardDetailsPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CardDetailsPage()),
    );
  }

  void _openTopUpModalSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => const TopUpModalSheet(),
    );
  }

  void _openFreezeModalSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => const FreezeModalSheet(),
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
                CarouselSliderComponent(
                  carouselData: _carouselRepository.carouselData,
                  onCarouselChanged: _onCarouselChanged,
                  currentIndex: _currentIndex,
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: FeatureCardComponent(
                          icon: Icons.add,
                          label: 'Top Up',
                          onTap: _openTopUpModalSheet,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: FeatureCardComponent(
                          icon: Icons.credit_card,
                          label: 'Card Details',
                          onTap: _openCardDetailsPage,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: FeatureCardComponent(
                          icon: Icons.lock,
                          label: 'Freeze',
                          onTap: _openFreezeModalSheet,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          BottomModalSheetComponent(
            activeTabIndex: _activeTabIndex,
            isTabLoading: _isTabLoading,
            onTabTap: _onTabTap,
          ),
        ],
      ),
    );
  }
}
