import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:test_app/core/l10n/generated/app_localizations.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:test_app/features/home/domain/entities/business.dart';

class BusinessListTile extends StatelessWidget {
  final Business business;

  const BusinessListTile({super.key, required this.business});

  String _businessTypeName(BuildContext context, BusinessType type) {
    final l10n = AppLocalizations.of(context);
    switch (type) {
      case BusinessType.retail:
        return l10n.retail;
      case BusinessType.service:
        return l10n.service;
      case BusinessType.technology:
        return l10n.technology;
      case BusinessType.food:
        return l10n.food;
    }
  }

  IconData _businessTypeIcon(BusinessType type) {
    switch (type) {
      case BusinessType.retail:
        return Iconsax.shop;
      case BusinessType.service:
        return Iconsax.briefcase;
      case BusinessType.technology:
        return Iconsax.cpu_setting;
      case BusinessType.food:
        return Iconsax.coffee;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          SizedBox(
            height: 140,
            width: double.infinity,
            child: CachedNetworkImage(
              imageUrl: business.imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: theme.colorScheme.surface,
                highlightColor: theme.colorScheme.surfaceContainerHighest,
                child: Container(color: Colors.white),
              ),
              errorWidget: (context, url, error) => Container(
                color: theme.colorScheme.primary.withAlpha(26),
                child: Icon(
                  _businessTypeIcon(business.type),
                  size: 40,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title + status
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        business.name,
                        style: theme.textTheme.titleMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: business.isActive
                            ? const Color(0xFF10B981).withAlpha(26)
                            : Colors.grey.withAlpha(26),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        business.isActive ? l10n.active : l10n.inactive,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: business.isActive
                              ? const Color(0xFF10B981)
                              : Colors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),

                // Type badge
                Row(
                  children: [
                    Icon(
                      _businessTypeIcon(business.type),
                      size: 14,
                      color: theme.colorScheme.onSurface.withAlpha(128),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _businessTypeName(context, business.type),
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Stats row
                Row(
                  children: [
                    // Revenue
                    Icon(
                      Iconsax.dollar_circle,
                      size: 14,
                      color: const Color(0xFF10B981),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '\$${_formatNumber(business.revenue)}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Employees
                    Icon(
                      Iconsax.people,
                      size: 14,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      l10n.employeesCount(business.employeesCount),
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatNumber(double number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toStringAsFixed(0);
  }
}
