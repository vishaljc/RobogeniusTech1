// lib/app/routes.dart

import 'package:go_router/go_router.dart';
import '../views/home/home_view.dart';
import '../views/services/services_view.dart';
import '../views/about/about_view.dart';
import '../views/contact/contact_view.dart';
import '../core/constants/app_constants.dart';

final appRouter = GoRouter(
  initialLocation: AppConstants.homeRoute,
  routes: [
    GoRoute(
      path: AppConstants.homeRoute,
      builder: (context, state) => const HomeView(),
    ),
    GoRoute(
      path: AppConstants.servicesRoute,
      builder: (context, state) => const ServicesView(),
    ),
    GoRoute(
      path: AppConstants.aboutRoute,
      builder: (context, state) => const AboutView(),
    ),
    GoRoute(
      path: AppConstants.contactRoute,
      builder: (context, state) => const ContactView(),
    ),
  ],
);
