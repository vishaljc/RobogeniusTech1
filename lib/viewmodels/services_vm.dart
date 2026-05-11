// lib/viewmodels/services_vm.dart

import 'package:flutter/material.dart';
import '../data/models/service_model.dart';
import '../data/services/services_data.dart';

class ServicesViewModel extends ChangeNotifier {
  final List<ServiceModel> _services = ServicesData.getServices();
  int _hoveredIndex = -1;
  String _selectedServiceId = 'rpa';

  List<ServiceModel> get services => _services;
  int get hoveredIndex => _hoveredIndex;
  String get selectedServiceId => _selectedServiceId;

  ServiceModel get highlightService =>
      _services.firstWhere((s) => s.isHighlight);

  void setHovered(int index) {
    _hoveredIndex = index;
    notifyListeners();
  }

  void clearHovered() {
    _hoveredIndex = -1;
    notifyListeners();
  }

  void selectService(String id) {
    _selectedServiceId = id;
    notifyListeners();
  }
}
