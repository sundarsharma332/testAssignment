import 'package:flutter/material.dart';
import '../utils/deisgn_system.dart';
import 'tab_content_component.dart';
import 'topup_freeze_modals_component.dart';

class BottomModalSheetComponent extends StatelessWidget {
  final int activeTabIndex;
  final bool isTabLoading;
  final Function(int) onTabTap;

  const BottomModalSheetComponent({
    super.key,
    required this.activeTabIndex,
    required this.isTabLoading,
    required this.onTabTap,
  });

  void _openTerminateCardModalSheet(BuildContext context) {
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
                    child: isTabLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: WatWalletDesignSystem.primaryColor,
                            ),
                          )
                        : activeTabIndex == 0
                            ? const TransactionsListComponent()
                            : ManageCardContentComponent(
                                onTerminateTap: () =>
                                    _openTerminateCardModalSheet(context),
                              ),
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
    bool isActive = activeTabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => onTabTap(index),
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
}
