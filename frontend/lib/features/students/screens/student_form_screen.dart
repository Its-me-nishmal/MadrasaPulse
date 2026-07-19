import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_colors.dart';
import '../../../shared/utils/validators.dart';
import '../controllers/student_form_controller.dart';
import '../controllers/student_list_controller.dart';

class StudentFormScreen extends ConsumerStatefulWidget {
  final String? studentId;
  final bool isModal;
  const StudentFormScreen({super.key, this.studentId, this.isModal = false});

  @override
  ConsumerState<StudentFormScreen> createState() => _StudentFormScreenState();
}

class _StudentFormScreenState extends ConsumerState<StudentFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _admissionNoController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _guardianNameController = TextEditingController();
  final _guardianPhoneController = TextEditingController();
  String _selectedRelationship = 'Father';

  final List<String> _relationships = [
    'Father',
    'Mother',
    'Grandfather',
    'Grandmother',
    'Uncle',
    'Aunt',
    'Brother',
    'Sister',
    'Guardian',
  ];

  @override
  void dispose() {
    _admissionNoController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _guardianNameController.dispose();
    _guardianPhoneController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    final data = {
      'admissionNo': _admissionNoController.text.trim(),
      'firstName': _firstNameController.text.trim(),
      'lastName': _lastNameController.text.trim(),
      'guardians': [
        {
          'name': _guardianNameController.text.trim(),
          'relationship': _selectedRelationship,
          'phone': _guardianPhoneController.text.trim(),
          'isPrimary': true,
        }
      ],
    };

    final notifier = ref.read(studentFormControllerProvider.notifier);
    final success = widget.studentId != null
        ? await notifier.updateStudent(widget.studentId!, data)
        : await notifier.createStudent(data);

    if (success) {
      ref.invalidate(studentListControllerProvider);
      if (mounted) {
        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(studentFormControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final formContent = Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : Colors.white,
        borderRadius: widget.isModal
            ? const BorderRadius.vertical(top: Radius.circular(20))
            : null,
      ),
      padding: EdgeInsets.only(
        left: AppSpacing.md,
        right: AppSpacing.md,
        top: AppSpacing.md,
        bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.md,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (widget.isModal) ...[
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: AppSpacing.md),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Text(
                  widget.studentId != null ? 'Edit Student' : 'Add New Student',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.lg),
              ],
              TextFormField(
                controller: _admissionNoController,
                decoration: const InputDecoration(
                  labelText: 'Admission No',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.badge_outlined),
                ),
                validator: Validators.required,
              ),
              const SizedBox(height: AppSpacing.formFieldGap),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _firstNameController,
                      decoration: const InputDecoration(
                        labelText: 'First Name',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                      validator: Validators.required,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: TextFormField(
                      controller: _lastNameController,
                      decoration: const InputDecoration(
                        labelText: 'Last Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: Validators.required,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'Guardian Information',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: AppSpacing.sm),
              TextFormField(
                controller: _guardianNameController,
                decoration: const InputDecoration(
                  labelText: 'Guardian Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.family_restroom_outlined),
                ),
                validator: Validators.required,
              ),
              const SizedBox(height: AppSpacing.formFieldGap),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      controller: _guardianPhoneController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: 'Guardian Phone',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.phone_outlined),
                      ),
                      validator: Validators.required,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    flex: 2,
                    child: DropdownButtonFormField<String>(
                      initialValue: _selectedRelationship,
                      decoration: const InputDecoration(
                        labelText: 'Relation',
                        border: OutlineInputBorder(),
                      ),
                      items: _relationships
                          .map((r) => DropdownMenuItem(value: r, child: Text(r)))
                          .toList(),
                      onChanged: (val) {
                        if (val != null) {
                          setState(() => _selectedRelationship = val);
                        }
                      },
                    ),
                  ),
                ],
              ),
              if (state.error != null) ...[
                const SizedBox(height: AppSpacing.md),
                Text(
                  state.error!,
                  style: const TextStyle(color: AppColors.error, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ],
              const SizedBox(height: AppSpacing.xl),
              ElevatedButton(
                onPressed: state.isSubmitting ? null : _handleSubmit,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.borderRadiusMedium),
                  ),
                ),
                child: state.isSubmitting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(widget.studentId != null ? 'Save Changes' : 'Register Student'),
              ),
            ],
          ),
        ),
      ),
    );

    if (widget.isModal) {
      return formContent;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.studentId != null ? 'Edit Student' : 'Add Student'),
      ),
      body: SafeArea(child: formContent),
    );
  }
}
