import 'dart:async';
import 'package:agenda_beauty_online/app/model/UserNotValidated.dart';
import 'package:agenda_beauty_online/app/model/Usuario.dart';
import 'package:agenda_beauty_online/app/service/service_base.dart';
import 'package:agenda_beauty_online/app/service/service_config.dart';
import 'package:http/http.dart' as http;
import 'package:agenda_beauty_online/app/util/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../repository/user_repository.dart' as repository;
import 'dart:convert';
import 'dart:convert' as convert;

class UsuarioService extends ServiceBase {
  UsuarioService() : super('user');

  static Future<Map> getEnderecoByCep(String cep) async {
    print('getEnderecoByCep');
    print(cep);

    var Http = new http.Client();

    List lista = [];

    Map endereco = {};

    List<Map<DateTime, List>> listTeste2 = [];

    await Http.get(
      Uri.parse('https://viacep.com.br/ws/${cep}/json/'),
    ).timeout(new Duration(seconds: 60)).then((response) async {
      print("Response dados statusCode: ${response.statusCode}");
      // print("Response dados body: ${response.body}");

      if (response.statusCode == 200) {
        var enderecoJSON = json.decode(response.body);

        endereco = enderecoJSON;
      }
    });

    return endereco;
  }

  Future<bool> sendPasswordResetEmail(String email) async {
    var url = '$baseUrl/enviarEmailAlterarSenha';
    final headers = {'Content-type': "application/x-www-form-urlencoded"};
    final body = {"email": email};

    final response =
        await http.post(Uri.parse(url), headers: headers, body: body);

    Utils()
        .printAB("sendPasswordResetEmail do servidor: ${response.statusCode}");

    return response.statusCode == 200;
  }

  Future<bool> updateAppVersion(
      String platform, int newVersion, String userId) async {
    final url = '$baseUrl/updateAppVersion';

    final versionUpdtJSON = {
      "userId": userId,
      "platforma": platform,
      "tipo": "PRO",
      "version": newVersion
    };

    Utils().printAB('----------versionUpdtJSON -------');
    Utils().printAB(versionUpdtJSON);

    final response = await dio!.put(url, data: versionUpdtJSON);

    return response.statusCode == 200;
  }

  Future<bool> updateAppVersionAppCLi(
      String platform, int newVersion, String userId) async {
    final url = '$baseUrl/updateAppVersion';

    final versionUpdtJSON = {
      "userId": userId,
      "platforma": platform,
      "tipo": "CLI",
      "version": newVersion
    };

    Utils().printAB('----------versionUpdtJSON -------');
    Utils().printAB(versionUpdtJSON);

    final response = await dio!.put(url, data: versionUpdtJSON);

    return response.statusCode == 200;
  }

  Future<Usuario> update(Usuario usuario) async {
    Utils().printAB("usuario update antes: ${usuario.toString()}");

    var url = '$baseUrl/update';

    if ((usuario.pictureUrl == null) &&
        usuario.pictureUrlOld != null &&
        usuario.pictureUrlOld is String) {
      // firebaseStoreService.removePhoto(usuario.pictureUrlOld);
    }

    var retorno = await dio!.put(url, data: usuario.toJson());

    var usuarioJSON = Usuario.fromJson(retorno.data);

    Utils().printAB("usuario update depois: ${usuarioJSON.toJson()}");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('phone', usuarioJSON.phoneNumber.toString());

    repository.setCurrentUserAB(usuarioJSON.toJson());

    return Usuario.fromJson(retorno.data);
  }

  Future<bool> updatePhoneValidate(Usuario usuario) async {
    Utils().printAB("usuario update antes: ${usuario.toString()}");

    var url = '$baseUrl/updatePhone/${usuario.id}/${usuario.phoneNumber}/true';

    var retorno = await dio!.put(url, data: usuario.toJson());

    return retorno.statusCode == 200;
  }

  Future<bool> updateEmail(Usuario usuario) async {
    Utils().printAB("usuario update antes: ${usuario.toString()}");

    var url = '$baseUrl/changeEmail';

    var retorno = await dio!.put(url, data: usuario.toJson());

    return retorno.statusCode == 200;
  }

  solicitarEcluirConta(Map<String, String> cancelamentoData) async {
    var url = '$baseUrl/deleteAccountRequest';
    Utils().printAB('solicitarEcluirConta');
    Utils().printAB(cancelamentoData);

    final response = await dio!.put(url, data: cancelamentoData);

    return response.statusCode == 200;
  }

  Future<bool> enviarEmailVerificacao() async {
    var url = '$baseUrl/enviarEmailVerificacao';

    var retorno = await dio?.post(url);

    return retorno!.statusCode == 200;
  }

  Future<Usuario> load(String id) async {
    final retorno =
        await doGET<Map>('$baseUrl/full/$id', headers: {}, queryParameters: {});
    return Usuario.fromJson(retorno.data as dynamic);
  }

  Future<String> generateCustomToken() async {
    var url = '$baseUrl/getCustomToken';
    final result = await doGET(url, headers: {}, queryParameters: {});
    final data = result.data as Map;
    return data['token'].toString();
  }

  Future<List<UserNotValidated>> usuariosSemValidacao() async {
    Utils().printAB('GET usuariosSemValidacao');

    // if(currentUserAB.value.id == null){
    //   return [];
    // }

    final url = Environment.baseUrl + "/user/notValidated";

    Utils().printAB('GET responseMap usuariosSemValidacao url: ${url}');

    final responseMap =
        await doGET<List>(url, headers: {}, queryParameters: {});

    Utils().printAB(
        'GET responseMap usuariosSemValidacao: ${responseMap.toString().length}');
    Utils().printAB(responseMap.toString());

    return responseMap.data!.map((p) => UserNotValidated.fromJson(p)).toList();
  }
}
