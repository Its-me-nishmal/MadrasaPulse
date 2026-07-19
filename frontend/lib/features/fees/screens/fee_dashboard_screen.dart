import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/fee_controller.dart';

class FeeDashboardScreen extends ConsumerStatefulWidget {
  final String? studentId;
  const FeeDashboardScreen({super.key, this.studentId});

  @override
  ConsumerState<FeeDashboardScreen> createState() => _FeeDashboardScreenState();
}

class _FeeDashboardScreenState extends ConsumerState<FeeDashboardScreen> {
  final _academicYearCtrl = TextEditingController(text: '2026-2027');

  @override
  void dispose() {
    _academicYearCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(feeControllerProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Fees & Payments')),
      body: const Center(child: Text('Fee module')),
    );
  }
}
