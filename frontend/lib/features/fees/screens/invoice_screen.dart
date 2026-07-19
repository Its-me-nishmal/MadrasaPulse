import 'package:flutter/material.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../models/fee.dart';
import '../../../shared/widgets/status_badge.dart';

class InvoiceScreen extends StatelessWidget {
  final Invoice invoice;
  const InvoiceScreen({super.key, required this.invoice});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(AppSpacing.sm),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(invoice.title),
              StatusBadge(status: invoice.status)
            ]),
            const SizedBox(height: AppSpacing.sm),
            Text('Amount: \$${invoice.amount}'),
            Text('Paid: \$${invoice.paidAmount}'),
          ],
        ),
      ),
    );
  }
}
