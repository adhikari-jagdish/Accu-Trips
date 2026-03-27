import 'package:accu_trips/modules/dashboard/dashboard_view.dart';
import 'package:accu_trips/modules/splash/splash_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: kDebugMode,
  routes: [
    GoRoute(
      path: '/',
      name: 'splash',
      builder: (context, state) {
        return const SplashView();
      },
    ),
    GoRoute(
      path: '/dashboard',
      name: 'dashboard',
      builder: (context, state) {
        return const DashboardView();
      },
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(title: const Text('Error')),
    body: Center(child: Text('Page not found: ${state.uri}')),
  ),
);
