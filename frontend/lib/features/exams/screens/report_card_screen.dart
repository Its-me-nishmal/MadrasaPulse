import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_colors.dart';
import '../../../models/exam.dart';
import '../../../shared/widgets/loading_widget.dart';
import '../../../shared/widgets/error_widget.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../core/network/dio_provider.dart';
import '../repositories/exam_repository.dart';

class ReportCardScreen extends ConsumerStatefulWidget {
  final String studentId;
  final String examId;
  const ReportCardScreen({
    super.key,
    required this.studentId,
    required this.examId,
  });

  @override
  ConsumerState<ReportCardScreen> createState() => _ReportCardScreenState();
}

class _ReportCardScreenState extends ConsumerState<ReportCardScreen> {
  List<ReportCardItem>? _items;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  Future<void> _fetch() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final dio = ref.read(dioClientProvider);
      final repo = ExamRepository(dio);
      final items = await repo.getReportCard(widget.studentId);
      setState(() {
        _items = items;
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
      appBar: AppBar(title: const Text('Report Card')),
      body: _isLoading
          ? const LoadingWidget(message: 'Loading report card...')
          : _error != null
              ? AppErrorWidget(message: _error!, onRetry: _fetch)
              : _items == null || _items!.isEmpty
                  ? const EmptyState(
                      icon: Icons.assignment,
                      title: 'No results',
                      subtitle: 'No report card data available',
                      )
                  : _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    final totalMarks = _items!.fold<double>(
        0, (sum, i) => sum + (i.marksObtained ?? 0),
        );
    final totalMax = _items!.fold<double>(
        0, (sum, i) => sum + (i.maxMarks ?? 0),
        );
    final overallPct =
        totalMax > 0 ? (totalMarks / totalMax * 100) : 0;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        children: [
          Card(
            color: AppColors.primaryLight.withValues(alpha: 0.1),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                children: [
                  Text('Student: ${widget.studentId}',
                      style: Theme.of(context).textTheme.titleMedium,
                      ),
                  const SizedBox(height: AppSpacing.sm),
                  Text('Overall: ${overallPct.toStringAsFixed(1)}%',
                      style: Theme.of(context).textTheme.headlineSmall,
                      ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          ..._items!.map((item) => Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.subjectName ?? 'Unknown',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    ),
                                ),
                            const SizedBox(height: 4),
                            Text('${item.marksObtained?.toStringAsFixed(1) ?? '-'} / ${item.maxMarks?.toStringAsFixed(0) ?? '-'}',
                                style: const TextStyle(fontSize: 13),
                                ),
                          ],
                        ),
                      ),
                      if (item.percentage != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4,
                              ),
                          decoration: BoxDecoration(
                            color: _gradeColor(item.grade).withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '${item.percentage!.toStringAsFixed(0)}%',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: _gradeColor(item.grade),
                                ),
                          ),
                        ),
                      if (item.grade != null) ...[
                        const SizedBox(width: AppSpacing.sm),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4,
                              ),
                          decoration: BoxDecoration(
                            color: _gradeColor(item.grade).withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            item.grade!,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: _gradeColor(item.grade),
                                ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
  }

  Color _gradeColor(String? grade) {
    switch (grade?.toUpperCase()) {
      case 'A':
      case 'A+':
        return Colors.green;
      case 'B':
      case 'B+':
        return Colors.blue;
      case 'C':
      case 'C+':
        return Colors.orange;
      case 'D':
        return Colors.deepOrange;
      case 'F':
        return Colors.red;
      default:
        return AppColors.textSecondary;
    }
  }
}
