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
import 'attendance_take_screen.dart';

class AttendanceMonthScreen extends ConsumerStatefulWidget {
  const AttendanceMonthScreen({super.key});

  @override
  ConsumerState<AttendanceMonthScreen> createState() =>
      _AttendanceMonthScreenState();
}

class _AttendanceMonthScreenState extends ConsumerState<AttendanceMonthScreen> {
  final _classIdCtrl = TextEditingController(text: 'class1');
  final _monthYearCtrl = TextEditingController(text: '2026-07');
  final _classes = ['class1', 'class2', 'class3'];
  AttendanceBucket? _bucket;
  AttendanceSummary? _summary;
  bool _isLoading = false;
  String? _error;

  @override
  void dispose() {
    _classIdCtrl.dispose();
    _monthYearCtrl.dispose();
    super.dispose();
  }

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final dio = ref.read(dioClientProvider);
      final repo = AttendanceRepository(dio);
      final bucket =
          await repo.getMonthlySheet(_classIdCtrl.text, _monthYearCtrl.text);
      final summary =
          await repo.getSummary(_classIdCtrl.text, _monthYearCtrl.text);
      setState(() {
        _bucket = bucket;
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
      appBar: AppBar(title: const Text('Attendance')),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: _classIdCtrl.text,
                    decoration:
                        const InputDecoration(labelText: 'Class', border: OutlineInputBorder()),
                    items: _classes
                        .map((c) =>
                            DropdownMenuItem(value: c, child: Text(c)),
                            )
                        .toList(),
                    onChanged: (v) {
                      if (v != null) _classIdCtrl.text = v;
                    },
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: TextField(
                    controller: _monthYearCtrl,
                    decoration: const InputDecoration(
                        labelText: 'Month/Year',
                        hintText: 'YYYY-MM',
                        border: OutlineInputBorder(),
                        ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                ElevatedButton(
                    onPressed: _isLoading ? null : _fetchData,
                    child: const Text('Load'),
                    ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            if (_isLoading)
              const Expanded(
                  child: LoadingWidget(message: 'Loading attendance...'),
                  )
            else if (_error != null)
              Expanded(
                  child: AppErrorWidget(
                      message: _error!, onRetry: _fetchData,
                      ),
                  )
            else if (_bucket == null)
              const Expanded(
                  child: EmptyState(
                      icon: Icons.calendar_month,
                      title: 'Select a class and month',
                      subtitle: 'Tap Load to view attendance',
                      ),
                  )
            else ...[
              if (_summary != null)
                _buildSummaryCards(_summary!),
              const SizedBox(height: AppSpacing.md),
              Expanded(child: _buildDailyLogs(_bucket!)),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCards(AttendanceSummary s) {
    final items = [
      ('Days Logged', '${s.totalDaysLogged}', Icons.calendar_today, AppColors.info),
      ('Rate', '${(s.attendanceRate * 100).toStringAsFixed(1)}%', Icons.trending_up,
          AppColors.success),
      ('Present', '${s.counts.present}', Icons.check_circle, AppColors.present),
      ('Absent', '${s.counts.absent}', Icons.cancel, AppColors.absent),
      ('Late', '${s.counts.late}', Icons.access_time, AppColors.late),
      ('Excused', '${s.counts.excused}', Icons.help, AppColors.excused),
    ];
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: items
              .map((e) => SizedBox(
                    width: 100,
                    child: Card(
                      color: e.$4.withValues(alpha: 0.1),
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.sm),
                        child: Column(
                          children: [
                            Icon(e.$3, color: e.$4, size: 20),
                            const SizedBox(height: 4),
                        Text(e.$2,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16,
                                ),
                            ),
                            Text(e.$1,
                                style: const TextStyle(fontSize: 11),
                                ),
                          ],
                        ),
                      ),
                    ),
                  ),
              )
          .toList(),
    );
  }

  Widget _buildDailyLogs(AttendanceBucket bucket) {
    if (bucket.dailyLogs.isEmpty) {
      return const EmptyState(
          icon: Icons.list_alt,
          title: 'No records',
          subtitle: 'No attendance entries for this month',
          );
    }
    return ListView.builder(
      itemCount: bucket.dailyLogs.length,
      itemBuilder: (ctx, i) {
        final log = bucket.dailyLogs[i];
        final dateStr =
            '${_monthYearCtrl.text}-${log.day.toString().padLeft(2, '0')}';
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.primaryLight,
              child: Text('${log.day}',
                  style: const TextStyle(color: Colors.white),
                  ),
            ),
            title: Text('Day ${log.day} - $dateStr'),
            subtitle: Text('${log.records.length} students'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => AttendanceTakeScreen(
                    classId: bucket.classId, date: dateStr,
                    ),
              ),
              );
            },
          ),
        );
      },
    );
  }
}
