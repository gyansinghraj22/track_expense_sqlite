import 'package:flutter/material.dart';

const kTextFormFieldDecoration = InputDecoration(
  // labelText: 'Enter Value',
  labelStyle: TextStyle(
    fontSize: 16,
    color: Colors.blueAccent,
    fontWeight: FontWeight.w400,
  ),
  // hintText: 'Type something...',
  hintStyle: TextStyle(
    fontSize: 14,
    color: Colors.grey,
  ),
  filled: true,
  fillColor: Color(0xFFF5F5F5), // Light grey background
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
    borderSide: BorderSide(
      color: Colors.grey,
      width: 1.5,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
    borderSide: BorderSide(
      color: Colors.blueAccent,
      width: 2,
    ),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
    borderSide: BorderSide(
      color: Colors.red,
      width: 1.5,
    ),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
    borderSide: BorderSide(
      color: Colors.redAccent,
      width: 2,
    ),
  ),
  contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
  errorStyle: TextStyle(
    color: Colors.red,
    fontSize: 14,
  ),
);
