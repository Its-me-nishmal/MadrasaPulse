import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../shared/widgets/loading_widget.dart';
import '../../../shared/widgets/error_widget.dart';
import '../controllers/teacher_detail_controller.dart';

class TeacherDetailScreen extends ConsumerWidget {
  final String teacherId;
  const TeacherDetailScreen({super.key, required this.teacherId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(teacherDetailControllerProvider(teacherId));
    return Scaffold(
      appBar: AppBar(title: const Text('Teacher Details')),
      body: state.isLoading
          ? const LoadingWidget()
          : state.error != null
              ? AppErrorWidget(
                  message: state.error!,
                  onRetry: () => ref
                      .read(teacherDetailControllerProvider(teacherId).notifier)
                      .loadTeacher(teacherId),
                  )
              : _buildContent(context, state),
    );
  }

  Widget _buildContent(BuildContext context, TeacherDetailState state) {
    final t = state.teacher!;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        children: [
          CircleAvatar(
              radius: 40,
              child: Text('${t.firstName[0]}${t.lastName[0]}',
                  style: const TextStyle(fontSize: 24),
                  ),
              ),
          const SizedBox(height: AppSpacing.md),
          Text('${t.firstName} ${t.lastName}',
              style: Theme.of(context).textTheme.headlineSmall,
              ),
          Text('Staff ID: ${t.staffId}',
              style: Theme.of(context).textTheme.bodyMedium,
              ),
          const SizedBox(height: AppSpacing.lg),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Details',
                      style: Theme.of(context).textTheme.titleMedium,
                      ),
                  const Divider(),
                  _row('Phone', t.phone),
                  if (t.email != null) _row('Email', t.email!),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(label, style: const TextStyle(color: Colors.grey)),
        Text(value),
      ],
      ),
    );
  }
}
