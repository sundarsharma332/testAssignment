import 'package:flutter/material.dart';

class TransactionsListComponent extends StatelessWidget {
  const TransactionsListComponent({super.key});

  @override
  Widget build(BuildContext context) {
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
}

class ManageCardContentComponent extends StatelessWidget {
  final Function() onTerminateTap;

  const ManageCardContentComponent({
    super.key,
    required this.onTerminateTap,
  });

  @override
  Widget build(BuildContext context) {
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
          onTap: item['title'] == 'Terminate Card' ? onTerminateTap : null,
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
}
