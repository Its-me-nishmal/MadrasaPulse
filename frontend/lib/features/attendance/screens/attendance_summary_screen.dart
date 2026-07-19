import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_colors.dart';
import '../../../models/attendance.dart';
import '../../../shared/widgets/loading_widget.dart';
import '../../../shared/widgets/error_widget.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../core/network/dio_provider.dart';
import '../repositories/attendance_repository.dart';

class AttendanceSummaryScreen extends ConsumerStatefulWidget {
  final String classId;
  final String monthYear;
  const AttendanceSummaryScreen({
    super.key,
    required this.classId,
    required this.monthYear,
  });

  @override
  ConsumerState<AttendanceSummaryScreen> createState() =>
      _AttendanceSummaryScreenState();
}

class _AttendanceSummaryScreenState
    extends ConsumerState<AttendanceSummaryScreen> {
  AttendanceSummary? _summary;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  Future<void> _fetch() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final dio = ref.read(dioClientProvider);
      final repo = AttendanceRepository(dio);
      final summary =
          await repo.getSummary(widget.classId, widget.monthYear);
      setState(() {
        _summary = summary;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Summary - ${widget.monthYear}')),
      body: _isLoading
          ? const LoadingWidget(message: 'Loading summary...')
          : _error != null
              ? AppErrorWidget(message: _error!, onRetry: _fetch)
              : _summary == null
                  ? const EmptyState(
                      icon: Icons.bar_chart,
                      title: 'No data',
                      subtitle: 'No summary available',
                      )
                  : _buildBody(_summary!),
    );
  }

  Widget _buildBody(AttendanceSummary s) {
    final cards = [
      _StatCard(
          'Days Logged', '${s.totalDaysLogged}', Icons.calendar_today, AppColors.info,
          ),
      _StatCard('Attendance Rate',
          '${(s.attendanceRate * 100).toStringAsFixed(1)}%',
          Icons.trending_up, AppColors.success,
          ),
      _StatCard('Present', '${s.counts.present}', Icons.check_circle,
          AppColors.present,
          ),
      _StatCard('Absent', '${s.counts.absent}', Icons.cancel, AppColors.absent,
          ),
      _StatCard('Late', '${s.counts.late}', Icons.access_time, AppColors.late,
          ),
      _StatCard('Excused', '${s.counts.excused}', Icons.help, AppColors.excused,
          ),
    ];

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: AppSpacing.sm,
          mainAxisSpacing: AppSpacing.sm,
          childAspectRatio: 1.4,
        ),
        itemCount: cards.length,
        itemBuilder: (ctx, i) => cards[i],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  const _StatCard(this.label, this.value, this.icon, this.color);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color.withValues(alpha: 0.08),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: AppSpacing.sm),
            Text(value,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: color,
                    ),
                ),
            const SizedBox(height: 2),
            Text(label,
                style: const TextStyle(fontSize: 12),
                ),
          ],
        ),
      ),
    );
  }
}
