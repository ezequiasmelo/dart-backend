import '../infra/database/db_configuration.dart';
import '../models/user_model.dart';
import 'dao.dart';

class UserDAO implements DAO<UserModel> {
  final DBConfiguration _dbConfiguration;
  UserDAO(this._dbConfiguration);

  @override
  Future<bool> create(UserModel value) async {
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
  Future<List<UserModel>> findAll() async {
    var result = await _dbConfiguration.execQuery('SELECT * FROM usuarios');
    return result
        .map((r) => UserModel.fromMap(r.fields))
        .toList()
        .cast<UserModel>();
  }

  @override
  Future<UserModel?> findOne(int id) async {
    var result = await _dbConfiguration
        .execQuery('SELECT * FROM usuarios WHERE id = ?', [id]);
    return result.isEmpty ? null : UserModel.fromMap(result.first.fields);
  }

  @override
  Future<bool> update(UserModel value) async {
    var result = await _dbConfiguration.execQuery(
      'UPDATE usuarios SET nome = ?, password = ? WHERE id = ?',
      [value.name, value.password, value.id],
    );
    return result.affectedRows > 0;
  }

  Future<UserModel?> findByEmail(String email) async {
    var result = await _dbConfiguration.execQuery(
        'SELECT id, email, password FROM usuarios WHERE email = ?', [email]);
    return result.affectedRows == 0
        ? null
        : UserModel.fromEmail(result.first.fields);
  }
}
