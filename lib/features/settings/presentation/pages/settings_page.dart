import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/l10n/generated/app_localizations.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:test_app/app/theme/theme_cubit.dart';
import 'package:test_app/core/l10n/locale_cubit.dart';
import 'package:test_app/core/widgets/fade_up_animation.dart';
import 'package:test_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:test_app/features/auth/presentation/bloc/auth_event.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          // Appearance section
          FadeUpAnimation(
            delay: 0,
            child: _SectionHeader(title: l10n.appearance),
          ),

          // Dark mode toggle
          FadeUpAnimation(
            delay: 80,
            child: BlocBuilder<ThemeCubit, ThemeMode>(
              builder: (context, themeMode) {
                return _SettingsTile(
                  icon: Iconsax.moon,
                  iconColor: const Color(0xFF6366F1),
                  title: l10n.darkMode,
                  subtitle: l10n.darkModeSubtitle,
                  trailing: Switch.adaptive(
                    value: themeMode == ThemeMode.dark,
                    onChanged: (_) => context.read<ThemeCubit>().toggle(),
                  ),
                );
            },
          ),
          ),

          const Divider(indent: 72, endIndent: 16, height: 1),

          // Language selector
          FadeUpAnimation(
            delay: 160,
            child: BlocBuilder<LocaleCubit, Locale>(
            builder: (context, locale) {
              return _SettingsTile(
                icon: Iconsax.language_square,
                iconColor: const Color(0xFF10B981),
                title: l10n.language,
                subtitle: l10n.languageSubtitle,
                trailing: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: theme.dividerTheme.color ?? Colors.grey.shade300,
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: locale.languageCode,
                      isDense: true,
                      borderRadius: BorderRadius.circular(12),
                      items: [
                        DropdownMenuItem(
                          value: 'en',
                          child: Text(
                            l10n.english,
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'ru',
                          child: Text(
                            l10n.russian,
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          context.read<LocaleCubit>().changeLocale(value);
                        }
                      },
                    ),
                  ),
                ),
              );
            },
          ),
          ),

          const SizedBox(height: 24),

          // Account section
          FadeUpAnimation(
            delay: 240,
            child: _SectionHeader(title: l10n.account),
          ),

          // Logout
          FadeUpAnimation(
            delay: 320,
            child: _SettingsTile(
            icon: Iconsax.logout,
            iconColor: Colors.redAccent,
            title: l10n.logout,
            subtitle: l10n.logoutSubtitle,
            onTap: () => _showLogoutDialog(context),
          ),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(l10n.logoutConfirmTitle),
        content: Text(l10n.logoutConfirmMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(
              l10n.cancel,
              style: TextStyle(color: theme.colorScheme.onSurface),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
            ),
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.read<AuthBloc>().add(const LogoutRequested());
            },
            child: Text(l10n.confirm),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title.toUpperCase(),
        style: theme.textTheme.labelSmall?.copyWith(
          letterSpacing: 1.2,
          fontWeight: FontWeight.w600,
          color: theme.colorScheme.onSurface.withAlpha(128),
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: iconColor.withAlpha(26),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, size: 22, color: iconColor),
      ),
      title: Text(
        title,
        style: theme.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: theme.textTheme.bodySmall,
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
