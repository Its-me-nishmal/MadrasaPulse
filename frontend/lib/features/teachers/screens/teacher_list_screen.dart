import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../shared/widgets/app_scaffold.dart';
import '../../../shared/widgets/search_bar_widget.dart';
import '../../../shared/widgets/loading_widget.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../shared/widgets/error_widget.dart';
import '../controllers/teacher_list_controller.dart';

class TeacherListScreen extends ConsumerStatefulWidget {
  const TeacherListScreen({super.key});
  @override
  ConsumerState<TeacherListScreen> createState() => _TeacherListScreenState();
}

class _TeacherListScreenState extends ConsumerState<TeacherListScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(teacherListControllerProvider.notifier).loadTeachers();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(teacherListControllerProvider);
    return AppScaffold(
      title: 'Teachers',
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => context.push('/teachers/add'),
      ),
      child: Column(
        children: [
          AppSearchBar(
            controller: _searchController,
            hintText: 'Search teachers...',
            onChanged: (q) => ref.read(teacherListControllerProvider.notifier).setSearch(q),
          ),
          Expanded(child: _buildBody(state)),
        ],
      ),
    );
  }

  Widget _buildBody(TeacherListState state) {
    if (state.isLoading && state.teachers.isEmpty) return const LoadingWidget(message: 'Loading teachers...');
    if (state.error != null && state.teachers.isEmpty) return AppErrorWidget(message: state.error!, onRetry: () => ref.read(teacherListControllerProvider.notifier).loadTeachers());
    if (state.teachers.isEmpty) return const EmptyState(icon: Icons.person_outline, title: 'No teachers found', subtitle: 'Add a teacher to get started');
    return RefreshIndicator(
      onRefresh: () => ref.read(teacherListControllerProvider.notifier).loadTeachers(),
      child: ListView.builder(
        itemCount: state.teachers.length,
        padding: const EdgeInsets.all(AppSpacing.sm),
        itemBuilder: (ctx, i) {
          final t = state.teachers[i];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 4),
            child: ListTile(
              leading: CircleAvatar(child: Text('${t.firstName[0]}${t.lastName[0]}')),
              title: Text('${t.firstName} ${t.lastName}'),
              subtitle: Text('Staff ID: ${t.staffId}'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push('/teachers/${t.id}'),
            ),
          );
        },
      ),
    );
  }
}
