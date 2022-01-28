import 'package:agenda_beauty_online/app/model/Usuario.dart';

class Endereco {
  String? id;
  String? nome;
  double? latitude;
  double? longitude;
  String? endereco;
  String? numero;
  String? bairro;
  String? cidade;
  String? estado;
  String? cep;
  String? complemento;
  String? display;
  Usuario? usuario;
  DateTime? cadastro;
  bool? principal = false;
  String? tipo;
  String? referencia;
  bool? jump = false;

  Endereco({
    this.id,
    this.nome,
    this.latitude,
    this.longitude,
    this.endereco,
    this.numero,
    this.bairro,
    this.cidade,
    this.estado,
    this.cep,
    this.complemento,
    this.display,
    this.usuario,
    this.cadastro,
    this.referencia,
    this.principal,
    this.tipo,
  });

  String? getEnderecoToDisplay() {
    var enderecoParts = [endereco, numero, bairro, cidade];
    var enderecoPartsFiltered =
        enderecoParts.where((ep) => ep != null && ep.trim().length > 0);

    if (enderecoPartsFiltered.length == 0) {
      return '';
    }
    return enderecoPartsFiltered.join(', ');
  }

  static Map getEstadosMap() {
    final map = {
      'AC': 'Acre',
      'AL': 'Alagoas',
      'AP': 'Amapá',
      'AM': 'Amazonas',
      'BA': 'Bahia',
      'CE': 'Ceará',
      'DF': 'Distrito Federal',
      'ES': 'Espírito Santo',
      'GO': 'Goiás',
      'MA': 'Maranhão',
      'MT': 'Mato Grosso',
      'MS': 'Mato Grosso do Sul',
      'MG': 'Minas Gerais',
      'PA': 'Pará',
      'PB': 'Paraíba',
      'PR': 'Paraná',
      'PE': 'Pernambuco',
      'PI': 'Piauí',
      'RJ': 'Rio de Janeiro',
      'RN': 'Rio Grande do Norte',
      'RS': 'Rio Grande do Sul',
      'RO': 'Rondônia',
      'RR': 'Roraima',
      'SC': 'Santa Catarina',
      'SP': 'São Paulo',
      'SE': 'Sergipe',
      'TO': 'Tocantins',
      'UFs': 'Todos os estados(UF)'
    };
    return map;
  }

  static getEstadoByUF(String? uf) {
    final map = getEstadosMap();
    return map[uf] ?? '';
  }

  factory Endereco.fromJson(Map<String?, dynamic> json) => Endereco(
        id: json["id"],
        nome: json["nome"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        endereco: json["endereco"],
        numero: json["numero"],
        bairro: json["bairro"],
        cidade: json["cidade"],
        tipo: json["tipo"],
        cep: json["cep"],
        estado: json["estado"],
        principal: json["principal"],
        referencia: json["referencia"],
      );

  @override
  String toString() {
    return 'Endereco{id: $id, nome: $nome, latitude: $latitude, longitude: $longitude, endereco: $endereco, numero: $numero, bairro: $bairro, cidade: $cidade, estado: $estado, cep: $cep, complemento: $complemento, display: $display, usuario: $usuario, cadastro: $cadastro, principal: $principal, tipo: $tipo, referencia: $referencia, jump: $jump}';
  }
}
