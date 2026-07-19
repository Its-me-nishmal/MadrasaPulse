import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:madrasapulse_frontend/main.dart';

class AppScaffold extends ConsumerWidget {
  final Widget child;
  final String? title;
  final List<Widget>? actions;
  final Widget? floatingActionButton;

  const AppScaffold({
    super.key,
    required this.child,
    this.title,
    this.actions,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final isDark = themeMode == ThemeMode.dark ||
        (themeMode == ThemeMode.system &&
            MediaQuery.platformBrightnessOf(context) == Brightness.dark);

    final finalActions = <Widget>[
      if (actions != null) ...actions!,
      IconButton(
        icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
        tooltip: isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
        onPressed: () {
          ref.read(themeModeProvider.notifier).state =
              isDark ? ThemeMode.light : ThemeMode.dark;
        },
      ),
    ];

    return Scaffold(
      appBar: title != null
          ? AppBar(
              title: Text(title!),
              actions: finalActions,
            )
          : null,
      body: child,
      floatingActionButton: floatingActionButton,
    );
  }
}
