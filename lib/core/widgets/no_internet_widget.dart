import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:test_app/core/l10n/generated/app_localizations.dart';
import 'package:test_app/core/network/connectivity_cubit.dart';
import 'package:test_app/core/widgets/fade_up_animation.dart';

class NoInternetWidget extends StatelessWidget {
  final VoidCallback? onRetry;

  const NoInternetWidget({super.key, this.onRetry});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FadeUpAnimation(
              delay: 0,
              child: Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: theme.colorScheme.error.withAlpha(20),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Iconsax.wifi_square,
                  size: 44,
                  color: theme.colorScheme.error.withAlpha(180),
                ),
              ),
            ),
            const SizedBox(height: 28),
            FadeUpAnimation(
              delay: 100,
              child: Text(
                l10n.noInternet,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 8),
            FadeUpAnimation(
              delay: 200,
              child: Text(
                l10n.noInternetSubtitle,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withAlpha(153),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 32),
            FadeUpAnimation(
              delay: 300,
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: () {
                    context.read<ConnectivityCubit>().checkConnectivity();
                    onRetry?.call();
                  },
                  icon: const Icon(Iconsax.refresh, size: 20),
                  label: Text(l10n.tryAgain),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
