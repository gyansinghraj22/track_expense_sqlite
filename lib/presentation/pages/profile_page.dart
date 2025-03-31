// import 'package:flutter/material.dart';
// import 'package:localexpense/data/models/expense_summary_model.dart';
// import 'package:localexpense/domain/usecases/daily_expense_summary.dart';
// import 'package:localexpense/domain/usecases/weekly_expense_summary.dart';
// import 'package:localexpense/domain/usecases/monthly_expense_summary.dart';

// class ProfilePage extends StatefulWidget {
//   final GetSummaryForToday getSummaryForToday;
//   final GetSummaryForThisWeek getSummaryForThisWeek;
//   final GetSummaryForThisMonth getSummaryForThisMonth;

//   const ProfilePage({
//     Key? key,
//     required this.getSummaryForToday,
//     required this.getSummaryForThisWeek,
//     required this.getSummaryForThisMonth,
//   }) : super(key: key);

//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   late Future<ExpenseSummary> _todaySummary;
//   late Future<ExpenseSummary> _weekSummary;
//   late Future<ExpenseSummary> _monthSummary;

//   @override
//   void initState() {
//     super.initState();
//     _refreshSummaries();
//   }

//   void _refreshSummaries() {
//     setState(() {
//       _todaySummary = widget.getSummaryForToday();
//       _weekSummary = widget.getSummaryForThisWeek();
//       _monthSummary = widget.getSummaryForThisMonth();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Profile"),
//       ),
//       body: RefreshIndicator(
//         onRefresh: () async {
//           _refreshSummaries();
//         },
//         child: SingleChildScrollView(
//           physics: const AlwaysScrollableScrollPhysics(),
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   "Expense Summary",
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 _buildSummarySection(
//                   title: "Today's Summary",
//                   future: _todaySummary,
//                 ),
//                 const SizedBox(height: 16),
//                 _buildSummarySection(
//                   title: "This Week's Summary",
//                   future: _weekSummary,
//                 ),
//                 const SizedBox(height: 16),
//                 _buildSummarySection(
//                   title: "This Month's Summary",
//                   future: _monthSummary,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSummarySection({
//     required String title,
//     required Future<ExpenseSummary> future,
//   }) {
//     return Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               title,
//               style: const TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 12),
//             FutureBuilder<ExpenseSummary>(
//               future: future,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 } else if (snapshot.hasError) {
//                   return Center(
//                     child: Text("Error: ${snapshot.error}"),
//                   );
//                 } else if (snapshot.hasData) {
//                   final summary = snapshot.data!;
//                   return _buildSummaryDetails(summary);
//                 } else {
//                   return const Center(
//                     child: Text("No data available."),
//                   );
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSummaryDetails(ExpenseSummary summary) {
//     return Column(
//       children: [
//         _buildSummaryTile(
//           title: "Total Expenses",
//           value: summary.totalExpenses.toString(),
//         ),
//         _buildSummaryTile(
//           title: "Total Amount",
//           value: "\$${summary.totalAmount.toStringAsFixed(2)}",
//         ),
//         _buildSummaryTile(
//           title: "Total Categories",
//           value: summary.totalCategories.toString(),
//         ),
//         _buildSummaryTile(
//           title: "Average Expense",
//           value: "\$${summary.averageExpense.toStringAsFixed(2)}",
//         ),
//         _buildSummaryTile(
//           title: "Highest Expense",
//           value: "\$${summary.highestExpense.toStringAsFixed(2)}",
//         ),
//         _buildSummaryTile(
//           title: "Lowest Expense",
//           value: "\$${summary.lowestExpense.toStringAsFixed(2)}",
//         ),
//       ],
//     );
//   }

//   Widget _buildSummaryTile({required String title, required String value}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             title,
//             style: const TextStyle(fontSize: 16),
//           ),
//           Text(
//             value,
//             style: const TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:track_expense/data/models/expense_summary_model.dart';
import 'package:track_expense/domain/usecases/daily_expense_summary.dart';
import 'package:track_expense/domain/usecases/monthly_expense_summary.dart';
import 'package:track_expense/domain/usecases/weekly_expense_summary.dart';

class ProfilePage extends StatefulWidget {
  final GetSummaryForToday getSummaryForToday;
  final GetSummaryForThisWeek getSummaryForThisWeek;
  final GetSummaryForThisMonth getSummaryForThisMonth;

  const ProfilePage({
    super.key,
    required this.getSummaryForToday,
    required this.getSummaryForThisWeek,
    required this.getSummaryForThisMonth,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<ExpenseSummary> _currentSummary;
  String _selectedTab = "Day"; // Default tab is "Day"

  @override
  void initState() {
    super.initState();
    _updateSummary(); // Initialize with today's summary
  }

  void _updateSummary() {
    setState(() {
      if (_selectedTab == "Day") {
        _currentSummary = widget.getSummaryForToday();
      } else if (_selectedTab == "Week") {
        _currentSummary = widget.getSummaryForThisWeek();
      } else if (_selectedTab == "Month") {
        _currentSummary = widget.getSummaryForThisMonth();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Column(
        children: [
          // Tab Buttons
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTabButton("Day"),
                _buildTabButton("Week"),
                _buildTabButton("Month"),
              ],
            ),
          ),
          // Summary Section
          Expanded(
            child: FutureBuilder<ExpenseSummary>(
              future: _currentSummary,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("Error: ${snapshot.error}"),
                  );
                } else if (snapshot.hasData) {
                  final summary = snapshot.data!;
                  return _buildSummaryDetails(summary);
                } else {
                  return const Center(
                    child: Text("No data available."),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String tab) {
    final isSelected = _selectedTab == tab;
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _selectedTab = tab;
          _updateSummary(); // Update the summary based on the selected tab
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.blue : Colors.grey[300],
        foregroundColor: isSelected ? Colors.white : Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(tab),
    );
  }

  Widget _buildSummaryDetails(ExpenseSummary summary) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSummaryTile(
            title: "Total Expenses",
            value: summary.totalExpenses.toString(),
          ),
          _buildSummaryTile(
            title: "Total Amount",
            value: "\$${summary.totalAmount.toStringAsFixed(2)}",
          ),
          _buildSummaryTile(
            title: "Total Categories",
            value: summary.totalCategories.toString(),
          ),
          _buildSummaryTile(
            title: "Average Expense",
            value: "\$${summary.averageExpense.toStringAsFixed(2)}",
          ),
          _buildSummaryTile(
            title: "Highest Expense",
            value: "\$${summary.highestExpense.toStringAsFixed(2)}",
          ),
          _buildSummaryTile(
            title: "Lowest Expense",
            value: "\$${summary.lowestExpense.toStringAsFixed(2)}",
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryTile({required String title, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
