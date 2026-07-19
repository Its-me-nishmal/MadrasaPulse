import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'router_notifier.dart';
import '../../features/auth/screens/splash_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/dashboard/screens/dashboard_screen.dart';
import '../../features/students/screens/student_list_screen.dart';
import '../../features/teachers/screens/teacher_list_screen.dart';
import '../../features/attendance/screens/attendance_month_screen.dart';
import '../../features/fees/screens/fee_dashboard_screen.dart';
GoRouter createRouter(RouterNotifier notifier) {
  return GoRouter(
    refreshListenable: notifier,
    initialLocation: '/splash',
    redirect: (context, state) {
      final isAuth = notifier.isAuth;
      final isLoggingIn = state.matchedLocation == '/login';
      final isSplash = state.matchedLocation == '/splash';

      if (isSplash) return null;

      if (!isAuth) {
        return isLoggingIn ? null : '/login';
      }

      if (isLoggingIn) {
        return '/dashboard';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (ctx, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (ctx, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/dashboard',
        name: 'dashboard',
        builder: (ctx, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: '/students',
        name: 'students-list',
        builder: (ctx, state) => const StudentListScreen(),
      ),
      GoRoute(
        path: '/teachers',
        name: 'teachers-list',
        builder: (ctx, state) => const TeacherListScreen(),
      ),
      GoRoute(
        path: '/attendance',
        name: 'attendance-month',
        builder: (ctx, state) => const AttendanceMonthScreen(),
      ),
      GoRoute(
        path: '/fees',
        name: 'fees-dashboard',
        builder: (ctx, state) => const FeeDashboardScreen(),
      ),
      GoRoute(
        path: '/exams',
        name: 'exams-records',
        builder: (ctx, state) => Scaffold(
          appBar: AppBar(title: const Text('Exams')),
          body: const Center(child: Text('Select a student to view report card')),
        ),
      ),
    ],
  );
}
