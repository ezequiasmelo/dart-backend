import 'package:password_dart/password_dart.dart';

import '../dao/user_dao.dart';
import '../models/user_model.dart';
import 'generic_service.dart';

class UserService implements GenericService<UserModel> {
  final UserDAO _userDAO;

  UserService(this._userDAO);

  @override
  Future<bool> delete(int id) async {
    return _userDAO.delete(id);
  }

  @override
  Future<List<UserModel>> findAll() async {
    return _userDAO.findAll();
  }

  @override
  Future<UserModel?> findOne(int id) {
    return _userDAO.findOne(id);
  }

  @override
  Future<bool> save(UserModel value) async {
    if (value.id != null) {
      return _userDAO.update(value);
    } else {
      final hash = Password.hash(value.password!, PBKDF2());
      value.password = hash;

      return _userDAO.create(value);
    }
  }

  Future<UserModel?> findEmail(String email) {
    return _userDAO.findByEmail(email);
  }
}
