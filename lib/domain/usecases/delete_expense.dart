import '../repository/expense_repository.dart';

class DeleteExpense {
  final ExpenseRepository repository;

  DeleteExpense(this.repository);

  Future<void> call(String expenseId) async {
    await repository.deleteExpense(expenseId);
  }
}