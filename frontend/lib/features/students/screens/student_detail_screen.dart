import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../shared/widgets/loading_widget.dart';
import '../../../shared/widgets/error_widget.dart';
import '../../../shared/widgets/confirm_dialog.dart';
import '../controllers/student_detail_controller.dart';
import '../controllers/student_list_controller.dart';
import '../repositories/student_repository.dart';
import '../../../core/network/dio_provider.dart';

class StudentDetailScreen extends ConsumerWidget {
  final String studentId;

  const StudentDetailScreen({super.key, required this.studentId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(studentDetailControllerProvider(studentId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/students/$studentId/edit'),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () async {
              final confirmed = await ConfirmDialog.show(
                context,
                title: 'Delete Student',
                message: 'Are you sure you want to archive this student?',
                confirmLabel: 'Delete',
              );
              if (confirmed) {
                final dio = ref.read(dioClientProvider);
                final repo = StudentRepository(dio);
                await repo.deleteStudent(studentId);
                ref.invalidate(studentListControllerProvider);
                if (context.mounted) context.pop();
              }
            },
          ),
        ],
      ),
      body: state.isLoading
          ? const LoadingWidget()
          : state.error != null
              ? AppErrorWidget(
                  message: state.error!,
                  onRetry: () => ref
                      .read(studentDetailControllerProvider(studentId).notifier)
                      .loadStudent(studentId),
                )
              : _buildContent(context, state),
    );
  }

  Widget _buildContent(BuildContext context, StudentDetailState state) {
    final student = state.student!;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: CircleAvatar(
              radius: 40,
              child: Text(
                '${student.firstName[0]}${student.lastName[0]}',
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Center(
            child: Text(
              '${student.firstName} ${student.lastName}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Center(
            child: Text(
              'Admission: ${student.admissionNo}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Guardians',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  ...student.guardians.map(
                    (g) => ListTile(
                      title: Text(g.name ?? ''),
                      subtitle: Text('${g.relationship} - ${g.phone}'),
                      trailing:
                          g.isPrimary ? const Icon(Icons.star, size: 18) : null,
                      dense: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
