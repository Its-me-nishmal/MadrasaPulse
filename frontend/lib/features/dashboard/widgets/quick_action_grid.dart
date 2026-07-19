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
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: _actions.map((a) {
        return SizedBox(
          width: (MediaQuery.of(context).size.width - 48) / 3,
          child: Card(
            child: InkWell(
              borderRadius:
                  BorderRadius.circular(AppSpacing.borderRadiusMedium),
              onTap: () => context.push(a.route),
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  children: [
                    Icon(a.icon, color: a.color, size: 28),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      a.label,
                      style: const TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ],
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
