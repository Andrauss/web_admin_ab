import 'Plano.dart';
import 'enums/TipoAtendimento.dart';
import 'enums/TipoEmpresa.dart';
import 'horario_perfil.dart';

class Empresa {
  String? id;
  String? nome;
  String? razaoSocial;
  String? cnpjCpf;
  String? informacoes;
  String? dynamicLink;
  TipoEmpresa? tipo;
  dynamic fotoCapa;
  dynamic fotoPerfil;
  dynamic fotoPerfilOld;
  dynamic fotoCapaOld;
  Plano? plano;
  TipoAtendimento? tipoAtendimento;
  bool? ativo = true;
  double? latitude;
  double? longitude;
  String? endereco;
  String? numero;
  String? bairro;
  String? complemento;
  String? cidade;
  String? cep;
  String? telefone;
  String? email;
  String? estado;

  String? facebook;
  String? instagram;
  String? intervalo;
  bool? perfilVisivel;
  bool? permiteAgendamentos;
  bool? precosVisiveis;
  String? site;

  double? valorTaxaAtendimento;
  int? maxDiasAgendamentoFuturo;

  int? versionMobile;
  int? versionWeb;
  bool? usuarioAddClienteAutomatico;
  bool? validarHorarioAgendamentoManual;
  bool? validarHorarioAgendamentoApp;

  List<Horario>? horarios;

  Empresa({
    this.ativo = true,
    this.bairro,
    this.cep,
    this.cidade,
    this.cnpjCpf,
    this.complemento,
    this.dynamicLink,
    this.informacoes,
    this.endereco,
    this.estado,
    this.facebook,
    this.fotoCapa,
    this.fotoPerfil,
    this.id,
    this.instagram,
    this.intervalo,
    this.latitude,
    this.longitude,
    this.nome,
    this.numero,
    this.perfilVisivel,
    this.permiteAgendamentos,
    this.plano,
    this.precosVisiveis,
    this.razaoSocial,
    this.site,
    this.telefone,
    this.email,
    this.tipo,
    this.tipoAtendimento,
    this.valorTaxaAtendimento,
    this.maxDiasAgendamentoFuturo,
    this.versionMobile,
    this.versionWeb,
    this.usuarioAddClienteAutomatico,
    this.validarHorarioAgendamentoManual,
    this.validarHorarioAgendamentoApp,
    this.horarios,
  });

  factory Empresa.fromJson(Map<String, dynamic> json) => (Empresa(
        ativo: json["ativo"] == null ? true : json["ativo"],
        bairro: json["bairro"],
        informacoes: json["informacoes"],
        cep: json["cep"],
        cidade: json["cidade"],
        cnpjCpf: json["cnpjCpf"],
        complemento: json["complemento"],
        dynamicLink: json["dynamicLink"],
        endereco: json["endereco"],
        estado: json["estado"],
        facebook: json["facebook"],
        fotoCapa: json["fotoCapa"],
        fotoPerfil: json["fotoPerfil"],
        valorTaxaAtendimento: json["valorTaxaAtendimento"],
        maxDiasAgendamentoFuturo: json["maxDiasAgendamentoFuturo"],
        id: json["id"],
        instagram: json["instagram"],
        intervalo: json["intervalo"],
        latitude: json['latitude'] == null
            ? -12.00
            : double.tryParse(json['latitude'].toString()),
        longitude: json['longitude'] == null
            ? -45.00
            : double.tryParse(json['longitude'].toString()),
        nome: json["nome"],
        numero: json["numero"],
        perfilVisivel: json["perfilVisivel"] ?? true,
        permiteAgendamentos: json["permiteAgendamentos"] ?? true,
        plano: json["plano"] == null ? null : Plano.fromJson(json["plano"]),
        precosVisiveis: json["precosVisiveis"] ?? true,
        razaoSocial: json["razaoSocial"],
        site: json["site"],
        telefone: json["telefone"],
        email: json["email"],
        tipo: tipoEmpresaFromString(json['tipo'].toString()),
        tipoAtendimento:
            tipoAtendimentoFromString(json['tipoAtendimento'].toString()),
        versionMobile: json['versionMobile'],
        versionWeb: json['versionWeb'],
        usuarioAddClienteAutomatico: json['usuarioAddClienteAutomatico'],
        validarHorarioAgendamentoManual:
            json['validarHorarioAgendamentoManual'],
        validarHorarioAgendamentoApp: json['validarHorarioAgendamentoApp'],
        horarios: json["horarios"] == null
            ? []
            : List<Horario>.from(
                json["horarios"].map((x) => Horario.fromJson(x))),
      )..fotoCapaOld = json['fotoCapa'])
        ..fotoPerfilOld = json['fotoPerfil'];

  String getDisplayEndereco() {
    var enderecoParts = [endereco, numero, bairro, cidade];
    var enderecoPartsFiltered =
        enderecoParts.where((ep) => ep != null && ep.trim().length > 0);

    if (enderecoPartsFiltered.length == 0) {
      return 'Endereço não informado';
    }
    return enderecoPartsFiltered.join(', ');
  }

  String getTipoDocumentoDescricao() {
    return tipo == TipoEmpresa.AUTONOMO ? 'CPF' : 'CNPJ';
  }

  static Empresa createEmpty() {
    return Empresa(
        telefone: '',
        numero: '',
        endereco: '',
        cidade: '',
        bairro: '',
        email: '',
        nome: '',
        ativo: true,
        cep: '',
        cnpjCpf: '',
        complemento: '',
        dynamicLink: '',
        estado: '',
        facebook: '',
        id: '',
        informacoes: '',
        instagram: '',
        intervalo: '',
        latitude: null,
        longitude: null,
        perfilVisivel: true,
        permiteAgendamentos: true,
        precosVisiveis: true,
        razaoSocial: '',
        site: '',
        maxDiasAgendamentoFuturo: 90,
        valorTaxaAtendimento: 0,
        tipo: TipoEmpresa.CNPJ,
        tipoAtendimento: TipoAtendimento.AMBOS);
  }

  bool hasFotoPerfilToSend() {
    return fotoPerfil != null && !(fotoPerfil is String);
  }

  bool hasFotoPerfilToDel() {
    return fotoPerfilOld != null && (fotoPerfilOld is String);
  }

  bool hasFotoCapaToDel() {
    return fotoCapaOld != null && (fotoCapaOld is String);
  }

  bool hasFotoCapaToSend() {
    return fotoCapa != null && !(fotoCapa is String);
  }

  @override
  String toString() {
    return 'Empresa{id: $id, nome: $nome, razaoSocial: $razaoSocial, cnpjCpf: $cnpjCpf, informacoes: $informacoes, dynamicLink: $dynamicLink, tipo: $tipo, fotoCapa: $fotoCapa, fotoPerfil: $fotoPerfil, fotoPerfilOld: $fotoPerfilOld, fotoCapaOld: $fotoCapaOld, plano: $plano, tipoAtendimento: $tipoAtendimento, ativo: $ativo, latitude: $latitude, longitude: $longitude, endereco: $endereco, numero: $numero, bairro: $bairro, complemento: $complemento, cidade: $cidade, cep: $cep, telefone: $telefone, email: $email, estado: $estado, facebook: $facebook, instagram: $instagram, intervalo: $intervalo, perfilVisivel: $perfilVisivel, permiteAgendamentos: $permiteAgendamentos, precosVisiveis: $precosVisiveis, site: $site, valorTaxaAtendimento: $valorTaxaAtendimento, maxDiasAgendamentoFuturo: $maxDiasAgendamentoFuturo, versionMobile: $versionMobile, versionWeb: $versionWeb, usuarioAddClienteAutomatico: $usuarioAddClienteAutomatico, validarHorarioAgendamentoManual: $validarHorarioAgendamentoManual, validarHorarioAgendamentoApp: $validarHorarioAgendamentoApp, horarios: $horarios}';
  }
}
