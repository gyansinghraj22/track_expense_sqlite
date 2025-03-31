import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track_expense/domain/usecases/daily_expense_summary.dart';
import 'package:track_expense/domain/usecases/get_expense.dart';
import 'package:track_expense/domain/usecases/monthly_expense_summary.dart';
import 'package:track_expense/domain/usecases/weekly_expense_summary.dart';
import 'package:track_expense/presentation/pages/home_page.dart';

import 'data/repositories/expense_repository_impl.dart';
import 'database/database_helper.dart';
import 'domain/usecases/create_expense.dart';
import 'domain/usecases/update_expense.dart';
import 'domain/usecases/delete_expense.dart';
import 'presentation/bloc/expense_bloc.dart';

void main() {
  final databaseHelper = DatabaseHelper();
  final expenseRepository =
      ExpenseRepositoryImpl(databaseHelper: databaseHelper);

  runApp(MyApp(
    createExpense: CreateExpense(expenseRepository),
    getExpenses: GetExpenses(expenseRepository),
    updateExpense: UpdateExpense(expenseRepository),
    deleteExpense: DeleteExpense(expenseRepository),
    getSummaryForToday: GetSummaryForToday(expenseRepository),
    getSummaryForThisWeek: GetSummaryForThisWeek(expenseRepository),
    getSummaryForThisMonth: GetSummaryForThisMonth(expenseRepository),
    // fetchExpensesByCategory: FetchExpensesByCategory(expenseRepository),
  ));
}

class MyApp extends StatelessWidget {
  final CreateExpense createExpense;
  final GetExpenses getExpenses;
  final UpdateExpense updateExpense;
  final DeleteExpense deleteExpense;
  // final FetchExpensesByCategory fetchExpensesByCategory;

  final GetSummaryForToday getSummaryForToday;
  final GetSummaryForThisWeek getSummaryForThisWeek;
  final GetSummaryForThisMonth getSummaryForThisMonth;

  const MyApp({
    super.key,
    required this.createExpense,
    required this.getExpenses,
    required this.updateExpense,
    required this.deleteExpense,
    // required this.fetchExpensesByCategory,r

    required this.getSummaryForToday,
    required this.getSummaryForThisWeek,
    required this.getSummaryForThisMonth,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ExpenseBloc(
            createExpense: createExpense,
            getExpenses: getExpenses,
            updateExpense: updateExpense,
            deleteExpense: deleteExpense,
            // fetchExpensesByCategory: fetchExpensesByCategory,
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Expense Tracker',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: HomePage(
          getSummaryForToday: getSummaryForToday,
          getSummaryForThisWeek: getSummaryForThisWeek,
          getSummaryForThisMonth: getSummaryForThisMonth,
        ),
      ),
    );
  }
}
