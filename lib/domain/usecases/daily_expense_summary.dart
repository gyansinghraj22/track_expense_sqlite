import 'package:track_expense/data/models/expense_summary_model.dart';
import 'package:track_expense/domain/repository/expense_repository.dart';


class GetSummaryForToday {
  final ExpenseRepository repository;

  GetSummaryForToday(this.repository);

  Future<ExpenseSummary> call() async {
    return await repository.getSummaryForToday();
  }
}