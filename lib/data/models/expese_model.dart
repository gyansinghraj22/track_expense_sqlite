class ExpenseModel {
  final String expenseId;  final String categoryId;
  final double amount;
  final DateTime date;
  final String description;
  final String? billImage; // Nullable field
  final DateTime createdAt;
  final DateTime updatedAt;

  ExpenseModel({
    required this.expenseId,
    required this.categoryId,
    required this.amount,
    required this.date,
    required this.description,
    this.billImage, // Nullable field
    required this.createdAt,
    required this.updatedAt,
  });

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      expenseId: map['expenseId'] ?? "",
      categoryId: map['categoryId'] ?? "",
      amount: (map['amount'] as num).toDouble(),
      date: DateTime.parse(map['date'] ?? ""),
      description: map['description'] ?? "",
      billImage: map['billImage'], // Nullable field
      createdAt: DateTime.parse(map['createdAt'] ?? ""),
      updatedAt: DateTime.parse(map['updatedAt'] ?? ""),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'expenseId': expenseId,
      'categoryId': categoryId,
      'amount': amount,
      'date': date.toIso8601String(),
      'description': description,
      'billImage': billImage,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      expenseId: json['_id'] ?? "",
      categoryId: json['categoryId'] ?? "",
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date'] ?? ""),
      description: json['description'] ?? "",
      createdAt: DateTime.parse(json['createdAt'] ?? ""),
      updatedAt: DateTime.parse(json['updatedAt'] ?? ""),
      billImage: json['billImage'], // Nullable field
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'expenseId': expenseId,
      'categoryId': categoryId,
      'amount': amount,
      'date': date.toIso8601String(),
      'description': description,
      'billImage': billImage,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
