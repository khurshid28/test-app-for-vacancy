import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/l10n/generated/app_localizations.dart';
import 'package:test_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:test_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:test_app/features/auth/presentation/bloc/auth_state.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        return SizedBox(
          height: 52,
          child: OutlinedButton.icon(
            onPressed: isLoading
                ? null
                : () {
                    context
                        .read<AuthBloc>()
                        .add(const GoogleSignInRequested());
                  },
            icon: Image.network(
              'https://www.gstatic.com/firebasejs/ui/2.0.0/images/auth/google.svg',
              width: 20,
              height: 20,
              errorBuilder: (context, error, stackTrace) => Text(
                'G',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
            label: Text(l10n.signInWithGoogle),
          ),
        );
      },
    );
  }
}
