import 'package:flutter/material.dart';
import '../utils/deisgn_system.dart';

class TopUpModalSheet extends StatefulWidget {
  const TopUpModalSheet({super.key});

  @override
  _TopUpModalSheetState createState() => _TopUpModalSheetState();
}

class _TopUpModalSheetState extends State<TopUpModalSheet> {
  String? _selectedBank;

  final List<String> _bankAccounts = [
    'Bank of America - **** 1234',
    'Chase Bank - **** 5678',
    'Wells Fargo - **** 9101',
  ];

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Top Up',
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
            const Text(
              'Select a Bank Account',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true, // Makes the list take only needed space
                itemCount:
                    _bankAccounts.length + 1, // +1 for the "Add Bank" option
                itemBuilder: (context, index) {
                  if (index < _bankAccounts.length) {
                    return _buildBankOption(_bankAccounts[index]);
                  } else {
                    return _buildAddBankOption();
                  }
                },
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: _selectedBank != null
                  ? () {
                      // Handle top up action
                    }
                  : null,
              child: Container(
                height: 56,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: _selectedBank != null
                      ? WatWalletDesignSystem.primaryColor
                      : Colors.grey, // Disabled color
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: Text(
                    'Confirm Top Up',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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

  Widget _buildBankOption(String bankName) {
    bool isSelected = _selectedBank == bankName;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedBank = bankName;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected
                ? WatWalletDesignSystem.primaryColor
                : Colors.grey.shade300,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: WatWalletDesignSystem.primaryColor.withOpacity(0.2),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ]
              : [],
        ),
        child: Row(
          children: [
            Icon(
              Icons.account_balance,
              color: WatWalletDesignSystem.primaryColor,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                bankName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: WatWalletDesignSystem.primaryColor,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddBankOption() {
    return GestureDetector(
      onTap: () {
        // Handle add bank action
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade300,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Icon(
              Icons.add,
              color: WatWalletDesignSystem.primaryColor,
            ),
            const SizedBox(width: 16),
            const Text(
              'Add Bank',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: WatWalletDesignSystem.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Freeze Modal Sheet
class FreezeModalSheet extends StatelessWidget {
  const FreezeModalSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Hug content height
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Freeze Card',
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
            Center(
              child: Image.asset(
                'assets/card/card1.png', // Replace with your card image path
                height: 200,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Freeze your card to prevent any unauthorized usage.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () {
                // Handle Freeze Card
              },
              child: Container(
                width: double.infinity,
                height: 56,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: const Color(
                      0xFFEF4444), // Red color similar to Terminate Card
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    'Confirm Freeze',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
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
                  border: Border.all(color: Colors.black),
                ),
                child: const Center(
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
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

// Terminate Card Modal Sheet
class TerminateCardModalSheet extends StatelessWidget {
  const TerminateCardModalSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
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
            const Text(
              'Do you wish to terminate your card?',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Note: This process cannot be undone.',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF5F5F6F),
              ),
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
