import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../controllers/dashboard_controller.dart';
import '../widgets/stat_card.dart';
import '../widgets/quick_action_grid.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(dashboardControllerProvider.notifier).loadDashboard();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dashboardControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: RefreshIndicator(
        onRefresh: () =>
            ref.read(dashboardControllerProvider.notifier).loadDashboard(),
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            Text('Overview', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: AppSpacing.sm),
            if (state.isLoading)
              const Center(child: CircularProgressIndicator())
            else ...[
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: AppSpacing.sm,
                mainAxisSpacing: AppSpacing.sm,
                childAspectRatio: 1.5,
                children: [
                  StatCard(
                    title: 'Students',
                    value: state.totalStudents.toString(),
                    icon: Icons.people,
                    color: AppColors.info,
                  ),
                  StatCard(
                    title: 'Teachers',
                    value: state.totalTeachers.toString(),
                    icon: Icons.person,
                    color: AppColors.success,
                  ),
                  StatCard(
                    title: 'Present Today',
                    value: state.todayPresent.toString(),
                    icon: Icons.check_circle,
                    color: AppColors.primaryLight,
                  ),
                  StatCard(
                    title: 'Fees Due',
                    value: '\$${state.totalDue}',
                    icon: Icons.account_balance_wallet,
                    color: AppColors.warning,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              const Text(
                'Quick Actions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: AppSpacing.sm),
              const QuickActionGrid(),
            ],
          ],
        ),
      ),
    );
  }
}
