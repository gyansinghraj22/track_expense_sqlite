
import 'package:equatable/equatable.dart';
import 'package:track_expense/data/models/expese_model.dart';

abstract class ExpenseEvent extends Equatable {
  const ExpenseEvent();

  @override
  List<Object?> get props => [];
}

class LoadExpensesEvent extends ExpenseEvent {}

class AddExpenseEvent extends ExpenseEvent {
  final ExpenseModel expense;

  const AddExpenseEvent(this.expense);

  @override
  List<Object?> get props => [expense];
}

class UpdateExpenseEvent extends ExpenseEvent {
  final ExpenseModel expense;

  const UpdateExpenseEvent(this.expense);

  @override
  List<Object?> get props => [expense];
}

class FetchExpensesByCategoryEvent extends ExpenseEvent {
  final String categoryId;

  const FetchExpensesByCategoryEvent(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}

class DeleteExpenseEvent extends ExpenseEvent {
  final String expenseId;

  const DeleteExpenseEvent(this.expenseId);

  @override
  List<Object?> get props => [expenseId];
}
