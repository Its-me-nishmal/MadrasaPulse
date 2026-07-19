import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppScaffold extends ConsumerWidget {
  final Widget child;
  final String? title;
  final List<Widget>? actions;

  const AppScaffold({super.key, required this.child, this.title, this.actions});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: title != null
          ? AppBar(
              title: Text(title!),
              actions: actions,
            )
          : null,
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _calculateIndex(context),
        onTap: (index) => _onTab(context, index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Students'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Teachers'),
          BottomNavigationBarItem(icon: Icon(Icons.checklist), label: 'Attendance'),
          BottomNavigationBarItem(icon: Icon(Icons.attach_money), label: 'Fees'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Exams'),
        ],
      ),
    );
  }

  int _calculateIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/students')) return 1;
    if (location.startsWith('/teachers')) return 2;
    if (location.startsWith('/attendance')) return 3;
    if (location.startsWith('/fees')) return 4;
    if (location.startsWith('/exams')) return 5;
    return 0;
  }

  void _onTab(BuildContext context, int index) {
    switch (index) {
      case 0: context.go('/dashboard'); break;
      case 1: context.go('/students'); break;
      case 2: context.go('/teachers'); break;
      case 3: context.go('/attendance'); break;
      case 4: context.go('/fees'); break;
      case 5: context.go('/exams'); break;
    }
  }
}
