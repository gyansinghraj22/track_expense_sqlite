import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track_expense/domain/usecases/create_expense.dart';
import 'package:track_expense/domain/usecases/delete_expense.dart';
import 'package:track_expense/domain/usecases/get_expense.dart';
import 'package:track_expense/domain/usecases/update_expense.dart';



import 'expense_event.dart';
import 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final CreateExpense createExpense;
  final GetExpenses getExpenses;
  final UpdateExpense updateExpense;
  final DeleteExpense deleteExpense;
  // final FetchExpensesByCategory fetchExpensesByCategory;

  ExpenseBloc({
    required this.createExpense,
    required this.getExpenses,
    required this.updateExpense,
    required this.deleteExpense,
    // required this.fetchExpensesByCategory,
  }) : super(ExpenseInitialState()) {
    // Load all expenses
    on<LoadExpensesEvent>((event, emit) async {
      emit(ExpenseLoadingState());
      try {
        final expenses = await getExpenses();
        emit(ExpenseLoadedState(expenses));
      } catch (e) {
        emit(ExpenseErrorState("Failed to load expenses: ${e.toString()}"));
      }
    });

    // Add a new expense
    on<AddExpenseEvent>((event, emit) async {
      emit(ExpenseLoadingState());
      try {
        await createExpense(event.expense);
        emit(ExpenseAddedState(event.expense));
      } catch (e) {
        emit(ExpenseErrorState("Failed to add expense: ${e.toString()}"));
      }
    });

    // Update an existing expense
    on<UpdateExpenseEvent>((event, emit) async {
      emit(ExpenseLoadingState());
      try {
        await updateExpense(event.expense);
        emit(ExpenseUpdatedState(event.expense));
      } catch (e) {
        emit(ExpenseErrorState("Failed to update expense: ${e.toString()}"));
      }
    });

    // Delete an expense
    on<DeleteExpenseEvent>((event, emit) async {
      emit(ExpenseLoadingState());
      try {
        await deleteExpense(event.expenseId);
        emit(ExpenseDeletedState(event.expenseId));
      } catch (e) {
        emit(ExpenseErrorState("Failed to delete expense: ${e.toString()}"));
      }
    });

   
  }
}
