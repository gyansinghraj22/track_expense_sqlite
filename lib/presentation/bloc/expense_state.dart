import 'package:equatable/equatable.dart';
import 'package:track_expense/data/models/expese_model.dart';

abstract class ExpenseState extends Equatable {
  const ExpenseState();

  @override
  List<Object?> get props => [];
}

class ExpenseInitialState extends ExpenseState {}

class ExpenseLoadingState extends ExpenseState {}

class ExpenseLoadedState extends ExpenseState {
  final List<ExpenseModel> expenses; // Make sure this is ExpenseModel not ExpenseEntity

  const ExpenseLoadedState(this.expenses);

  @override
  List<Object?> get props => [expenses];
}

class ExpenseErrorState extends ExpenseState {
  final String message;

  const ExpenseErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class ExpenseAddedState extends ExpenseState {
  final ExpenseModel expense; // Make sure this is ExpenseModel not ExpenseEntity

  const ExpenseAddedState(this.expense);

  @override
  List<Object?> get props => [expense];
}

class ExpenseUpdatedState extends ExpenseState {
  final ExpenseModel expense; // Make sure this is ExpenseModel not ExpenseEntity

  const ExpenseUpdatedState(this.expense);

  @override
  List<Object?> get props => [expense];
}

class ExpenseDeletedState extends ExpenseState {
  final String expenseId;

  const ExpenseDeletedState(this.expenseId);

  @override
  List<Object?> get props => [expenseId];
}
