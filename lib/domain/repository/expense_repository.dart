import 'package:track_expense/data/models/expense_summary_model.dart';
import 'package:track_expense/data/models/expese_model.dart';

abstract class ExpenseRepository {
  Future<void> createExpense(ExpenseModel expense);
  Future<List<ExpenseModel>> getExpenses();
  Future<ExpenseModel?> getExpenseById(String expenseId);
  Future<void> updateExpense(ExpenseModel expense);
  Future<void> deleteExpense(String expenseId);

  // Fetch expenses for today
  Future<List<ExpenseModel>> getExpensesForToday();

  // Fetch expenses for this week
  Future<List<ExpenseModel>> getExpensesForThisWeek();

  // Fetch expenses for this month
  Future<List<ExpenseModel>> getExpensesForThisMonth();

// Fetch summary for today
  Future<ExpenseSummary> getSummaryForToday();

  // Fetch summary for this week
  Future<ExpenseSummary> getSummaryForThisWeek();

  // Fetch summary for this month
  Future<ExpenseSummary> getSummaryForThisMonth();
}
