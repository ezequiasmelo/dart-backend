import 'dart:developer';

import 'package:password_dart/password_dart.dart';

import '../to/auth_to.dart';
import 'user_service.dart';

class LoginService {
  final UserService _userService;
  LoginService(this._userService);

  Future<int> authenticate(AuthTO to) async {
    try {
      var user = await _userService.findEmail(to.email);
      if (user == null) return -1;
      return Password.verify(to.password, user.password!) ? user.id! : -1;
    } catch (e) {
      log('[ERROR] -> in Authenticate method by email ${to.email}');
    }
    return -1;
  }
}
