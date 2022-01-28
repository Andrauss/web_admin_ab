import 'dart:convert';
import 'package:agenda_beauty_online/app/model/EmpresaPesquisa.dart';
import 'package:agenda_beauty_online/app/model/PageModel.dart';
import 'package:agenda_beauty_online/app/model/PesquisaEmpresa.dart';
import 'package:agenda_beauty_online/app/util/Utils.dart';
import 'package:agenda_beauty_online/app/model/empresa_perfil/EmpresaPerfil.dart';
import 'package:agenda_beauty_online/app/service/service_base.dart';

class EmpresaPerfilService extends ServiceBase {
  EmpresaPerfilService() : super("empresa");

  Future<EmpresaPerfil> getEmpresaPerfil(String idEmpresa) async {
    final url = "$baseUrl/perfil/$idEmpresa";

    final responseMap = await doGET(url, headers: {}, queryParameters: {});

//    Utils().printAB('perfil empresa');
//    Utils().printAB(responseMap.data);

    return EmpresaPerfil.fromJson(responseMap.data);
  }

  Future<EmpresaPerfil> getEmpresaByidBeauty(String nomeEmpresa) async {
    final url = "$baseUrl/perfil/idBeauty/$nomeEmpresa";

    final responseMap = await doGET(url);

    print('getEmpresaPerfilByNome $responseMap');

    return EmpresaPerfil.fromJson(responseMap.data);
  }

  Future<PagedModel<PesquisaEmpresa>> listPaged({
    dynamic? search,
    int? size = 10,
    int? page = 0,
  }) async {
    final url = "$baseUrl/pesquisa";

    var dados = {
      "cnpjCpf": null,
      "email": null,
      "equipeId": null,
      "estado": null,
      "id": null,
      "telefone": null,
      "nome": search
    };

    final responseMap = await dio!.post(url, data: search, queryParameters: {
      // 'search': search,
      'size': size?.toString(),
      'page': page?.toString()
    });

    return PagedModel<PesquisaEmpresa>.fromJson(
        responseMap.data, (json) => PesquisaEmpresa.fromJson(json as dynamic));
  }

  Future<PesquisaEmpresa> getEmpresaPesquisa(String nomeEmpresa) async {
    final url = "$baseUrl/pesquisa";

    var dados = {
      "cnpjCpf": null,
      "email": null,
      "equipeId": null,
      "estado": null,
      "id": null,
      "telefone": null,
      "nome": nomeEmpresa
    };

    final responseMap = await dio!.post(url, data: dados);

    var retorno;

    print('getEmpresaPesquisa result');
    print(responseMap.data);

    retorno = PesquisaEmpresa.fromJson(responseMap.data);

    return retorno;
  }

  Future<List<EmpresaPesquisa>> getEmpresaSearch(String nomeEmpresa) async {
    final url = "$baseUrl/listContextual";

    var dados = {"search": nomeEmpresa};
    final responseMap = await dio!.post(url, data: dados);

    // print('getEmpresaSearch JSON');
    // print(responseMap.data);

    List<EmpresaPesquisa> lista = [];

    // print('getEmpresaSearch 1: ${listaDados.length}');

    if (responseMap.data.length > 0) {
      for (var dados in responseMap.data) {
        // print('Empresa: $dados');

        lista.add(EmpresaPesquisa.fromJson(dados));
      }
    }

    // print('getEmpresaSearch 2: ${lista.length}');

    // var lista = responseMap.data.map((a) => EmpresaPesquisa.fromJson(a));

    // print('getEmpresaSearch 2: ${lista[0]}');

    return lista;
  }

  Future<void> setFavorita(String idEmpresa) async {
    final url = "$baseUrl/usuario/usuarioFavorito/isFavorito/$idEmpresa";

    final responseMap = await doGET(url);

//    Utils().printAB('perfil empresa');
//    Utils().printAB(responseMap.data);
  }

  Future<void> enviarSugestao(String empresa, String telefone) async {
    final bodyMap = {
      "empresa": empresa,
      "telefone": telefone,
    };

    final body = json.encode(bodyMap);

    Utils().printAB("enviarSugestao: ${body}");

    final url = "$baseUrl/sendSugestaoEmpresaMail";

    final response = await dio?.post(url, data: bodyMap);

//    Utils().printAB("enviarSugestao response data: ${response.data["content"]}");
  }
}
