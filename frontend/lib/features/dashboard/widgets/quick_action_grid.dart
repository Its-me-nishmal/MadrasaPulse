import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';

class QuickActionGrid extends StatelessWidget {
  const QuickActionGrid({super.key});

  static const _actions = [
    _QuickAction('Students', Icons.people, AppColors.info, '/students'),
    _QuickAction('Teachers', Icons.person, AppColors.success, '/teachers'),
    _QuickAction(
        'Attendance', Icons.checklist, AppColors.warning, '/attendance',
        ),
    _QuickAction(
        'Fees', Icons.account_balance_wallet, AppColors.error, '/fees',
        ),
    _QuickAction('Exams', Icons.school, AppColors.primaryLight, '/exams'),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: _actions.map((a) {
        return SizedBox(
          width: (MediaQuery.of(context).size.width - 48) / 3,
          child: Container(
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkSurface : Colors.white,
              borderRadius: BorderRadius.circular(AppSpacing.borderRadiusMedium),
              border: Border.all(
                color: isDark ? AppColors.darkBorder : AppColors.border,
                width: 0.8,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSpacing.borderRadiusMedium),
              child: InkWell(
                onTap: () => context.push(a.route),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.md, horizontal: AppSpacing.xs),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: a.color.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(a.icon, color: a.color, size: 24),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        a.label,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _QuickAction {
  final String label;
  final IconData icon;
  final Color color;
  final String route;
  const _QuickAction(this.label, this.icon, this.color, this.route);
}
