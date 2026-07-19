import 'package:flutter/material.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? color.withValues(alpha: 0.08) : color.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(AppSpacing.borderRadiusMedium),
        border: Border.all(
          color: isDark ? color.withValues(alpha: 0.2) : color.withValues(alpha: 0.15),
          width: 1,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -8,
            bottom: -8,
            child: Icon(
              icon,
              size: 72,
              color: color.withValues(alpha: 0.08),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: AppTextStyles.statLabel.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(icon, color: color, size: 16),
                    ),
                  ],
                ),
                Text(
                  value,
                  style: AppTextStyles.statNumber.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
