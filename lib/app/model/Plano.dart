import 'enums/TipoEmpresa.dart';

class Plano {
  String? id;
  String? descricao;
  int? profissionais;
  int? itensCatalogo;
  double? percentualServico; // Somente para autônomos
  bool? acessoGerenciador;
  int? mesesGratis;
  TipoEmpresa? tipoEmpresa;
  double? valor;
  bool? emptyPlano; // Definir o plano após o primeiro mês grátis

  Plano();

  Plano.builder(
      {this.id,
      this.descricao,
      this.profissionais,
      this.mesesGratis,
      this.acessoGerenciador,
      this.itensCatalogo,
      this.percentualServico,
      this.tipoEmpresa,
      this.emptyPlano = false,
      this.valor});

  Plano.empty(
      {this.emptyPlano = true,
      this.descricao = 'Teste sem compromisso',
      this.profissionais = 3,
      this.mesesGratis = 1,
      this.acessoGerenciador = true,
      this.itensCatalogo = 10,
      this.valor = 0,
      this.percentualServico = 0});

  Plano.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      id = json['id'].toString();
      descricao = json['descricao'].toString();
      profissionais = int.parse(json['profissionais'].toString());
      itensCatalogo = int.parse(json['itensCatalogo'].toString());
      mesesGratis = int.parse(json['mesesGratis'].toString());
      percentualServico = double.parse(json['percentualServico'].toString());
      valor = double.parse(json['valor'].toString());
      acessoGerenciador = json['acessoGerenciador'];
      emptyPlano = json['emptyPlano'];
      tipoEmpresa = tipoEmpresaFromString(json['tipoEmpresa'].toString());
    }
  }
}
