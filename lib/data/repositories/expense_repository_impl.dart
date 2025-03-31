import 'package:track_expense/data/models/expense_summary_model.dart';
import 'package:track_expense/data/models/expese_model.dart';
import 'package:track_expense/database/database_helper.dart';

import '../../domain/entities/expense.dart';
import '../../domain/repository/expense_repository.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  final DatabaseHelper databaseHelper;

  ExpenseRepositoryImpl({required this.databaseHelper});

  @override
  Future<void> createExpense(ExpenseModel expense) async {
    final expenseEntity = ExpenseEntity(
      expenseId: expense.expenseId,
      categoryId: expense.categoryId,
      amount: expense.amount,
      date: expense.date,
      description: expense.description,
      createdAt: expense.createdAt,
      updatedAt: expense.updatedAt,
      billImage: expense.billImage,
    );
    await databaseHelper.insertExpense(expenseEntity);
  }

  @override
  Future<List<ExpenseModel>> getExpenses() async {
    final expenseEntities = await databaseHelper.getExpenses();
    return expenseEntities.map((entity) {
      return ExpenseModel(
        expenseId: entity.expenseId,
        categoryId: entity.categoryId,
        amount: entity.amount,
        date: entity.date,
        description: entity.description,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
        billImage: entity.billImage,
      );
    }).toList();
  }

  @override
  Future<ExpenseModel?> getExpenseById(String expenseId) async {
    final expenses = await databaseHelper.getExpenses();
    final expenseEntity = expenses.firstWhere(
      (expense) => expense.expenseId == expenseId,
      orElse: () => ExpenseEntity(
        expenseId: '',
        categoryId: '',
        amount: 0.0,
        date: DateTime.now(),
        description: '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        billImage: '',
      ),
    );

    return ExpenseModel(
      expenseId: expenseEntity.expenseId,
      categoryId: expenseEntity.categoryId,
      amount: expenseEntity.amount,
      date: expenseEntity.date,
      description: expenseEntity.description,
      createdAt: expenseEntity.createdAt,
      updatedAt: expenseEntity.updatedAt,
      billImage: expenseEntity.billImage,
    );
  }

  @override
  Future<void> updateExpense(ExpenseModel expense) async {
    final expenseEntity = ExpenseEntity(
      expenseId: expense.expenseId,
      categoryId: expense.categoryId,
      amount: expense.amount,
      date: expense.date,
      description: expense.description,
      createdAt: expense.createdAt,
      updatedAt: expense.updatedAt,
      billImage: expense.billImage,
    );
    await databaseHelper.updateExpense(expenseEntity);
  }

  @override
  Future<void> deleteExpense(String expenseId) async {
    await databaseHelper.deleteExpense(expenseId);
  }

  // Fetch expenses for today
  @override
  Future<List<ExpenseModel>> getExpensesForToday() async {
    final expenseEntities = await databaseHelper.getExpensesForToday();
    return expenseEntities.map((entity) {
      return ExpenseModel(
        expenseId: entity.expenseId,
        categoryId: entity.categoryId,
        amount: entity.amount,
        date: entity.date,
        description: entity.description,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
        billImage: entity.billImage,
      );
    }).toList();
  }

  // Fetch expenses for this week
  @override
  Future<List<ExpenseModel>> getExpensesForThisWeek() async {
    final expenseEntities = await databaseHelper.getExpensesForThisWeek();
    return expenseEntities.map((entity) {
      return ExpenseModel(
        expenseId: entity.expenseId,
        categoryId: entity.categoryId,
        amount: entity.amount,
        date: entity.date,
        description: entity.description,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
        billImage: entity.billImage,
      );
    }).toList();
  }

  // Fetch expenses for this month
  @override
  Future<List<ExpenseModel>> getExpensesForThisMonth() async {
    final expenseEntities = await databaseHelper.getExpensesForThisMonth();
    return expenseEntities.map((entity) {
      return ExpenseModel(
        expenseId: entity.expenseId,
        categoryId: entity.categoryId,
        amount: entity.amount,
        date: entity.date,
        description: entity.description,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
        billImage: entity.billImage,
      );
    }).toList();
  }

  // Fetch summary for today
  @override
  Future<ExpenseSummary> getSummaryForToday() async {
    return await databaseHelper.getSummaryForToday();
  }

  // Fetch summary for this week
  @override
  Future<ExpenseSummary> getSummaryForThisWeek() async {
    return await databaseHelper.getSummaryForThisWeek();
  }

  // Fetch summary for this month
  @override
  Future<ExpenseSummary> getSummaryForThisMonth() async {
    return await databaseHelper.getSummaryForThisMonth();
  }
}
