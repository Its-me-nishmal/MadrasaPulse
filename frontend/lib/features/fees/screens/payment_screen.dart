import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_spacing.dart';
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
  String _paymentMethod = 'Cash';
  bool _isSubmitting = false;

  final _methods = ['Cash', 'Stripe', 'Razorpay', 'BankTransfer'];

  @override
  void dispose() {
    _amountCtrl.dispose();
    _transactionCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_amountCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Enter amount')));
      return;
    }
    setState(() => _isSubmitting = true);
    try {
      final dio = ref.read(dioClientProvider);
      await dio.post(ApiConfig.feesPayment, data: {
        'invoiceNo': widget.invoiceNo,
        'amount': double.parse(_amountCtrl.text),
        'transactionId': _transactionCtrl.text,
        'paymentMethod': _paymentMethod,
      },
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Payment recorded'), backgroundColor: Colors.green,
              ),
        );
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Payment failed: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Record Payment')),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Invoice: ${widget.invoiceNo}',
                style: Theme.of(context).textTheme.titleMedium,
                ),
            const SizedBox(height: AppSpacing.lg),
            TextField(
              controller: _amountCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(),
                prefixText: '\$ ',
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: _transactionCtrl,
              decoration: const InputDecoration(
                labelText: 'Transaction ID',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            DropdownButtonFormField<String>(
              initialValue: _paymentMethod,
              decoration: const InputDecoration(
                labelText: 'Payment Method',
                border: OutlineInputBorder(),
              ),
              items: _methods
                  .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                  .toList(),
              onChanged: (v) {
                if (v != null) setState(() => _paymentMethod = v);
              },
            ),
            const SizedBox(height: AppSpacing.lg),
            ElevatedButton(
              onPressed: _isSubmitting ? null : _submit,
              child: _isSubmitting
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child:
                          CircularProgressIndicator(strokeWidth: 2,
                          ),
                          )
                  : const Text('Submit Payment'),
            ),
          ],
        ),
      ),
    );
  }
}
