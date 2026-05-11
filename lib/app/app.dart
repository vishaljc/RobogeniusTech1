// lib/app/app.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme/app_theme.dart';
import '../providers/app_provider.dart';
import 'routes.dart';

class RoboGeniusApp extends StatelessWidget {
  const RoboGeniusApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<AppProvider>().themeMode;
    return MaterialApp.router(
      title: 'RoboGenius Tech',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      routerConfig: appRouter,
    );
  }
}
