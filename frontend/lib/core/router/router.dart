import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'router_notifier.dart';

class UnimplementedScreen extends StatelessWidget {
  final String label;
  const UnimplementedScreen(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(label)),
      body: const Center(child: Text('Not yet implemented')),
    );
  }
}

GoRouter createRouter(RouterNotifier notifier) {
  return GoRouter(
    refreshListenable: notifier,
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (ctx, state) => const UnimplementedScreen('Splash'),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (ctx, state) => const UnimplementedScreen('Login'),
      ),
      GoRoute(
        path: '/dashboard',
        name: 'dashboard',
        builder: (ctx, state) => const UnimplementedScreen('Dashboard'),
      ),
      GoRoute(
        path: '/students',
        name: 'students-list',
        builder: (ctx, state) => const UnimplementedScreen('Students'),
      ),
      GoRoute(
        path: '/teachers',
        name: 'teachers-list',
        builder: (ctx, state) => const UnimplementedScreen('Teachers'),
      ),
      GoRoute(
        path: '/attendance',
        name: 'attendance-month',
        builder: (ctx, state) => const UnimplementedScreen('Attendance'),
      ),
      GoRoute(
        path: '/fees',
        name: 'fees-dashboard',
        builder: (ctx, state) => const UnimplementedScreen('Fees'),
      ),
      GoRoute(
        path: '/exams',
        name: 'exams-records',
        builder: (ctx, state) => const UnimplementedScreen('Exams'),
      ),
    ],
  );
}
