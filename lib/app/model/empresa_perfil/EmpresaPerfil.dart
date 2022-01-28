import 'package:agenda_beauty_online/app/model/empresa_perfil/Horarios.dart';

class EmpresaPerfil {
  EmpresaPerfil({
    this.id,
    this.nome,
    this.fotoCapa,
    this.fotoPerfil,
    this.tipoAtendimento,
    this.ativo,
    this.permiteAgendamentos,
    this.perfilVisivel,
    this.precosVisiveis,
    this.dynamicLink,
    this.informacoes,
    this.valorTaxaAtendimento,
    this.maxDiasAgendamentoFuturo,
    this.facebook,
    this.instagram,
    this.site,
    this.telefone,
    this.email,
    this.latitude,
    this.longitude,
    this.endereco,
    this.numero,
    this.bairro,
    this.cep,
    this.cidade,
    this.estado,
    this.complemento,
    this.horarios,
  });

  String? id;
  String? nome;
  String? fotoCapa;
  String? fotoPerfil;
  String? tipoAtendimento;
  bool? ativo;
  bool? permiteAgendamentos;
  bool? perfilVisivel;
  bool? precosVisiveis;
  String? dynamicLink;
  String? informacoes;
  double? valorTaxaAtendimento;
  int? maxDiasAgendamentoFuturo;
  String? facebook;
  String? instagram;
  String? site;
  String? telefone;
  String? email;
  double? latitude;
  double? longitude;
  String? endereco;
  String? numero;
  String? bairro;
  String? cep;
  String? cidade;
  String? estado;
  String? complemento;
  List<Horario>? horarios;

  factory EmpresaPerfil.fromJson(Map<String?, dynamic> json) => EmpresaPerfil(
        id: json["id"],
        nome: json["nome"],
        fotoCapa: json["fotoCapa"],
        fotoPerfil: json["fotoPerfil"],
        tipoAtendimento: json["tipoAtendimento"],
        ativo: json["ativo"],
        permiteAgendamentos: json["permiteAgendamentos"],
        perfilVisivel: json["perfilVisivel"],
        precosVisiveis: json["precosVisiveis"],
        dynamicLink: json["dynamicLink"],
        informacoes: json["informacoes"],
        valorTaxaAtendimento: json["valorTaxaAtendimento"],
        maxDiasAgendamentoFuturo: json["maxDiasAgendamentoFuturo"],
        facebook: json["facebook"],
        instagram: json["instagram"],
        site: json["site"],
        telefone: json["telefone"],
        email: json["email"],
        latitude: json["latitude"] == null ? 0.0 : json["latitude"],
        longitude: json["longitude"] == null ? 0.0 : json["longitude"],
        endereco: json["endereco"],
        numero: json["numero"],
        bairro: json["bairro"],
        cep: json["cep"],
        cidade: json["cidade"],
        estado: json["estado"],
        complemento: json["complemento"],
        horarios: json["horarios"] == null
            ? []
            : List<Horario>.from(
                json["horarios"].map((x) => Horario.fromJson(x))),
      );

  Map<String?, dynamic> toJson() => {
        "id": id,
        "nome": nome,
        "fotoCapa": fotoCapa,
        "fotoPerfil": fotoPerfil,
        "tipoAtendimento": tipoAtendimento,
        "ativo": ativo,
        "permiteAgendamentos": permiteAgendamentos,
        "perfilVisivel": perfilVisivel,
        "precosVisiveis": precosVisiveis,
        "dynamicLink": dynamicLink,
        "informacoes": informacoes,
        "valorTaxaAtendimento": valorTaxaAtendimento,
        "maxDiasAgendamentoFuturo": maxDiasAgendamentoFuturo,
        "facebook": facebook,
        "instagram": instagram,
        "site": site,
        "telefone": telefone,
        "email": email,
        "latitude": latitude,
        "longitude": longitude,
        "endereco": endereco,
        "numero": numero,
        "bairro": bairro,
        "cep": cep,
        "cidade": cidade,
        "estado": estado,
        "complemento": complemento,
//    "horarios": List<Horario>.from(horarios.map((x) => x.toJson())),
      };

  String? getDisplayEndereco() {
    var enderecoParts = [endereco, numero, bairro, cidade];
    var enderecoPartsFiltered =
        enderecoParts.where((ep) => ep != null && ep.trim().length > 0);

    if (enderecoPartsFiltered.length == 0) {
      return 'Endereço não informado';
    }
    return enderecoPartsFiltered.join(', ');
  }

  @override
  String toString() {
    return 'EmpresaPerfil{id: $id, nome: $nome, fotoCapa: $fotoCapa, fotoPerfil: $fotoPerfil, tipoAtendimento: $tipoAtendimento, ativo: $ativo, permiteAgendamentos: $permiteAgendamentos, perfilVisivel: $perfilVisivel, precosVisiveis: $precosVisiveis, dynamicLink: $dynamicLink, informacoes: $informacoes, valorTaxaAtendimento: $valorTaxaAtendimento, maxDiasAgendamentoFuturo: $maxDiasAgendamentoFuturo, facebook: $facebook, instagram: $instagram, site: $site, telefone: $telefone, email: $email, latitude: $latitude, longitude: $longitude, endereco: $endereco, numero: $numero, bairro: $bairro, cep: $cep, cidade: $cidade, estado: $estado, complemento: $complemento, horarios: $horarios}';
  }
}
