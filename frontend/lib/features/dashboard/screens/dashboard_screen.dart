import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../shared/widgets/app_scaffold.dart';
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

    return AppScaffold(
      title: 'Dashboard',
      child: RefreshIndicator(
        onRefresh: () =>
            ref.read(dashboardControllerProvider.notifier).loadDashboard(),
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            _buildWelcomeHeader(context),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'Overview', 
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
            ),
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
              Text(
                'Quick Actions',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
              ),
              const SizedBox(height: AppSpacing.sm),
              const QuickActionGrid(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeHeader(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final now = DateTime.now();
    final days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    final months = [
      'January', 'February', 'March', 'April', 'May', 'June', 
      'July', 'August', 'September', 'October', 'November', 'December',
    ];
    final dateStr = '${days[now.weekday - 1]}, ${months[now.month - 1]} ${now.day}, ${now.year}';

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [const Color(0xFF0F3A3A), const Color(0xFF0F1E1E)]
              : [AppColors.primaryDark, AppColors.primaryLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppSpacing.borderRadiusLarge),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -24,
            top: -24,
            child: Icon(
              Icons.mosque_outlined,
              size: 140,
              color: Colors.white.withValues(alpha: 0.08),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Assalamu Alaikum',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Institutional Portal',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(
                    Icons.calendar_month,
                    color: Colors.white70,
                    size: 14,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    dateStr,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
