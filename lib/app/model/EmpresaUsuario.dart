import 'Empresa.dart';
import 'Usuario.dart';
import 'enums/RelacaoEmpresaUsuario.dart';

class EmpresaUsuario {
  String? id;
  Empresa? empresa;
  Usuario? usuario;
  bool? ativo = true;
  RelacaoEmpresaUsuario? relacao;

  EmpresaUsuario();

  EmpresaUsuario.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    empresa = Empresa.fromJson(json['empresa']);
    usuario = Usuario.fromJson(json['usuario']);
    ativo = json['ativo'];
    relacao = relacaoEmpresaUsuarioFromString(json['relacao']);
  }
}
