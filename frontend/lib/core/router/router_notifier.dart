import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RouterNotifier extends ChangeNotifier {
  bool _isAuth = false;
  bool _isInitialized = false;

  bool get isAuth => _isAuth;
  bool get isInitialized => _isInitialized;

  void login() {
    _isAuth = true;
    _isInitialized = true;
    notifyListeners();
  }

  void logout() {
    _isAuth = false;
    _isInitialized = true;
    notifyListeners();
  }

  void setAuth(bool auth) {
    _isAuth = auth;
    _isInitialized = true;
    notifyListeners();
  }
}

final routerNotifierProvider = Provider<RouterNotifier>((ref) {
  return RouterNotifier();
});
