import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../controllers/auth_controller.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(authControllerProvider.notifier).tryAutoLogin();
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthStatus>(authControllerProvider, (previous, next) {
      if (next == AuthStatus.authenticated) {
        Navigator.of(context).pushReplacementNamed('/dashboard');
      } else if (next == AuthStatus.unauthenticated) {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    });

    return const Scaffold(
      backgroundColor: AppColors.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.mosque_outlined, size: 72, color: AppColors.primaryDark),
            SizedBox(height: AppSpacing.md),
            Text(
              'MadrasaPulse',
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                  ),
            ),
            SizedBox(height: AppSpacing.lg),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
