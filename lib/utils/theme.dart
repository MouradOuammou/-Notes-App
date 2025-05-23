import 'package:flutter/material.dart';

class Themes {
  final ThemeData lightTheme = ThemeData.light().copyWith(
    colorScheme: ColorScheme.light(
      surface: Colors.grey.shade300,
      secondary: Colors.tealAccent.shade700,
    ),
    primaryColor: Colors.orange,
    iconTheme: const IconThemeData(
      color: Colors.black,
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.black,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      foregroundColor: Colors.black,
      backgroundColor: Colors.grey.shade300,
    ),
  );


}
