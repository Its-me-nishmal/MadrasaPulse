import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExamsRecordsScreen extends ConsumerWidget {
  const ExamsRecordsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exams & Results')),
      body: const Center(child: Text('Exams module')),
    );
  }
}
