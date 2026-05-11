// lib/providers/app_provider.dart

import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  bool _isMenuOpen = false;
  String _currentRoute = '/';
  bool _isScrolled = false;
  ThemeMode _themeMode = ThemeMode.dark;

  bool get isMenuOpen => _isMenuOpen;
  String get currentRoute => _currentRoute;
  bool get isScrolled => _isScrolled;
  ThemeMode get themeMode => _themeMode;
  bool get isDark => _themeMode == ThemeMode.dark;

  void toggleMenu() {
    _isMenuOpen = !_isMenuOpen;
    notifyListeners();
  }

  void closeMenu() {
    _isMenuOpen = false;
    notifyListeners();
  }

  void setRoute(String route) {
    _currentRoute = route;
    notifyListeners();
  }

  void setScrolled(bool value) {
    if (_isScrolled == value) return;
    _isScrolled = value;
    notifyListeners();
  }

  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}
