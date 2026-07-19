import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AttendanceTakeScreen extends ConsumerStatefulWidget {
  final String classId;
  final String date;
  const AttendanceTakeScreen(
      {super.key, required this.classId, this.date = ''});

  @override
  ConsumerState<AttendanceTakeScreen> createState() =>
      _AttendanceTakeScreenState();
}

class _AttendanceTakeScreenState extends ConsumerState<AttendanceTakeScreen> {
  final _records = <String, String>{};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Take Attendance')),
      body: const Center(child: Text('Attendance grid coming soon')),
    );
  }
}
