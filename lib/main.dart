// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app/app.dart';
import 'providers/app_provider.dart';
import 'viewmodels/home_vm.dart';
import 'viewmodels/services_vm.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => ServicesViewModel()),
      ],
      child: const RoboGeniusApp(),
    ),
  );
}
