import 'package:accu_trips/common/widgets/side_nav/custom_side_nav.dart';
import 'package:accu_trips/modules/auth/view/login.dart';
import 'package:accu_trips/modules/city_and_country/view/country_view.dart';
import 'package:accu_trips/modules/dashboard/dashboard_view.dart';
import 'package:accu_trips/modules/splash/splash_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:bot_toast/bot_toast.dart';

final GoRouter router = GoRouter(
  initialLocation: '/splash',
  debugLogDiagnostics: kDebugMode,
  observers: [BotToastNavigatorObserver()],
  routes: [
    GoRoute(
      path: '/splash',
      name: 'splash',
      builder: (context, state) {
        return const SplashView();
      },
    ),
    GoRoute(path: '/login', name: 'login', builder: (context, state) => Login()),

    // Shell route for dashboard, queries, etc.
    ShellRoute(
      builder: (context, state, child) {
        return Material(
          child: Row(
            children: [
              // Desktop sidebar
              context.responsiveValue(
                mobile: SizedBox.shrink(), // No sidebar on mobile
                // tablet: CustomSideNav(),
                tablet: SizedBox.shrink(),
                desktop: CustomSideNav(),
              ),
              // Main content
              Expanded(child: child),
            ],
          ),
        );
      },
      routes: [
        GoRoute(path: '/dashboard', name: 'dashboard', builder: (context, state) => DashboardView()),
        GoRoute(path: '/country', name: 'country', builder: (context, state) => CountryView()),
      ],
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(title: const Text('Error')),
    body: Center(child: Text('Page not found: ${state.uri}')),
  ),
);
