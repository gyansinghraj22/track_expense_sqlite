// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:localexpense/presentation/pages/add_expense.dart';
// import 'package:localexpense/presentation/pages/expense_details_page.dart';
// import 'package:localexpense/presentation/pages/update_expense_page.dart';
// import 'package:localexpense/presentation/pages/expense_item.dart';
// import '../bloc/expense_bloc.dart';
// import '../bloc/expense_event.dart';
// import '../bloc/expense_state.dart';

// class ExpensePage extends StatefulWidget {
//   const ExpensePage({super.key});

//   @override
//   State<ExpensePage> createState() => _ExpensePageState();
// }

// class _ExpensePageState extends State<ExpensePage> {
//   @override
//   void initState() {
//     super.initState();
//     // Dispatch LoadExpensesEvent to load all expenses when the page opens
//     context.read<ExpenseBloc>().add(LoadExpensesEvent());
//   }

//   Future<void> _refreshExpenses() async {
//     // Dispatch LoadExpensesEvent to reload expenses
//     context.read<ExpenseBloc>().add(LoadExpensesEvent());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Expense Tracker"),
//       ),
//       body: BlocConsumer<ExpenseBloc, ExpenseState>(
//         listener: (context, state) {
//           if (state is ExpenseErrorState) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text(state.message)),
//             );
//           } else if (state is ExpenseAddedState) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text("Expense added successfully!")),
//             );
//           } else if (state is ExpenseUpdatedState) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text("Expense updated successfully!")),
//             );
//           } else if (state is ExpenseDeletedState) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text("Expense deleted successfully!")),
//             );
//           }
//         },
//         builder: (context, state) {
//           if (state is ExpenseLoadingState) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is ExpenseLoadedState) {
//             final expenses = state.expenses;
//             return RefreshIndicator(
//               onRefresh: _refreshExpenses, // Pull-to-refresh callback
//               child: ListView.builder(
//                 itemCount: expenses.length,
//                 itemBuilder: (context, index) {
//                   final expense = expenses[index];
//                   return ExpenseItem(
//                     expense: expense,
//                     onTap: () {
//                       // Navigate to ExpenseDetailScreen
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => ExpenseDetailScreen(
//                             expense: expense,
//                           ),
//                         ),
//                       );
//                     },
//                     onEdit: () {
//                       // Navigate to UpdateExpenseForm for editing
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => BlocProvider.value(
//                             value: context.read<ExpenseBloc>(),
//                             child: UpdateExpenseForm(
//                               expense: expense, // Pass the expense to edit
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                     onDelete: () {
//                       // Dispatch DeleteExpenseEvent
//                       context
//                           .read<ExpenseBloc>()
//                           .add(DeleteExpenseEvent(expense.expenseId));
//                     },
//                   );
//                 },
//               ),
//             );
//           } else if (state is ExpenseInitialState) {
//             context.read<ExpenseBloc>().add(LoadExpensesEvent());
//             return const Center(child: Text("Loading expenses..."));
//           } else {
//             return const Center(child: Text("No expenses found."));
//           }
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => BlocProvider.value(
//                 value: context.read<ExpenseBloc>(),
//                 child: AddExpenseForm(),
//               ),
//             ),
//           );
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track_expense/data/models/expese_model.dart';
import 'package:track_expense/presentation/bloc/expense_bloc.dart';
import 'package:track_expense/presentation/bloc/expense_event.dart';
import 'package:track_expense/presentation/bloc/expense_state.dart';
import 'package:track_expense/presentation/pages/add_expense.dart';
import 'package:track_expense/presentation/pages/expense_details_page.dart';
import 'package:track_expense/presentation/pages/expense_item.dart';
import 'package:track_expense/presentation/pages/update_expense_page.dart';

class ExpensePage extends StatefulWidget {
  const ExpensePage({super.key});

  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    // Load all expenses when the page opens
    context.read<ExpenseBloc>().add(LoadExpensesEvent());
  }

  Future<void> _refreshExpenses() async {
    // Dispatch LoadExpensesEvent to reload expenses
    context.read<ExpenseBloc>().add(LoadExpensesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker"),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "Today"),
            Tab(text: "This Week"),
            Tab(text: "This Month"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildExpenseList(context, FilterType.today),
          _buildExpenseList(context, FilterType.thisWeek),
          _buildExpenseList(context, FilterType.thisMonth),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                value: context.read<ExpenseBloc>(),
                child: const AddExpenseForm(),
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildExpenseList(BuildContext context, FilterType filterType) {
    return BlocConsumer<ExpenseBloc, ExpenseState>(
      listener: (context, state) {
        if (state is ExpenseErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is ExpenseAddedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Expense added successfully!")),
          );
        } else if (state is ExpenseUpdatedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Expense updated successfully!")),
          );
        } else if (state is ExpenseDeletedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Expense deleted successfully!")),
          );
        }
      },
      builder: (context, state) {
        if (state is ExpenseLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ExpenseLoadedState) {
          final expenses = _filterExpenses(state.expenses, filterType);
          if (expenses.isEmpty) {
            return const Center(child: Text("No expenses found."));
          }
          return RefreshIndicator(
            onRefresh: _refreshExpenses, // Pull-to-refresh callback
            child: ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                final expense = expenses[index];
                return ExpenseItem(
                  expense: expense,
                  onTap: () {
                    // Navigate to ExpenseDetailScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExpenseDetailScreen(
                          expense: expense,
                        ),
                      ),
                    );
                  },
                  onEdit: () {
                    // Navigate to UpdateExpenseForm for editing
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider.value(
                          value: context.read<ExpenseBloc>(),
                          child: UpdateExpenseForm(
                            expense: expense, // Pass the expense to edit
                          ),
                        ),
                      ),
                    );
                  },
                  onDelete: () {
                    // Dispatch DeleteExpenseEvent
                    context
                        .read<ExpenseBloc>()
                        .add(DeleteExpenseEvent(expense.expenseId));
// Reload the expenses
                    context.read<ExpenseBloc>().add(LoadExpensesEvent());
                  },
                );
              },
            ),
          );
        } else {
          return const Center(child: Text("No expenses found."));
        }
      },
    );
  }

  List<ExpenseModel> _filterExpenses(
      List<ExpenseModel> expenses, FilterType filterType) {
    final now = DateTime.now();
    if (filterType == FilterType.today) {
      return expenses.where((expense) {
        return expense.date.year == now.year &&
            expense.date.month == now.month &&
            expense.date.day == now.day;
      }).toList();
    } else if (filterType == FilterType.thisWeek) {
      final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
      final endOfWeek = startOfWeek.add(const Duration(days: 6));
      return expenses.where((expense) {
        return expense.date
                .isAfter(startOfWeek.subtract(const Duration(days: 1))) &&
            expense.date.isBefore(endOfWeek.add(const Duration(days: 1)));
      }).toList();
    } else if (filterType == FilterType.thisMonth) {
      return expenses.where((expense) {
        return expense.date.year == now.year && expense.date.month == now.month;
      }).toList();
    }
    return [];
  }
}

enum FilterType { today, thisWeek, thisMonth }
