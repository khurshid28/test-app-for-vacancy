import 'package:flutter/material.dart';
import 'package:test_app/core/l10n/generated/app_localizations.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const HomePage({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        destinations: [
          NavigationDestination(
            icon: const Icon(Iconsax.home_2),
            selectedIcon: const Icon(Iconsax.home_2_copy),
            label: l10n.dashboard,
          ),
          NavigationDestination(
            icon: const Icon(Iconsax.setting_2),
            selectedIcon: const Icon(Iconsax.setting_2_copy),
            label: l10n.settings,
          ),
        ],
      ),
    );
  }
}
