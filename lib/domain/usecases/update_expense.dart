import 'package:track_expense/data/models/expese_model.dart';
import 'package:track_expense/domain/repository/expense_repository.dart';

class UpdateExpense {
  final ExpenseRepository repository;

  UpdateExpense(this.repository);

  Future<void> call(ExpenseModel expense) async {
    await repository.updateExpense(expense);
  }
}