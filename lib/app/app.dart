import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/l10n/generated/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:test_app/app/router/app_router.dart';
import 'package:test_app/app/theme/app_theme.dart';
import 'package:test_app/app/theme/theme_cubit.dart';
import 'package:test_app/core/di/injection.dart';
import 'package:test_app/core/l10n/locale_cubit.dart';
import 'package:test_app/core/network/connectivity_cubit.dart';
import 'package:test_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:test_app/features/auth/presentation/bloc/auth_event.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AuthBloc _authBloc;
  late final AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _authBloc = sl<AuthBloc>();
    _appRouter = AppRouter(authBloc: _authBloc);
    _authBloc.add(const CheckAuthStatus());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>.value(value: _authBloc),
        BlocProvider<ThemeCubit>.value(value: sl<ThemeCubit>()),
        BlocProvider<LocaleCubit>.value(value: sl<LocaleCubit>()),
        BlocProvider<ConnectivityCubit>.value(value: sl<ConnectivityCubit>()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return BlocBuilder<LocaleCubit, Locale>(
            builder: (context, locale) {
              return MaterialApp.router(
                title: 'Business Hub',
                debugShowCheckedModeBanner: false,
                theme: AppTheme.light,
                darkTheme: AppTheme.dark,
                themeMode: themeMode,
                locale: locale,
                supportedLocales: AppLocalizations.supportedLocales,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                routerConfig: _appRouter.router,
              );
            },
          );
        },
      ),
    );
  }
}
