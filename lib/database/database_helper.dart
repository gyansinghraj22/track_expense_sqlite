import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:track_expense/data/models/expense_summary_model.dart';
import '../domain/entities/expense.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'expenses.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE expenses (
            expenseId TEXT PRIMARY KEY,
            categoryId TEXT,
            amount REAL,
            date TEXT,
            updatedAt TEXT,
            createdAt TEXT,
            description TEXT,
            billImage TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertExpense(ExpenseEntity expense) async {
    final db = await database;
    await db.insert(
      'expenses',
      {
        'expenseId': expense.expenseId,
        'categoryId': expense.categoryId,
        'amount': expense.amount,
        'date': expense.date.toIso8601String(),
        'updatedAt': expense.updatedAt.toIso8601String(),
        'createdAt': expense.createdAt.toIso8601String(),
        'description': expense.description,
        'billImage': expense.billImage,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ExpenseEntity>> getExpenses() async {
    final db = await database;
    final result = await db.query('expenses');

    return result.map((json) {
      return ExpenseEntity(
        expenseId: json['expenseId'] as String,
        categoryId: json['categoryId'] as String,
        amount: json['amount'] as double,
        date: DateTime.parse(json['date'] as String),
        updatedAt: DateTime.parse(json['updatedAt'] as String),
        createdAt: DateTime.parse(json['createdAt'] as String),
        description: json['description'] as String,
        billImage: json['billImage'] as String?,
      );
    }).toList();
  }

  Future<void> updateExpense(ExpenseEntity expense) async {
    final db = await database;
    await db.update(
      'expenses',
      {
        'expenseId': expense.expenseId,
        'categoryId': expense.categoryId,
        'amount': expense.amount,
        'date': expense.date.toIso8601String(),
        'updatedAt': expense.updatedAt.toIso8601String(),
        'createdAt': expense.createdAt.toIso8601String(),
        'description': expense.description,
        'billImage': expense.billImage,
      },
      where: 'expenseId = ?',
      whereArgs: [expense.expenseId],
    );
  }

  Future<void> deleteExpense(String expenseId) async {
    final db = await database;
    await db.delete(
      'expenses',
      where: 'expenseId = ?',
      whereArgs: [expenseId],
    );
  }

  // Fetch expenses for today
  Future<List<ExpenseEntity>> getExpensesForToday() async {
    final db = await database;
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day).toIso8601String();
    final todayEnd =
        DateTime(now.year, now.month, now.day, 23, 59, 59).toIso8601String();

    final result = await db.query(
      'expenses',
      where: 'date BETWEEN ? AND ?',
      whereArgs: [todayStart, todayEnd],
    );

    return _mapResultToExpenses(result);
  }

  // Fetch expenses for this week
  Future<List<ExpenseEntity>> getExpensesForThisWeek() async {
    final db = await database;
    final now = DateTime.now();
    final weekStart = now.subtract(
        Duration(days: now.weekday - 1)); // Start of the week (Monday)
    final weekEnd = weekStart.add(const Duration(
        days: 6,
        hours: 23,
        minutes: 59,
        seconds: 59)); // End of the week (Sunday)

    final result = await db.query(
      'expenses',
      where: 'date BETWEEN ? AND ?',
      whereArgs: [weekStart.toIso8601String(), weekEnd.toIso8601String()],
    );

    return _mapResultToExpenses(result);
  }

  // Fetch expenses for this month
  Future<List<ExpenseEntity>> getExpensesForThisMonth() async {
    final db = await database;
    final now = DateTime.now();
    final monthStart = DateTime(now.year, now.month, 1); // Start of the month
    final monthEnd =
        DateTime(now.year, now.month + 1, 0, 23, 59, 59); // End of the month

    final result = await db.query(
      'expenses',
      where: 'date BETWEEN ? AND ?',
      whereArgs: [monthStart.toIso8601String(), monthEnd.toIso8601String()],
    );

    return _mapResultToExpenses(result);
  }

  List<ExpenseEntity> _mapResultToExpenses(List<Map<String, dynamic>> result) {
    return result.map((json) {
      return ExpenseEntity(
        expenseId: json['expenseId'] as String,
        categoryId: json['categoryId'] as String,
        amount: json['amount'] as double,
        date: DateTime.parse(json['date'] as String),
        updatedAt: DateTime.parse(json['updatedAt'] as String),
        createdAt: DateTime.parse(json['createdAt'] as String),
        description: json['description'] as String,
        billImage: json['billImage'] as String?,
      );
    }).toList();
  }

  // Get summary for today
  Future<ExpenseSummary> getSummaryForToday() async {
    final db = await database;
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day).toIso8601String();
    final todayEnd =
        DateTime(now.year, now.month, now.day, 23, 59, 59).toIso8601String();

    final result = await db.query(
      'expenses',
      where: 'date BETWEEN ? AND ?',
      whereArgs: [todayStart, todayEnd],
    );

    return _calculateSummary(result);
  }

  // Get summary for this week
  Future<ExpenseSummary> getSummaryForThisWeek() async {
    final db = await database;
    final now = DateTime.now();

    // Calculate the start and end of the current week
    final weekStart = DateTime(now.year, now.month, now.day).subtract(
      Duration(days: now.weekday - 1), // Start of the week (Monday)
    );
    final weekEnd = weekStart.add(
      // ignore: prefer_const_constructors
      Duration(
          days: 6,
          hours: 23,
          minutes: 59,
          seconds: 59), // End of the week (Sunday)
    );

    // Query the database for expenses within the week
    final result = await db.query(
      'expenses',
      where: 'date BETWEEN ? AND ?',
      whereArgs: [weekStart.toIso8601String(), weekEnd.toIso8601String()],
    );

    // Calculate and return the summary
    return _calculateSummary(result);
  }

  // Get summary for this month
  Future<ExpenseSummary> getSummaryForThisMonth() async {
    final db = await database;
    final now = DateTime.now();
    final monthStart = DateTime(now.year, now.month, 1); // Start of the month
    final monthEnd =
        DateTime(now.year, now.month + 1, 0, 23, 59, 59); // End of the month

    final result = await db.query(
      'expenses',
      where: 'date BETWEEN ? AND ?',
      whereArgs: [monthStart.toIso8601String(), monthEnd.toIso8601String()],
    );

    return _calculateSummary(result);
  }

  // Helper method to calculate summary
  ExpenseSummary _calculateSummary(List<Map<String, dynamic>> result) {
    final totalExpenses = result.length;

    if (totalExpenses == 0) {
      return ExpenseSummary(
        totalExpenses: 0,
        totalAmount: 0.0,
        totalCategories: 0,
        averageExpense: 0.0,
        highestExpense: 0.0,
        lowestExpense: 0.0,
      );
    }

    final totalAmount = result.fold<double>(
      0.0,
      (sum, expense) => sum + (expense['amount'] as double),
    );

    final uniqueCategories =
        result.map((expense) => expense['categoryId'] as String).toSet().length;

    final amounts =
        result.map((expense) => expense['amount'] as double).toList();
    final highestExpense = amounts.reduce((a, b) => a > b ? a : b);
    final lowestExpense = amounts.reduce((a, b) => a < b ? a : b);
    final averageExpense = totalAmount / totalExpenses;

    return ExpenseSummary(
      totalExpenses: totalExpenses,
      totalAmount: totalAmount,
      totalCategories: uniqueCategories,
      averageExpense: averageExpense,
      highestExpense: highestExpense,
      lowestExpense: lowestExpense,
    );
  }
}
