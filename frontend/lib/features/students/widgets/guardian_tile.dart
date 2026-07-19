import 'package:flutter/material.dart';
import '../../../models/student.dart';

class GuardianTile extends StatelessWidget {
  final Guardian guardian;

  const GuardianTile({super.key, required this.guardian});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        guardian.isPrimary ? Icons.star : Icons.person,
        color: guardian.isPrimary ? Colors.amber : null,
      ),
      title: Text(guardian.name ?? ''),
      subtitle: Text('${guardian.relationship} - ${guardian.phone}'),
      dense: true,
    );
  }
}
