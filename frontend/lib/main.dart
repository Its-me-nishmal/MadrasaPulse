import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/router/router.dart';
import 'core/router/router_notifier.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MadrasaPulseApp(),
    ),
  );
}

class MadrasaPulseApp extends ConsumerWidget {
  const MadrasaPulseApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routerNotifier = ref.watch(routerNotifierProvider);
    final router = createRouter(routerNotifier);

    return MaterialApp.router(
      title: 'MadrasaPulse',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
