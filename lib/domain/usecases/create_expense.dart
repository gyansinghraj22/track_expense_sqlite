import 'package:track_expense/data/models/expese_model.dart';
import 'package:track_expense/domain/repository/expense_repository.dart';


class CreateExpense {
  final ExpenseRepository repository;

  CreateExpense(this.repository);

  Future<void> call(ExpenseModel expense) async {
    await repository.createExpense(expense);
  }
}
