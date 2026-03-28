import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/l10n/generated/app_localizations.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:test_app/core/network/connectivity_cubit.dart';
import 'package:test_app/core/widgets/fade_up_animation.dart';
import 'package:test_app/core/widgets/no_internet_widget.dart';
import 'package:test_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:test_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:test_app/features/auth/presentation/widgets/login_form.dart';
import 'package:test_app/features/auth/presentation/widgets/social_login_buttons.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
          }
        },
        child: SafeArea(
          child: BlocBuilder<ConnectivityCubit, ConnectivityStatus>(
            builder: (context, connectivity) {
              if (connectivity == ConnectivityStatus.disconnected) {
                return const NoInternetWidget();
              }
              return Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Logo / Icon
                      FadeUpAnimation(
                        delay: 0,
                        child: Container(
                          width: 72,
                          height: 72,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withAlpha(26),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            Iconsax.building_3,
                            size: 36,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Title
                      FadeUpAnimation(
                        delay: 100,
                        child: Text(
                          l10n.welcomeBack,
                          style: theme.textTheme.headlineMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 8),
                      FadeUpAnimation(
                        delay: 150,
                        child: Text(
                          l10n.loginSubtitle,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurface.withAlpha(153),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Login Form
                      FadeUpAnimation(
                        delay: 250,
                        child: const LoginForm(),
                      ),
                      const SizedBox(height: 24),

                      // Divider with text
                      FadeUpAnimation(
                        delay: 350,
                        child: Row(
                          children: [
                            const Expanded(child: Divider()),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                l10n.orContinueWith,
                                style: theme.textTheme.bodySmall,
                              ),
                            ),
                            const Expanded(child: Divider()),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Social Login
                      FadeUpAnimation(
                        delay: 450,
                        child: const SocialLoginButtons(),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
