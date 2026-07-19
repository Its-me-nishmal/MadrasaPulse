import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../shared/utils/validators.dart';
import '../controllers/student_form_controller.dart';
import '../controllers/student_list_controller.dart';

class StudentFormScreen extends ConsumerStatefulWidget {
  final String? studentId;
  const StudentFormScreen({super.key, this.studentId});

  @override
  ConsumerState<StudentFormScreen> createState() => _StudentFormScreenState();
}

class _StudentFormScreenState extends ConsumerState<StudentFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _admissionNoController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  @override
  void dispose() {
    _admissionNoController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    final data = {
      'admissionNo': _admissionNoController.text.trim(),
      'firstName': _firstNameController.text.trim(),
      'lastName': _lastNameController.text.trim(),
    };
    final success = await ref.read(studentFormControllerProvider.notifier).createStudent(data);
    if (success) {
      ref.invalidate(studentListControllerProvider);
      if (mounted) context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(studentFormControllerProvider);
    return Scaffold(
      appBar: AppBar(title: Text(widget.studentId != null ? 'Edit Student' : 'Add Student')),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _admissionNoController,
                decoration: const InputDecoration(labelText: 'Admission No'),
                validator: Validators.required,
              ),
              const SizedBox(height: AppSpacing.formFieldGap),
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(labelText: 'First Name'),
                validator: Validators.required,
              ),
              const SizedBox(height: AppSpacing.formFieldGap),
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(labelText: 'Last Name'),
                validator: Validators.required,
              ),
              const SizedBox(height: AppSpacing.xl),
              ElevatedButton(
                onPressed: state.isSubmitting ? null : _handleSubmit,
                child: state.isSubmitting
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
