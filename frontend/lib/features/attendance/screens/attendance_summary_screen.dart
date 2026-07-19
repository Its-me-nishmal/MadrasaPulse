import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/widgets/status_badge.dart';

class AttendanceSummaryScreen extends ConsumerWidget {
  final String classId;
  final String monthYear;
  const AttendanceSummaryScreen(
      {super.key, required this.classId, required this.monthYear});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('Summary - $monthYear')),
      body: const Center(child: Text('Attendance summary')),
    );
  }
}
