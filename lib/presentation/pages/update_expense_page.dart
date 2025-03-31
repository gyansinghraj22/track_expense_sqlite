import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:track_expense/core/constants/app_string.dart';
import 'dart:io';

import 'package:track_expense/data/models/expese_model.dart';
import 'package:track_expense/presentation/bloc/expense_bloc.dart';
import 'package:track_expense/presentation/bloc/expense_event.dart';

class UpdateExpenseForm extends StatefulWidget {
  final ExpenseModel expense;

  const UpdateExpenseForm({super.key, required this.expense});

  @override
  _UpdateExpenseFormState createState() => _UpdateExpenseFormState();
}

class _UpdateExpenseFormState extends State<UpdateExpenseForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _amountController;
  late TextEditingController _descriptionController;

  DateTime? _selectedDate;
  String? _selectedCategory;

  List<String> _categories = [];
  File? _image;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();

    _amountController =
        TextEditingController(text: widget.expense.amount.toString());
    _descriptionController =
        TextEditingController(text: widget.expense.description);
    _selectedDate = widget.expense.date;
    _selectedCategory = widget.expense.categoryId;
    _populateCategories();
  }

  void _populateCategories() {
    _categories = categories;
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No image selected')),
      );
    }
  }

  void _updateForm() {
    if (_formKey.currentState!.validate()) {
      if (_selectedDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a date.')),
        );
        return;
      }
      if (_selectedCategory == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a category.')),
        );
        return;
      }

      final updatedExpense = ExpenseModel(
        expenseId: widget.expense.expenseId,
        categoryId: _selectedCategory!,
        amount: double.parse(_amountController.text),
        date: _selectedDate!,
        description: _descriptionController.text.trim(),
        createdAt: widget.expense.createdAt,
        updatedAt: DateTime.now(),
        billImage: _image?.path ?? widget.expense.billImage,
      );

      context.read<ExpenseBloc>().add(UpdateExpenseEvent(updatedExpense));

      Navigator.pop(context);
      context.read<ExpenseBloc>().add(LoadExpensesEvent());
    }
  }

  void _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Update Expense',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        backgroundColor: Colors.blue.withOpacity(0.4),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Description Field
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: "Description"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // Amount Field
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(labelText: 'Amount'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount.';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // Category Dropdown
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                items: _categories.map((category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                decoration: const InputDecoration(labelText: "Category"),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a category.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // Date Picker
              TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  hintText: _selectedDate == null
                      ? "No Date Selected"
                      : 'Date: ${DateFormat.yMMMd().format(_selectedDate!)}',
                  prefixIcon: IconButton(
                    onPressed: () => _selectDate(context),
                    icon: const Icon(Icons.calendar_today),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Image Picker
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _image != null
                      ? Image.file(
                          _image!,
                          height: 130,
                          fit: BoxFit.cover,
                        )
                      : widget.expense.billImage != null
                          ? Image.file(
                              File(widget.expense.billImage!),
                              height: 130,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              height: 130,
                              color: Colors.grey[300],
                              child: const Icon(Icons.image, size: 100),
                            ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.photo_library),
                    label: const Text('Pick from Gallery'),
                    onPressed: () => _pickImage(ImageSource.gallery),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Take a Photo'),
                    onPressed: () => _pickImage(ImageSource.camera),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Submit Button
              ElevatedButton(
                onPressed: _updateForm,
                child: const Text('Update Expense'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
