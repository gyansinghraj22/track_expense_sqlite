import 'package:flutter/material.dart';
import 'package:track_expense/domain/usecases/daily_expense_summary.dart';
import 'package:track_expense/domain/usecases/monthly_expense_summary.dart';
import 'package:track_expense/domain/usecases/weekly_expense_summary.dart';
import 'package:track_expense/presentation/pages/add_expense.dart';
import 'package:track_expense/presentation/pages/expense_page.dart';
import 'package:track_expense/presentation/pages/profile_page.dart';

class HomePage extends StatefulWidget {
  final GetSummaryForToday getSummaryForToday;
  final GetSummaryForThisWeek getSummaryForThisWeek;
  final GetSummaryForThisMonth getSummaryForThisMonth;

  const HomePage({
    super.key,
    required this.getSummaryForToday,
    required this.getSummaryForThisWeek,
    required this.getSummaryForThisMonth,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      const ExpensePage(), // Expense Page
      const AddExpenseForm(), // Add Expense Page
      ProfilePage(
        getSummaryForToday: widget.getSummaryForToday,
        getSummaryForThisWeek: widget.getSummaryForThisWeek,
        getSummaryForThisMonth: widget.getSummaryForThisMonth,
      ), // Profile Page
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    List<NavItem> navItems = [
      NavItem(icon: Icons.home, label: "Expenses"),
      NavItem(icon: Icons.add, label: "Add Expense"),
      NavItem(icon: Icons.person, label: "Profile"),
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(navItems.length, (index) {
          bool isSelected = index == currentIndex;
          return GestureDetector(
            onTap: () => onTap(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? Colors.blueAccent : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Icon(
                    navItems[index].icon,
                    color: isSelected ? Colors.white : Colors.grey[400],
                    size: isSelected ? 28 : 24,
                  ),
                  AnimatedOpacity(
                    opacity: isSelected ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        isSelected ? navItems[index].label : "",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class NavItem {
  final IconData icon;
  final String label;
  NavItem({required this.icon, required this.label});
}
