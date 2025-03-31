// import 'package:expense_tracker/features/data/models/expense_model.dart';

class ExpenseEntity {
  final String expenseId;
  final String categoryId;
  final double amount;
  final DateTime date;
  final DateTime updatedAt;
  final DateTime createdAt;
  final String description;
  final String? billImage; // Nullable field

  ExpenseEntity({
    required this.expenseId,
    required this.categoryId,
    required this.amount,
    required this.date,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    this.billImage, // Nullable field
  });
}
