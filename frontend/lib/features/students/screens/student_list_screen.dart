import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../shared/widgets/app_scaffold.dart';
import '../../../shared/widgets/loading_widget.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../shared/widgets/error_widget.dart';
import '../../../shared/widgets/search_bar_widget.dart';
import '../controllers/student_list_controller.dart';
import '../widgets/student_card.dart';
import 'student_form_screen.dart';

class StudentListScreen extends ConsumerStatefulWidget {
  const StudentListScreen({super.key});

  @override
  ConsumerState<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends ConsumerState<StudentListScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(studentListControllerProvider.notifier).loadStudents();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showAddStudentModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const StudentFormScreen(isModal: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(studentListControllerProvider);

    return AppScaffold(
      title: 'Students',
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showAddStudentModal(context),
      ),
      child: Column(
        children: [
          AppSearchBar(
            controller: _searchController,
            hintText: 'Search students...',
            onChanged: (q) =>
                ref.read(studentListControllerProvider.notifier).setSearch(q),
          ),
          Expanded(
            child: _buildBody(state),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(StudentListState state) {
    if (state.isLoading && state.students.isEmpty) {
      return const LoadingWidget(message: 'Loading students...');
    }
    if (state.error != null && state.students.isEmpty) {
      return AppErrorWidget(
        message: state.error!,
        onRetry: () =>
            ref.read(studentListControllerProvider.notifier).loadStudents(),
      );
    }
    if (state.students.isEmpty) {
      return const EmptyState(
        icon: Icons.people_outline,
        title: 'No students found',
        subtitle: 'Add a student to get started',
      );
    }

    return RefreshIndicator(
      onRefresh: () =>
          ref.read(studentListControllerProvider.notifier).loadStudents(),
      child: ListView.builder(
        itemCount: state.students.length,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
        itemBuilder: (ctx, i) {
          final student = state.students[i];
          return StudentCard(
            student: student,
            onTap: () => context.push('/students/${student.id}'),
          );
        },
      ),
    );
  }
}
