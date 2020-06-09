import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OurTheme {
  Color _lightgreen = Color.fromARGB(255, 213, 235, 220);
  Color _lightgrey = Color.fromARGB(255, 164, 164, 164);
  Color _darkgrey = Color.fromARGB(255, 119, 124, 135);
  Color _Teal = Color.fromARGB(255, 116, 242, 206);

  ThemeData buildTheme() {
    return ThemeData(
      canvasColor: _lightgreen,
      primaryColor: _lightgreen,
      accentColor: _lightgrey,
      secondaryHeaderColor: _darkgrey,
      hintColor: _lightgrey,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: _lightgrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: _lightgreen),
        ),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.greenAccent,
        padding: EdgeInsets.symmetric(horizontal: 10),
        minWidth: 160,
        height: 40.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
