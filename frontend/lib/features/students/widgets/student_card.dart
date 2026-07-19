import 'package:flutter/material.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../models/student.dart';

class StudentCard extends StatelessWidget {
  final Student student;
  final VoidCallback? onTap;

  const StudentCard({super.key, required this.student, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: ListTile(
        leading: CircleAvatar(
          child: Text('${student.firstName[0]}${student.lastName[0]}'),
        ),
        title: Text('${student.firstName} ${student.lastName}'),
        subtitle: Text('Adm: ${student.admissionNo}'),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
