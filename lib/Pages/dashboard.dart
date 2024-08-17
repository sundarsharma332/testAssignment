import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_assignment/utils/deisgn_system.dart'; // Ensure this path is correct
import 'home_page.dart';
import 'settings.dart';
import 'transaction_page.dart';
import 'market_page.dart';
import 'messenger_page.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    TransactionsPage(),
    MarketPage(),
    MessengerPage(),
    SettingsPage(),
  ];

  void _onNavBarTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: SvgPicture.asset(
          'assets/logo/logo.svg',
          height: 24,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Container(
              height: 22,
              width: 22,
              decoration: BoxDecoration(
                color: WatWalletDesignSystem.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Icon(
                  Icons.help,
                  color: WatWalletDesignSystem.primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
        currentIndex: _currentIndex,
        selectedItemColor: WatWalletDesignSystem.primaryColor,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        onTap: _onNavBarTap,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined),
            label: 'Transactions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart_outlined),
            label: 'Market',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message_outlined),
            label: 'Messenger',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
