import 'package:flutter/material.dart';

class ReportCardScreen extends StatelessWidget {
  final String studentId;
  final String examId;
  const ReportCardScreen(
      {super.key, required this.studentId, required this.examId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Report Card')),
      body: const Center(child: Text('Report card')),
    );
  }
}
