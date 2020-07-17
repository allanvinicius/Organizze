import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Tema extends ChangeNotifier {
  ThemeData _selectedTheme;
  SharedPreferences prefs;

  ThemeData dark = ThemeData.dark().copyWith();

  ThemeData light = ThemeData(
    appBarTheme: AppBarTheme(color: Colors.greenAccent[400]),
    primaryColor: Colors.greenAccent[400],
  );

  Tema(bool darkTheme) {
    _selectedTheme = darkTheme ? dark : light;
  }

  Future<void> swapTheme() async {
    prefs = await SharedPreferences.getInstance();

    if (_selectedTheme == dark) {
      _selectedTheme = light;
      await prefs.setBool("darkTheme", false);
    } else {
      _selectedTheme = dark;
      await prefs.setBool("darkTheme", true);
    }

    notifyListeners();
  }

  ThemeData getTheme() => _selectedTheme;
}