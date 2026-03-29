import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_app/core/di/injection.dart';
import 'package:test_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:test_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:test_app/features/auth/presentation/pages/login_page.dart';
import 'package:test_app/features/auth/presentation/pages/splash_page.dart';
import 'package:test_app/features/home/presentation/bloc/user_bloc.dart';
import 'package:test_app/features/home/presentation/pages/home_page.dart';
import 'package:test_app/features/home/presentation/pages/dashboard_page.dart';
import 'package:test_app/features/settings/presentation/pages/settings_page.dart';

class AppRouter {
  final AuthBloc authBloc;

  AppRouter({required this.authBloc});

  late final GoRouter router = GoRouter(
    initialLocation: '/splash',
    debugLogDiagnostics: false,
    redirect: (context, state) {
      final authState = authBloc.state;
      final isOnSplash = state.matchedLocation == '/splash';

      // While loading (splash), stay on splash
      if (authState is AuthInitial || authState is AuthLoading) {
        return isOnSplash ? null : '/splash';
      }

      final isAuthenticated = authState is AuthAuthenticated;
      final isOnLogin = state.matchedLocation == '/login';

      if (!isAuthenticated && !isOnLogin) return '/login';
      if (isAuthenticated && (isOnLogin || isOnSplash)) return '/dashboard';
      return null;
    },
    refreshListenable: _GoRouterAuthRefresh(authBloc),
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return BlocProvider(
            create: (_) => sl<UserBloc>(),
            child: HomePage(navigationShell: navigationShell),
          );
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/dashboard',
                builder: (context, state) => const DashboardPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/settings',
                builder: (context, state) => const SettingsPage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

class _GoRouterAuthRefresh extends ChangeNotifier {
  _GoRouterAuthRefresh(AuthBloc authBloc) {
    authBloc.stream.listen((_) => notifyListeners());
  }
}
