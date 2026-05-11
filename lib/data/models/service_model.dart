// lib/data/models/service_model.dart

import 'package:flutter/material.dart';

class ServiceModel {
  final String id;
  final String title;
  final String shortDescription;
  final String fullDescription;
  final IconData icon;
  final List<String> benefits;
  final bool isHighlight;

  const ServiceModel({
    required this.id,
    required this.title,
    required this.shortDescription,
    required this.fullDescription,
    required this.icon,
    required this.benefits,
    this.isHighlight = false,
  });
}
