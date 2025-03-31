import 'package:track_expense/data/models/expese_model.dart';
import 'package:track_expense/domain/repository/expense_repository.dart';


class GetExpenses {
  final ExpenseRepository repository;

  GetExpenses(this.repository);

  Future<List<ExpenseModel>> call() async {
    return await repository.getExpenses();
  }
}
