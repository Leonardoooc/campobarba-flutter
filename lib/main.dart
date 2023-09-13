import 'package:flutter/material.dart';
import 'package:campobarba/home.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        fontFamily: 'Trebuchet MS',
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.grey.shade300
        ),
        scaffoldBackgroundColor: Colors.grey.shade900,
        filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll<Color>(Colors.amber.shade700),
            textStyle: MaterialStateProperty.all<TextStyle>(
              TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
              )
            ),
          ),
        ),

        hintColor: Colors.grey.shade300,
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(
            color: Colors.grey.shade300,
            fontSize: 20.0,
          ),

          errorStyle: TextStyle(
            color: Colors.red,
            fontSize: 14,
          ),

          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.5),
            borderRadius: BorderRadius.circular(30.0),
          ),

          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.5),
            borderRadius: BorderRadius.circular(30.0),
          ),
          
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
            borderRadius: BorderRadius.circular(30.0),
          ),

          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.amber, width: 2.0),
            borderRadius: BorderRadius.circular(30.0),
          ),
          border: OutlineInputBorder(),
        ),

        textTheme: TextTheme(
          titleMedium: TextStyle(
            color: Colors.amber, 
            fontSize: 20.0
          ),
        ),
      ),
      home: home(),
      debugShowCheckedModeBanner: false,
    )
  );
}
