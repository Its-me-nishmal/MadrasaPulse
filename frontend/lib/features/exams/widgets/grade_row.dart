import 'package:flutter/material.dart';
import '../../../core/constants/app_spacing.dart';

class GradeRow extends StatelessWidget {
  final String studentName;
  final double marks;
  final double maxMarks;
  final ValueChanged<double>? onChanged;
  const GradeRow(
      {super.key,
      required this.studentName,
      required this.marks,
      required this.maxMarks,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        children: [
          Expanded(child: Text(studentName)),
          SizedBox(
            width: 80,
            child: onChanged != null
                ? TextField(
                    keyboardType: TextInputType.number,
                    decoration:
                        const InputDecoration(hintText: 'Marks', isDense: true),
                    onChanged: (v) => onChanged!(double.tryParse(v) ?? 0),
                  )
                : Text('$marks / $maxMarks'),
          ),
        ],
      ),
    );
  }
}
