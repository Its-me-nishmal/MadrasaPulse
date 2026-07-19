import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RouterNotifier extends ChangeNotifier {
  bool _isAuth = false;
  bool get isAuth => _isAuth;

  void login() {
    _isAuth = true;
    notifyListeners();
  }

  void logout() {
    _isAuth = false;
    notifyListeners();
  }

  void setAuth(bool auth) {
    _isAuth = auth;
    notifyListeners();
  }
}

final routerNotifierProvider = Provider<RouterNotifier>((ref) {
  return RouterNotifier();
});
