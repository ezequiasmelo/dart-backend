import 'package:password_dart/password_dart.dart';

import '../dao/usuario_dao.dart';
import '../models/usuario_model.dart';
import 'generic_service.dart';

class UsuarioService implements GenericService<UsuarioModel> {
  final UsuarioDAO _usuarioDAO;

  UsuarioService(this._usuarioDAO);

  @override
  Future<bool> delete(int id) async {
    return _usuarioDAO.delete(id);
  }

  @override
  Future<List<UsuarioModel>> findAll() async {
    return _usuarioDAO.findAll();
  }

  @override
  Future<UsuarioModel?> findOne(int id) {
    return _usuarioDAO.findOne(id);
  }

  @override
  Future<bool> save(UsuarioModel value) async {
    if (value.id != null) {
      return _usuarioDAO.update(value);
    } else {
      final hash = Password.hash(value.password!, PBKDF2());
      value.password = hash;

      return _usuarioDAO.create(value);
    }
  }

  Future<UsuarioModel?> findEmail(String email) {
    return _usuarioDAO.findByEmail(email);
  }
}
