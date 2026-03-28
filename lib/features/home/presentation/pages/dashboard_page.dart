import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/l10n/generated/app_localizations.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:test_app/core/network/connectivity_cubit.dart';
import 'package:test_app/core/widgets/fade_up_animation.dart';
import 'package:test_app/core/widgets/no_internet_widget.dart';
import 'package:test_app/features/home/presentation/bloc/user_bloc.dart';
import 'package:test_app/features/home/presentation/bloc/user_event.dart';
import 'package:test_app/features/home/presentation/bloc/user_state.dart';
import 'package:test_app/features/home/presentation/widgets/user_info_card.dart';
import 'package:test_app/features/home/presentation/widgets/stat_card.dart';
import 'package:test_app/features/home/presentation/widgets/business_list_tile.dart';
import 'package:test_app/features/home/presentation/widgets/dashboard_shimmer.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(const LoadUserProfile());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return BlocBuilder<ConnectivityCubit, ConnectivityStatus>(
      builder: (context, connectivity) {
        return BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            // Show no-internet only if we haven't loaded data yet
            if (connectivity == ConnectivityStatus.disconnected &&
                state is! UserLoaded) {
              return NoInternetWidget(
                onRetry: () =>
                    context.read<UserBloc>().add(const LoadUserProfile()),
              );
            }

            if (state is UserLoading || state is UserInitial) {
              return const DashboardShimmer();
            }

            if (state is UserError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FadeUpAnimation(
                        delay: 0,
                        child: Icon(
                          Iconsax.warning_2,
                          size: 48,
                          color: theme.colorScheme.error,
                        ),
                      ),
                      const SizedBox(height: 16),
                      FadeUpAnimation(
                        delay: 100,
                        child: Text(
                          l10n.errorOccurred,
                          style: theme.textTheme.titleMedium,
                        ),
                      ),
                      const SizedBox(height: 8),
                      FadeUpAnimation(
                        delay: 150,
                        child: Text(
                          state.message,
                          style: theme.textTheme.bodySmall,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 24),
                      FadeUpAnimation(
                        delay: 250,
                        child: OutlinedButton.icon(
                          onPressed: () => context
                              .read<UserBloc>()
                              .add(const LoadUserProfile()),
                          icon: const Icon(Iconsax.refresh, size: 18),
                          label: Text(l10n.retry),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            if (state is UserLoaded) {
              final user = state.user;
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<UserBloc>().add(const LoadUserProfile());
                  await context.read<UserBloc>().stream.firstWhere(
                        (s) => s is UserLoaded || s is UserError,
                      );
                },
                child: CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    // Profile section
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // User info
                            FadeUpAnimation(
                              delay: 0,
                              child: UserInfoCard(user: user),
                            ),
                            const SizedBox(height: 16),

                            // Stats row
                            FadeUpAnimation(
                              delay: 150,
                              child: Row(
                                children: [
                                  StatCard(
                                    label: l10n.businesses,
                                    value: '${user.businesses.length}',
                                    icon: Iconsax.building,
                                    iconColor: const Color(0xFF6366F1),
                                  ),
                                  const SizedBox(width: 8),
                                  StatCard(
                                    label: l10n.totalRevenue,
                                    value:
                                        '\$${_formatCompact(user.totalRevenue)}',
                                    icon: Iconsax.dollar_circle,
                                    iconColor: const Color(0xFF10B981),
                                  ),
                                  const SizedBox(width: 8),
                                  StatCard(
                                    label: l10n.employees,
                                    value: '${user.totalEmployees}',
                                    icon: Iconsax.people,
                                    iconColor: const Color(0xFFF59E0B),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Section title
                            FadeUpAnimation(
                              delay: 300,
                              child: Text(
                                l10n.myBusinesses,
                                style: theme.textTheme.titleLarge,
                              ),
                            ),
                            const SizedBox(height: 12),
                          ],
                        ),
                      ),
                    ),

                    // Business list
                    if (user.businesses.isEmpty)
                      SliverToBoxAdapter(
                        child: FadeUpAnimation(
                          delay: 400,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(32),
                              child: Column(
                                children: [
                                  Icon(
                                    Iconsax.building,
                                    size: 48,
                                    color: theme.colorScheme.onSurface
                                        .withAlpha(77),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    l10n.noBusinesses,
                                    style: theme.textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    else
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        sliver: SliverList.separated(
                          itemCount: user.businesses.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            return FadeUpAnimation(
                              delay: 400 + (index * 100),
                              child: BusinessListTile(
                                business: user.businesses[index],
                              ),
                            );
                          },
                        ),
                      ),

                    // Bottom padding
                    const SliverToBoxAdapter(
                      child: SizedBox(height: 24),
                    ),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        );
      },
    );
  }

  String _formatCompact(double number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toStringAsFixed(0);
  }
}
