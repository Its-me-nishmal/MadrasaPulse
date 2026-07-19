import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isOnlineProvider = StateProvider<bool>((ref) => true);

final connectivityCheckerProvider = Provider<Future<bool> Function()>((ref) {
  return () async {
    try {
      final result = await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 5));
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  };
});

class ConnectivityListener extends ConsumerStatefulWidget {
  final Widget child;

  const ConnectivityListener({super.key, required this.child});

  @override
  ConsumerState<ConnectivityListener> createState() => _ConnectivityListenerState();
}

class _ConnectivityListenerState extends ConsumerState<ConnectivityListener> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
    _timer = Timer.periodic(const Duration(seconds: 30), (_) => _checkConnectivity());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _checkConnectivity() async {
    final check = ref.read(connectivityCheckerProvider);
    final isOnline = await check();
    if (mounted) ref.read(isOnlineProvider.notifier).state = isOnline;
  }

  @override
  Widget build(BuildContext context) {
    final isOnline = ref.watch(isOnlineProvider);
    return Column(
      children: [
        if (!isOnline)
          MaterialBanner(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: const Icon(Icons.wifi_off, color: Colors.white),
            backgroundColor: Colors.orange.shade800,
            content: const Text(
              'No internet connection. Some features may be unavailable.',
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              TextButton(
                onPressed: _checkConnectivity,
                child: const Text('Retry', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        Expanded(child: widget.child),
      ],
    );
  }
}
