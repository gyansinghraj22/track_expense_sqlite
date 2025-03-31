class ExpenseSummary {
  final int totalExpenses;
  final double totalAmount;
  final int totalCategories;
  final double averageExpense;
  final double highestExpense;
  final double lowestExpense;

  ExpenseSummary({
    required this.totalExpenses,
    required this.totalAmount,
    required this.totalCategories,
    required this.averageExpense,
    required this.highestExpense,
    required this.lowestExpense,
  });

  // Factory method to create an instance from a Map
  factory ExpenseSummary.fromMap(Map<String, dynamic> map) {
    return ExpenseSummary(
      totalExpenses: map['totalExpenses'] ?? 0,
      totalAmount: (map['totalAmount'] as num?)?.toDouble() ?? 0.0,
      totalCategories: map['totalCategories'] ?? 0,
      averageExpense: (map['averageExpense'] as num?)?.toDouble() ?? 0.0,
      highestExpense: (map['highestExpense'] as num?)?.toDouble() ?? 0.0,
      lowestExpense: (map['lowestExpense'] as num?)?.toDouble() ?? 0.0,
    );
  }

  // Factory method to create an instance from a JSON object
  factory ExpenseSummary.fromJson(Map<String, dynamic> json) {
    return ExpenseSummary(
      totalExpenses: json['totalExpenses'] ?? 0,
      totalAmount: (json['totalAmount'] as num?)?.toDouble() ?? 0.0,
      totalCategories: json['totalCategories'] ?? 0,
      averageExpense: (json['averageExpense'] as num?)?.toDouble() ?? 0.0,
      highestExpense: (json['highestExpense'] as num?)?.toDouble() ?? 0.0,
      lowestExpense: (json['lowestExpense'] as num?)?.toDouble() ?? 0.0,
    );
  }

  // Method to convert an instance to a Map
  Map<String, dynamic> toMap() {
    return {
      'totalExpenses': totalExpenses,
      'totalAmount': totalAmount,
      'totalCategories': totalCategories,
      'averageExpense': averageExpense,
      'highestExpense': highestExpense,
      'lowestExpense': lowestExpense,
    };
  }

  // Method to convert an instance to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'totalExpenses': totalExpenses,
      'totalAmount': totalAmount,
      'totalCategories': totalCategories,
      'averageExpense': averageExpense,
      'highestExpense': highestExpense,
      'lowestExpense': lowestExpense,
    };
  }
}