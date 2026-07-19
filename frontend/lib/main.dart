import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/router/router.dart';
import 'core/router/router_notifier.dart';
import 'core/theme/app_theme.dart';
import 'l10n/app_localizations.dart';
import 'l10n/locale_provider.dart';
import 'shared/widgets/connectivity_listener.dart';
import 'shared/widgets/error_boundary.dart';

final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);

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
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);

    return ErrorBoundary(
      child: ConnectivityListener(
        child: MaterialApp.router(
          title: 'MadrasaPulse',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeMode,
          locale: locale,
          supportedLocales: LocaleNotifier.supportedLocales,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          routerConfig: router,
        ),
      ),
    );
  }
}
