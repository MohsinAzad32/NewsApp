import 'package:flutter/material.dart';
// import 'package:newsapp/screens/category.dart';
import 'package:newsapp/screens/home.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.grey.shade400,
          cardTheme: CardTheme(
            color: Colors.blueGrey.shade700,
            shadowColor: Colors.blueGrey.shade400,
          ),
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              foregroundColor: WidgetStatePropertyAll(Colors.blueGrey.shade400),
            ),
          )),
      home: const HomeScreen(),
      // home: CategoriesScreen(),
    ),
  );
}
