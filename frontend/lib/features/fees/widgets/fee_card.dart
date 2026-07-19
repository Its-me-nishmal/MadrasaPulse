import 'package:flutter/material.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../models/fee.dart';

class FeeCard extends StatelessWidget {
  final Invoice invoice;
  final VoidCallback? onPayment;
  const FeeCard({super.key, required this.invoice, this.onPayment});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: ListTile(
        title: Text(invoice.title),
        subtitle: Text('\$${invoice.amount} - ${invoice.status}'),
        trailing: invoice.status != 'Paid' && onPayment != null ? TextButton(onPressed: onPayment, child: const Text('Pay')) : null,
      ),
    );
  }
}
