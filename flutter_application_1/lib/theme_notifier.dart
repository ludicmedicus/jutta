import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './timer_themes.dart';

class ThemeModeNotifier with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeModeNotifier(){
    _loadTheme();
  }
  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themePref = prefs.getString('themeMode') ?? "light";
    _themeMode = ThemeMode.values.byName(themePref);
    
    notifyListeners();
  }

  ThemeMode getThemeMode() => _themeMode;

  Future<void> setThemeMode(ThemeMode themeMode) async {

    _themeMode = themeMode;
    notifyListeners();
  }
}