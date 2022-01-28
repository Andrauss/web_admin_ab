import 'dart:convert';
import 'package:agenda_beauty_online/app/model/Usuario.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:agenda_beauty_online/app/repository/user_repository.dart'
    as userRepo;

import 'dart:js' as js;

class Utils {
  static ValueNotifier<Usuario> currentUser = new ValueNotifier(Usuario());
  static ValueNotifier<bool> resultLogin = new ValueNotifier(false);
  static ValueNotifier<String> URL = new ValueNotifier('');
  static ValueNotifier<double> tWIDTH = new ValueNotifier(0);
  static ValueNotifier<double> tHEIGHT = new ValueNotifier(0);

  void getHostURL() {
    String host = js.context['location']['href'].toString();

    if (host.contains('http://localhost')) {
      URL.value = '';
    } else if (host.contains('10.0.0.100')) {
      URL.value = 'http://localhost';
    } else {
      URL.value = 'http://localhost';
    }
    Utils().printAB('URL setada: ${host.split('/').first}');
    URL.notifyListeners();
  }

  void setCurrentUser(jsonString) async {
    if (json.decode(jsonString)[0] != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          'current_user', json.encode(json.decode(jsonString)[0]));
    }
  }

  Future<Usuario> getCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('current_user_ab')) {
      // currentUser.value = Usuario.fromJson(
      //     json.decode(await prefs.get('current_user_ab') as dynamic));

      var resultD = await userRepo
          .dencrypt(prefs.getString('current_user_ab').toString());

      Usuario user = Usuario.fromJson(resultD as dynamic);

      Utils().printAB('current_user_ab getCurrentUser - resultD');
      Utils().printAB(resultD);

      currentUser.value = user;
    }
    currentUser.notifyListeners();
    return currentUser.value;
  }

  Future<void> logout() async {
    currentUser.value = new Usuario();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('current_user_ab');
    await prefs.remove('abu');
    await prefs.remove('abp');
    await prefs.remove('phone');
    await prefs.remove('usuarioConvidado');
  }

  Future setarLogado(bool valor) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('logou', valor);
  }

  Future getLogado() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getBool('logou');
  }

  Future setUsuarioADMIN(bool valor) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('usuarioADM', valor);
  }

  Future<bool> getUsuarioADMIN() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? retorno = await prefs.getBool('usuarioADM');

    return retorno!;
  }

  Future setUsuarioID(int valor) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('usuarioID', valor);
  }

  Future<int> getUsuarioID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? usuarioID = await prefs.getInt('usuarioID');

    return usuarioID!;
  }

  Future setaUsuarioNome(String nome) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('usuarioNome', nome);
  }

  Future<String> getUsuarioNome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? valor = await prefs.getString('usuarioNome');

    return valor!;
  }

  String formatHoraTrabalhada(double valor) {
    List<String> valores = valor.toStringAsPrecision(2).split(".");
    String valor1 = '';
    String valor2 = '';
    String valor3 = '';

    if (valores.length > 1) {
      valor1 =
          valores[0].toString().length == 1 ? '0' + valores[0] : valores[0];
      valor2 = valores[1];

      if (int.parse(valor2) >= 1) {
        valor2 = valor2 + '0';
      }

      valor3 = (valor2.toString().length == 1
          ? valor2.toString() + "0"
          : valor2.toString());

      return valor1 +
          ":" +
          (valor3.toString().length >= 3 ? valor3.substring(0, 2) : valor3);
    } else {
      return valores[0];
    }
  }

  bool release = false;

  void printAB(Object dados) {
    String host = js.context['location']['href'].toString();

    if (host.contains('http://localhost')) {
      return print('PRINT-AB: ${dados}');
    } else {
      return;
    }
  }

  String? validateEmail(String? value) {
    if (value != null) {
      if (value.length > 5 && value.contains('@') && value.endsWith('.com')) {
        return null;
      }
      return 'Informe um Email válido';
    }
  }
}
