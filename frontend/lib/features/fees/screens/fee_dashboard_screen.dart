import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../models/fee.dart';
import '../../../shared/widgets/loading_widget.dart';
import '../../../shared/widgets/error_widget.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../shared/widgets/status_badge.dart';
import '../../../core/network/dio_provider.dart';
import '../repositories/fee_repository.dart';
import 'payment_screen.dart';

class FeeDashboardScreen extends ConsumerStatefulWidget {
  final String? studentId;
  const FeeDashboardScreen({super.key, this.studentId});

  @override
  ConsumerState<FeeDashboardScreen> createState() => _FeeDashboardScreenState();
}

class _FeeDashboardScreenState extends ConsumerState<FeeDashboardScreen> {
  final _studentIdCtrl = TextEditingController();
  final _academicYearCtrl = TextEditingController(text: '2026-2027');
  FeeLedger? _ledger;
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    if (widget.studentId != null) {
      _studentIdCtrl.text = widget.studentId!;
      _fetchLedger();
    }
  }

  @override
  void dispose() {
    _studentIdCtrl.dispose();
    _academicYearCtrl.dispose();
    super.dispose();
  }

  Future<void> _fetchLedger() async {
    if (_studentIdCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Enter a Student ID')));
      return;
    }
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final dio = ref.read(dioClientProvider);
      final repo = FeeRepository(dio);
      final ledger =
          await repo.getLedger(_studentIdCtrl.text, _academicYearCtrl.text);
      setState(() {
        _ledger = ledger;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fees & Payments')),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _studentIdCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Student ID',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: TextField(
                    controller: _academicYearCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Academic Year',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                ElevatedButton(
                  onPressed: _isLoading ? null : _fetchLedger,
                  child: const Text('Search'),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            if (_isLoading)
              const Expanded(
                  child: LoadingWidget(message: 'Loading ledger...'),
                  )
            else if (_error != null)
              Expanded(
                  child: AppErrorWidget(
                      message: _error!, onRetry: _fetchLedger,
                      ),
                  )
            else if (_ledger == null)
              const Expanded(
                  child: EmptyState(
                      icon: Icons.receipt_long,
                      title: 'Enter a Student ID',
                      subtitle:
                          'Search for a student to view their fee ledger',
                      ),
                  )
            else if (_ledger!.invoices.isEmpty)
              const Expanded(
                  child: EmptyState(
                      icon: Icons.receipt_long,
                      title: 'No invoices',
                      subtitle: 'No invoices found for this student',
                      ),
                  )
            else
              Expanded(child: _buildInvoiceList(_ledger!)),
          ],
        ),
      ),
    );
  }

  Widget _buildInvoiceList(FeeLedger ledger) {
    return ListView.separated(
      itemCount: ledger.invoices.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (ctx, i) {
        final inv = ledger.invoices[i];
        return Card(
          child: ListTile(
            title: Text(inv.title),
            subtitle: Text(
                '\$${inv.amount.toStringAsFixed(2)}  |  Paid: \$${inv.paidAmount.toStringAsFixed(2)}',
                ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                StatusBadge(status: inv.status),
                if (inv.status != 'Paid') ...[
                  const SizedBox(width: AppSpacing.sm),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) =>
                            PaymentScreen(invoiceNo: inv.invoiceNo),
                      ),
                      );
                    },
                    child: const Text('Pay'),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
