import '../infra/database/db_configuration.dart';
import '../models/usuario_model.dart';
import 'dao.dart';

class UsuarioDAO implements DAO<UsuarioModel> {
  final DBConfiguration _dbConfiguration;
  UsuarioDAO(this._dbConfiguration);

  @override
  Future<bool> create(UsuarioModel value) async {
    var result = await _dbConfiguration.execQuery(
      'INSERT INTO usuarios (nome, email, password) VALUES (?, ?, ?)',
      [value.name, value.email, value.password],
    );
    return result.affectedRows > 0;
  }

  @override
  Future<bool> delete(int id) async {
    var result = await _dbConfiguration
        .execQuery('DELETE FROM usuarios WHERE id = ?', [id]);
    return result.affectedRows > 0;
  }

  @override
  Future<List<UsuarioModel>> findAll() async {
    var result = await _dbConfiguration.execQuery('SELECT * FROM usuarios');
    // return (result as List).map((e) => UsuarioModel.fromMap(e.fields)).toList();
    return result
        .map((r) => UsuarioModel.fromMap(r.fields))
        .toList()
        .cast<UsuarioModel>();
  }

  @override
  Future<UsuarioModel?> findOne(int id) async {
    var result = await _dbConfiguration
        .execQuery('SELECT * FROM usuarios WHERE id = ?', [id]);
    return result.isEmpty ? null : UsuarioModel.fromMap(result.first.fields);
  }

  @override
  Future<bool> update(UsuarioModel value) async {
    var result = await _dbConfiguration.execQuery(
      'UPDATE usuarios SET nome = ?, password = ? WHERE id = ?',
      [value.name, value.password, value.id],
    );
    return result.affectedRows > 0;
  }

  Future<UsuarioModel?> findByEmail(String email) async {
    var result = await _dbConfiguration.execQuery(
        'SELECT id, email, password FROM usuarios WHERE email = ?', [email]);
    return result.affectedRows == 0
        ? null
        : UsuarioModel.fromEmail(result.first.fields);
  }
}
