import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_ui/src/core/services/storage/local_storage_service.dart';
import 'package:quiz_ui/src/features/authentication/presentation/auth_screen.dart';
import 'package:quiz_ui/src/features/home/presentation/home_screen.dart';
import 'package:quiz_ui/src/features/splash/presentation/splash_screen.dart';
import 'package:quiz_ui/src/routing/error_screen.dart';

enum AppRoute {
  home,
  splash,
  auth,
}

final routesProvider = Provider<GoRouter>((ref) {
  final localStorageService = ref.watch(loacalStorageProvider);
  return GoRouter(
    initialLocation: '/splash',
    debugLogDiagnostics: false,
    redirect: (context, state) {
      final isLoggedIn = localStorageService.isLoggedIn;
      if (isLoggedIn) {
        if (state.location == '/signIn') {
          return '/';
        }
      }
      return null;
    },
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        name: AppRoute.home.name,
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen();
        },
      ),
      GoRoute(
        path: '/signIn',
        name: AppRoute.auth.name,
        builder: (BuildContext context, GoRouterState state) {
          return const AuthScreen();
        },
      ),
      GoRoute(
        path: '/splash',
        name: AppRoute.splash.name,
        builder: (BuildContext context, GoRouterState state) {
          return const SplashScreen();
        },
      ),
    ],
    errorBuilder: (context, state) => const ErrorScreen(),
  );
});
