import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UsuarioModel {
  int? id;
  String? name;
  String? email;
  String? password;
  bool? isActived;
  DateTime? dtCreated;
  DateTime? dtUpdated;

  UsuarioModel();

  UsuarioModel.create({
    this.id,
    this.name,
    this.email,
    this.isActived,
    this.dtCreated,
    this.dtUpdated,
  });

  factory UsuarioModel.fromMap(Map<String, dynamic> map) {
    return UsuarioModel.create(
      id: map['id'] as int,
      name: map['nome'] as String,
      email: map['email'] as String,
      isActived: map['is_ativo'] == 1,
      dtCreated: map['dt_criacao'],
      dtUpdated: map['dt_autalizacao'],
    );
  }

  factory UsuarioModel.fromRequest(Map map) {
    return UsuarioModel()
      ..name = map['name']
      ..email = map['email']
      ..password = map['password'];
  }

  @override
  String toString() {
    return 'UsuarioModel(id: $id, name: $name, email: $email, isActived: $isActived, dtCreated: $dtCreated, dtUpdated: $dtUpdated)';
  }
}
