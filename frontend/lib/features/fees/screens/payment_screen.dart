import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../shared/utils/validators.dart';
import '../../../core/network/api_config.dart';
import '../../../core/network/dio_provider.dart';

class PaymentScreen extends ConsumerStatefulWidget {
  final String invoiceNo;
  const PaymentScreen({super.key, required this.invoiceNo});

  @override
  ConsumerState<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends ConsumerState<PaymentScreen> {
  final _amountCtrl = TextEditingController();
  final _transactionCtrl = TextEditingController();
  final bool _submitting = false;

  @override
  void dispose() {
    _amountCtrl.dispose();
    _transactionCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Record Payment')),
      body: const Center(child: Text('Payment form')),
    );
  }
}
