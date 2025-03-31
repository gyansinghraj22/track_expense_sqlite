import 'package:flutter/material.dart';

final Map<String, IconData> categoryIcons = {
  // Essential (Fixed) Expenses
  'Housing': Icons.home,
  'Utilities': Icons.electrical_services,
  'Loan Payments': Icons.credit_card,
  'Insurance': Icons.security,

  // Essential (Variable) Expenses
  'Groceries': Icons.shopping_cart,
  'Transportation': Icons.directions_car,
  'Medical Expenses': Icons.local_hospital,

  // Discretionary (Lifestyle) Expenses
  'Dining Out': Icons.fastfood,
  'Entertainment': Icons.movie,
  'Shopping': Icons.shopping_bag,
  'Hobbies & Leisure': Icons.palette,

  // Financial & Savings
  'Emergency Fund': Icons.savings,
  'Investments': Icons.trending_up,
  'Retirement Savings': Icons.account_balance,
  'Debt Repayments': Icons.money_off,

  // Family & Personal Care
  'Education': Icons.school,
  'Personal Care': Icons.spa,
  'Gifts & Donations': Icons.card_giftcard,

  // Miscellaneous Expenses
  'Subscriptions': Icons.subscriptions,
  'Pet Expenses': Icons.pets,
  'Travel & Vacation': Icons.flight,
  'Unexpected Costs': Icons.warning,
};

const List<String> categories = [
  'Housing',
  'Utilities',
  'Loan Payments',
  'Insurance',
  'Groceries',
  'Transportation',
  'Medical Expenses',
  'Dining Out',
  'Entertainment',
  'Shopping',
  'Hobbies & Leisure',
  'Emergency Fund',
  'Investments',
  'Retirement Savings',
  'Debt Repayments',
  'Education',
  'Personal Care',
  'Gifts & Donations',
  'Subscriptions',
  'Pet Expenses',
  'Travel & Vacation',
  'Unexpected Costs',
];
