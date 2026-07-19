import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../shared/widgets/loading_widget.dart';
import '../../../shared/widgets/error_widget.dart';
import '../../students/repositories/student_repository.dart';
import '../../../core/network/dio_provider.dart';
import '../repositories/attendance_repository.dart';

class AttendanceTakeScreen extends ConsumerStatefulWidget {
  final String classId;
  final String date;
  const AttendanceTakeScreen({
    super.key,
    required this.classId,
    this.date = '',
  });

  @override
  ConsumerState<AttendanceTakeScreen> createState() =>
      _AttendanceTakeScreenState();
}

class _AttendanceTakeScreenState extends ConsumerState<AttendanceTakeScreen> {
  final _records = <String, String>{};
  bool _isLoading = true;
  String? _error;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      final dio = ref.read(dioClientProvider);
      final repo = AttendanceRepository(dio);
      final monthYear = widget.date.length >= 7
          ? widget.date.substring(0, 7)
          : '2026-07';
      final bucket = await repo.getMonthlySheet(widget.classId, monthYear);
      final day = DateTime.tryParse(widget.date)?.day ?? DateTime.now().day;
      final log = bucket.dailyLogs.where((d) => d.day == day).firstOrNull;
      if (log != null) {
        for (final r in log.records) {
          _records[r.studentId ?? ''] = r.status;
        }
      } else {
        final studentRepo = StudentRepository(dio);
        final result = await studentRepo.getStudents(classId: widget.classId, limit: 100);
        for (final s in result.students) {
          _records[s.id] = 'Present';
        }
      }
      setState(() => _isLoading = false);
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _submit() async {
    setState(() => _isSubmitting = true);
    try {
      final dio = ref.read(dioClientProvider);
      final repo = AttendanceRepository(dio);
      final records = _records.entries
          .map((e) => {'studentId': e.key, 'status': e.value})
          .toList();
      await repo.submitAttendance(
        classId: widget.classId,
        date: widget.date,
        records: records,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Attendance submitted')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Take Attendance')),
      body: _isLoading
          ? const LoadingWidget(message: 'Loading students...')
              : _error != null
                  ? AppErrorWidget(
                      message: _error!, onRetry: _loadData,
                      )
                  : _records.isEmpty
                  ? const Center(child: Text('No students found'))
                  : Column(
                      children: [
                        Expanded(
                          child: ListView(
                            padding: const EdgeInsets.all(AppSpacing.md),
                            children: _records.entries.map((entry) {
                              return Card(
                                child: ListTile(
                                  title: Text(entry.key),
                                  trailing: DropdownButton<String>(
                                    value: entry.value,
                                    items: const [
                                      DropdownMenuItem(
                                          value: 'Present',
                                          child: Text('Present'),
                                          ),
                                      DropdownMenuItem(
                                          value: 'Absent',
                                          child: Text('Absent'),
                                          ),
                                      DropdownMenuItem(
                                          value: 'Late',
                                          child: Text('Late'),
                                          ),
                                      DropdownMenuItem(
                                          value: 'Excused',
                                          child: Text('Excused'),
                                          ),
                                    ],
                                    onChanged: (v) {
                                      if (v != null) {
                                        setState(() {
                                          _records[entry.key] = v;
                                        });
                                      }
                                    },
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(AppSpacing.md),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _isSubmitting ? null : _submit,
                              child: _isSubmitting
                                   ? const SizedBox(
                                       width: 20,
                                       height: 20,
                                       child: CircularProgressIndicator(
                                           strokeWidth: 2,
                                           ),
                                       )
                                   : const Text('Submit Attendance'),
                             ),
                          ),
                        ),
                      ],
                    ),
    );
  }
}
