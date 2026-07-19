import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../models/exam.dart';
import '../../../shared/widgets/loading_widget.dart';
import '../../../shared/widgets/error_widget.dart';
import '../../../shared/widgets/confirm_dialog.dart';
import '../../../core/network/dio_provider.dart';
import '../repositories/exam_repository.dart';

class ExamsRecordsScreen extends ConsumerStatefulWidget {
  final String classId;
  final String examId;
  final String subjectName;
  const ExamsRecordsScreen({
    super.key,
    required this.classId,
    required this.examId,
    required this.subjectName,
  });

  @override
  ConsumerState<ExamsRecordsScreen> createState() => _ExamsRecordsScreenState();
}

class _ExamsRecordsScreenState extends ConsumerState<ExamsRecordsScreen> {
  final _marksControllers = <String, TextEditingController>{};
  final _remarksControllers = <String, TextEditingController>{};
  List<StudentScore> _scores = [];
  bool _isLoading = true;
  String? _error;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _fetchRecords();
  }

  @override
  void dispose() {
    for (final c in _marksControllers.values) {
      c.dispose();
    }
    for (final c in _remarksControllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _fetchRecords() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final dio = ref.read(dioClientProvider);
      final repo = ExamRepository(dio);
      final result = await repo.getExamRecords(
        widget.classId,
        widget.examId,
        widget.subjectName,
      );
      final allScores = <StudentScore>[];
      for (final record in result.records) {
        allScores.addAll(record.records);
      }
      setState(() {
        _scores = allScores;
        _isLoading = false;
      });
      for (final s in allScores) {
        final sid = s.studentId ?? '';
        _marksControllers[sid] =
            TextEditingController(text: s.marksObtained == 0 ? '' : s.marksObtained.toString());
        _remarksControllers[sid] =
            TextEditingController(text: s.remarks ?? '');
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _submitGrades() async {
    final confirmed = await ConfirmDialog.show(context,
        title: 'Submit Grades',
        message: 'Are you sure you want to submit these grades?',
        );
    if (!confirmed) return;

    setState(() => _isSubmitting = true);
    try {
      final dio = ref.read(dioClientProvider);
      final repo = ExamRepository(dio);
      final records = _scores.map((s) {
        final sid = s.studentId ?? '';
        return {
          'studentId': sid,
          'marksObtained': double.tryParse(_marksControllers[sid]?.text ?? '') ?? 0,
          'maxMarks': s.maxMarks,
          'remarks': _remarksControllers[sid]?.text ?? '',
        };
      }).toList();
      await repo.submitGrades({
        'classId': widget.classId,
        'examId': widget.examId,
        'subjectName': widget.subjectName,
        'maxMarks': _scores.isNotEmpty ? _scores.first.maxMarks : 100,
        'records': records,
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Grades submitted'),
              backgroundColor: Colors.green,
              ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.subjectName} - Grades')),
      body: _isLoading
          ? const LoadingWidget(message: 'Loading records...')
          : _error != null
              ? AppErrorWidget(message: _error!, onRetry: _fetchRecords,
                  )
              : _scores.isEmpty
                  ? const Center(child: Text('No student records found'))
                  : Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.all(AppSpacing.sm),
                            itemCount: _scores.length,
                            itemBuilder: (ctx, i) {
                              final s = _scores[i];
                              final sid = s.studentId ?? '';
                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(AppSpacing.sm),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Text(sid,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                ),
                                            ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: TextField(
                                          controller:
                                              _marksControllers[sid],
                                          keyboardType:
                                              TextInputType.number,
                                          decoration: InputDecoration(
                                            labelText:
                                                'Marks / ${s.maxMarks.toStringAsFixed(0)}',
                                            border:
                                                const OutlineInputBorder(),
                                            isDense: true,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: AppSpacing.sm),
                                      Expanded(
                                        flex: 1,
                                        child: TextField(
                                          controller:
                                              _remarksControllers[sid],
                                          decoration:
                                              const InputDecoration(
                                            labelText: 'Remarks',
                                            border: OutlineInputBorder(),
                                            isDense: true,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(AppSpacing.md),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _isSubmitting ? null : _submitGrades,
                              child: _isSubmitting
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                          child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              ),
                                          )
                                  : const Text('Submit Grades'),
                            ),
                          ),
                        ),
                      ],
                    ),
    );
  }
}
