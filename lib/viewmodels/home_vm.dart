// lib/viewmodels/home_vm.dart

import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  // Animated counter values
  int _clients = 0;
  int _projects = 0;
  int _successRate = 0;
  int _yearsExp = 0;

  int get clients => _clients;
  int get projects => _projects;
  int get successRate => _successRate;
  int get yearsExp => _yearsExp;

  bool _statsAnimated = false;
  bool get statsAnimated => _statsAnimated;

  // Scroll controller for smooth scroll
  final ScrollController scrollController = ScrollController();

  void animateStats() {
    if (_statsAnimated) return;
    _statsAnimated = true;
    _animateCounter((v) => _clients = v, 150, 1500);
    _animateCounter((v) => _projects = v, 300, 1800);
    _animateCounter((v) => _successRate = v, 98, 1200);
    _animateCounter((v) => _yearsExp = v, 8, 800);
  }

  void _animateCounter(
    void Function(int) setter,
    int target,
    int durationMs,
  ) async {
    final steps = 60;
    final stepDuration = durationMs ~/ steps;
    for (int i = 1; i <= steps; i++) {
      await Future.delayed(Duration(milliseconds: stepDuration));
      setter((target * i ~/ steps));
      notifyListeners();
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
