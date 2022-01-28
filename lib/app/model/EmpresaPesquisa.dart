class EmpresaPesquisa {
  String? id;
  String? nome;
  int? rating;
  bool? favorite;
  String? fotoCapa;
  String? fotoPerfil;
  String? tipoAtendimento;
  String? tipo;
  bool? permiteAgendamentos;
  bool? precosVisiveis;
  int? valorTaxaAtendimento;
  int? maxDiasAgendamentoFuturo;
  double? latitude;
  double? longitude;
  String? enderecoShort;
  String? enderecoFull;
  int? distancia;
  bool? bloqueio;
  List<dynamic>? servicosSearch;
  List<dynamic>? tiposServico;
  String? fotoCapaToSort;

  EmpresaPesquisa(
      {this.id,
      this.nome,
      this.rating,
      this.favorite,
      this.fotoCapa,
      this.fotoPerfil,
      this.tipoAtendimento,
      this.tipo,
      this.permiteAgendamentos,
      this.precosVisiveis,
      this.valorTaxaAtendimento,
      this.maxDiasAgendamentoFuturo,
      this.latitude,
      this.longitude,
      this.enderecoShort,
      this.enderecoFull,
      this.distancia,
      this.bloqueio,
      this.fotoCapaToSort});

  EmpresaPesquisa.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    rating = json['rating'];
    favorite = json['favorite'];
    fotoCapa = json['fotoCapa'];
    fotoPerfil = json['fotoPerfil'];
    tipoAtendimento = json['tipoAtendimento'];
    tipo = json['tipo'];
    permiteAgendamentos = json['permiteAgendamentos'];
    precosVisiveis = json['precosVisiveis'];
    valorTaxaAtendimento = json['valorTaxaAtendimento'];
    maxDiasAgendamentoFuturo = json['maxDiasAgendamentoFuturo'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    enderecoShort = json['enderecoShort'];
    enderecoFull = json['enderecoFull'];
    distancia = json['distancia'];
    bloqueio = json['bloqueio'];
    fotoCapaToSort = json['fotoCapaToSort'];
    tiposServico = [];
    servicosSearch = [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['rating'] = this.rating;
    data['favorite'] = this.favorite;
    data['fotoCapa'] = this.fotoCapa;
    data['fotoPerfil'] = this.fotoPerfil;
    data['tipoAtendimento'] = this.tipoAtendimento;
    data['tipo'] = this.tipo;
    data['permiteAgendamentos'] = this.permiteAgendamentos;
    data['precosVisiveis'] = this.precosVisiveis;
    data['valorTaxaAtendimento'] = this.valorTaxaAtendimento;
    data['maxDiasAgendamentoFuturo'] = this.maxDiasAgendamentoFuturo;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['enderecoShort'] = this.enderecoShort;
    data['enderecoFull'] = this.enderecoFull;
    data['distancia'] = this.distancia;
    data['bloqueio'] = this.bloqueio;
    data['fotoCapaToSort'] = this.fotoCapaToSort;
    return data;
  }
}
