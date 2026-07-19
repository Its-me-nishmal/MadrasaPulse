import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dio_client.dart';

final dioClientProvider = Provider<DioClient>((ref) {
  return DioClient();
});

final dioAccessTokenProvider = StateProvider<String?>((ref) => null);
final dioRefreshTokenProvider = StateProvider<String?>((ref) => null);
