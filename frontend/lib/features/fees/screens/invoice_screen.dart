import 'package:flutter/material.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_colors.dart';
import '../../../models/fee.dart';
import '../../../shared/widgets/status_badge.dart';
import 'payment_screen.dart';

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(invoice.title,
                      style: Theme.of(context).textTheme.titleMedium,
                      ),
                ),
                StatusBadge(status: invoice.status),
              ],
            ),
            const Divider(height: AppSpacing.lg),
            _row('Invoice No', invoice.invoiceNo),
            const SizedBox(height: AppSpacing.sm),
            _row('Amount', '\$${invoice.amount.toStringAsFixed(2)}'),
            const SizedBox(height: AppSpacing.sm),
            _row('Paid Amount', '\$${invoice.paidAmount.toStringAsFixed(2)}'),
            if (invoice.dueDate != null) ...[
              const SizedBox(height: AppSpacing.sm),
              _row('Due Date', invoice.dueDate!),
            ],
            const SizedBox(height: AppSpacing.sm),
            _row('Balance',
                '\$${(invoice.amount - invoice.paidAmount).toStringAsFixed(2)}',
                ),
            if (invoice.payments.isNotEmpty) ...[
              const Divider(height: AppSpacing.lg),
              Text('Payments',
                  style: Theme.of(context).textTheme.titleSmall,
                  ),
              const SizedBox(height: AppSpacing.sm),
              ...invoice.payments.map((p) => Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(p.transactionId,
                              style: const TextStyle(fontSize: 12),
                              ),
                        ),
                        Text('\$${p.amountPaid.toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                ),
                            ),
                        const SizedBox(width: AppSpacing.sm),
                        Text(p.paymentMethod,
                            style: const TextStyle(fontSize: 12),
                            ),
                      ],
                    ),
                  ),
                  ),
            ],
            if (invoice.status != 'Paid') ...[
              const SizedBox(height: AppSpacing.md),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) =>
                          PaymentScreen(invoiceNo: invoice.invoiceNo),
                    ),
                    );
                  },
                  icon: const Icon(Icons.payment),
                  label: const Text('Make Payment'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: AppColors.textSecondary)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
      ],
    );
  }
}
