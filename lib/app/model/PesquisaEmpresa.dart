class PesquisaEmpresa {
  String? id;
  String? nome;
  String? razaoSocial;
  String? cnpjCpf;
  String? tipo;
  Plano? plano;
  String? fotoCapa;
  String? fotoPerfil;
  String? tipoAtendimento;
  bool? ativo;
  String? cadastro;
  String? inicioUtilizacaoApp;
  int? rating;
  String? informacoes;
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
  bool? confirmacaoAgendamentoAuto;
  bool? permiteAgendamentos;
  bool? perfilVisivel;
  bool? precosVisiveis;
  String? dynamicLink;
  String? intervalo;
  String? intervalo2;
  double? valorTaxaAtendimento;
  int? maxDiasAgendamentoFuturo;
  bool? usuarioAddClienteAutomatico;
  bool? validarHorarioAgendamentoManual;
  bool? validarHorarioAgendamentoApp;
  String? idEquipe;
  int? versionMobile;
  int? versionWeb;
  int? fake;
  bool? bloqueio;
  List<dynamic>? bloqueioData;
  String? bloqueioMotivo;
  int? diaVencimento;
  bool? verificarPagamento;
  int? periodoTesteDiasRestantes;
  String? periodoTestesDataFinal;
  String? displayEndereco;
  List<dynamic>? intervaloValid;
  bool? empresaFake;

  PesquisaEmpresa(
      {this.id,
      this.nome,
      this.razaoSocial,
      this.cnpjCpf,
      this.tipo,
      this.plano,
      this.fotoCapa,
      this.fotoPerfil,
      this.tipoAtendimento,
      this.ativo,
      this.cadastro,
      this.inicioUtilizacaoApp,
      this.rating,
      this.informacoes,
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
      this.confirmacaoAgendamentoAuto,
      this.permiteAgendamentos,
      this.perfilVisivel,
      this.precosVisiveis,
      this.dynamicLink,
      this.intervalo,
      this.intervalo2,
      this.valorTaxaAtendimento,
      this.maxDiasAgendamentoFuturo,
      this.usuarioAddClienteAutomatico,
      this.validarHorarioAgendamentoManual,
      this.validarHorarioAgendamentoApp,
      this.idEquipe,
      this.versionMobile,
      this.versionWeb,
      this.fake,
      this.bloqueio,
      this.bloqueioData,
      this.bloqueioMotivo,
      this.diaVencimento,
      this.verificarPagamento,
      this.periodoTesteDiasRestantes,
      this.periodoTestesDataFinal,
      this.displayEndereco,
      this.intervaloValid,
      this.empresaFake});

  PesquisaEmpresa.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    razaoSocial = json['razaoSocial'];
    cnpjCpf = json['cnpjCpf'];
    tipo = json['tipo'];
    plano = json['plano'] != null ? new Plano.fromJson(json['plano']) : null;
    fotoCapa = json['fotoCapa'];
    fotoPerfil = json['fotoPerfil'];
    tipoAtendimento = json['tipoAtendimento'];
    ativo = json['ativo'];
    cadastro = json['cadastro'];
    inicioUtilizacaoApp = json['inicioUtilizacaoApp'];
    rating = json['rating'];
    informacoes = json['informacoes'];
    facebook = json['facebook'];
    instagram = json['instagram'];
    site = json['site'];
    telefone = json['telefone'];
    email = json['email'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    endereco = json['endereco'];
    numero = json['numero'];
    bairro = json['bairro'];
    cep = json['cep'];
    cidade = json['cidade'];
    estado = json['estado'];
    complemento = json['complemento'];
    confirmacaoAgendamentoAuto = json['confirmacaoAgendamentoAuto'];
    permiteAgendamentos = json['permiteAgendamentos'];
    perfilVisivel = json['perfilVisivel'];
    precosVisiveis = json['precosVisiveis'];
    dynamicLink = json['dynamicLink'];
    intervalo = json['intervalo'];
    intervalo2 = json['intervalo2'];
    valorTaxaAtendimento = json['valorTaxaAtendimento'];
    maxDiasAgendamentoFuturo = json['maxDiasAgendamentoFuturo'];
    usuarioAddClienteAutomatico = json['usuarioAddClienteAutomatico'];
    validarHorarioAgendamentoManual = json['validarHorarioAgendamentoManual'];
    validarHorarioAgendamentoApp = json['validarHorarioAgendamentoApp'];
    idEquipe = json['idEquipe'];
    versionMobile = json['versionMobile'];
    versionWeb = json['versionWeb'];
    fake = json['fake'];
    bloqueio = json['bloqueio'];
    bloqueioData = json['bloqueioData'] == null ? [] : json['bloqueioData'];
    bloqueioMotivo = json['bloqueioMotivo'];
    diaVencimento = json['diaVencimento'];
    verificarPagamento = json['verificarPagamento'];
    periodoTesteDiasRestantes = json['periodoTesteDiasRestantes'];
    periodoTestesDataFinal = json['periodoTestesDataFinal'];
    displayEndereco = json['displayEndereco'];
    intervaloValid =
        json['intervaloValid'] == null ? [] : json['intervaloValid'];
    empresaFake = json['empresaFake'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['razaoSocial'] = this.razaoSocial;
    data['cnpjCpf'] = this.cnpjCpf;
    data['tipo'] = this.tipo;
    if (this.plano != null) {
      data['plano'] = this.plano!.toJson();
    }
    data['fotoCapa'] = this.fotoCapa;
    data['fotoPerfil'] = this.fotoPerfil;
    data['tipoAtendimento'] = this.tipoAtendimento;
    data['ativo'] = this.ativo;
    data['cadastro'] = this.cadastro;
    data['inicioUtilizacaoApp'] = this.inicioUtilizacaoApp;
    data['rating'] = this.rating;
    data['informacoes'] = this.informacoes;
    data['facebook'] = this.facebook;
    data['instagram'] = this.instagram;
    data['site'] = this.site;
    data['telefone'] = this.telefone;
    data['email'] = this.email;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['endereco'] = this.endereco;
    data['numero'] = this.numero;
    data['bairro'] = this.bairro;
    data['cep'] = this.cep;
    data['cidade'] = this.cidade;
    data['estado'] = this.estado;
    data['complemento'] = this.complemento;
    data['confirmacaoAgendamentoAuto'] = this.confirmacaoAgendamentoAuto;
    data['permiteAgendamentos'] = this.permiteAgendamentos;
    data['perfilVisivel'] = this.perfilVisivel;
    data['precosVisiveis'] = this.precosVisiveis;
    data['dynamicLink'] = this.dynamicLink;
    data['intervalo'] = this.intervalo;
    data['intervalo2'] = this.intervalo2;
    data['valorTaxaAtendimento'] = this.valorTaxaAtendimento;
    data['maxDiasAgendamentoFuturo'] = this.maxDiasAgendamentoFuturo;
    data['usuarioAddClienteAutomatico'] = this.usuarioAddClienteAutomatico;
    data['validarHorarioAgendamentoManual'] =
        this.validarHorarioAgendamentoManual;
    data['validarHorarioAgendamentoApp'] = this.validarHorarioAgendamentoApp;
    data['idEquipe'] = this.idEquipe;
    data['versionMobile'] = this.versionMobile;
    data['versionWeb'] = this.versionWeb;
    data['fake'] = this.fake;
    data['bloqueio'] = this.bloqueio;
    data['bloqueioData'] = this.bloqueioData;
    data['bloqueioMotivo'] = this.bloqueioMotivo;
    data['diaVencimento'] = this.diaVencimento;
    data['verificarPagamento'] = this.verificarPagamento;
    data['periodoTesteDiasRestantes'] = this.periodoTesteDiasRestantes;
    data['periodoTestesDataFinal'] = this.periodoTestesDataFinal;
    data['displayEndereco'] = this.displayEndereco;
    data['intervaloValid'] = this.intervaloValid;
    data['empresaFake'] = this.empresaFake;
    return data;
  }
}

class Plano {
  String? id;
  String? descricao;
  int? profissionais;
  int? itensCatalogo;
  double? percentualServico;
  String? tipoEmpresa;
  double? valor;
  double? desconto;
  bool? customizado;
  bool? acessoGerenciador;
  int? mesesGratis;
  int? fotosServico;
  bool? emptyPlano;

  Plano(
      {this.id,
      this.descricao,
      this.profissionais,
      this.itensCatalogo,
      this.percentualServico,
      this.tipoEmpresa,
      this.valor,
      this.desconto,
      this.customizado,
      this.acessoGerenciador,
      this.mesesGratis,
      this.fotosServico,
      this.emptyPlano});

  Plano.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descricao = json['descricao'];
    profissionais = json['profissionais'];
    itensCatalogo = json['itensCatalogo'];
    percentualServico = json['percentualServico'];
    tipoEmpresa = json['tipoEmpresa'];
    valor = json['valor'];
    desconto = json['desconto'];
    customizado = json['customizado'];
    acessoGerenciador = json['acessoGerenciador'];
    mesesGratis = json['mesesGratis'];
    fotosServico = json['fotosServico'];
    emptyPlano = json['emptyPlano'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['descricao'] = this.descricao;
    data['profissionais'] = this.profissionais;
    data['itensCatalogo'] = this.itensCatalogo;
    data['percentualServico'] = this.percentualServico;
    data['tipoEmpresa'] = this.tipoEmpresa;
    data['valor'] = this.valor;
    data['desconto'] = this.desconto;
    data['customizado'] = this.customizado;
    data['acessoGerenciador'] = this.acessoGerenciador;
    data['mesesGratis'] = this.mesesGratis;
    data['fotosServico'] = this.fotosServico;
    data['emptyPlano'] = this.emptyPlano;
    return data;
  }
}
