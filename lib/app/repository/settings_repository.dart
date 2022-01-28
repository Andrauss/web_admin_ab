import 'dart:async';
import 'dart:convert';
import 'package:agenda_beauty_online/app/model/address.dart';
import 'package:agenda_beauty_online/app/model/setting.dart';
import 'package:encrypt/encrypt.dart' as cry;
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto_keys/crypto_keys.dart';
import 'dart:typed_data';
import 'package:agenda_beauty_online/app/util/Utils.dart';
import 'package:agenda_beauty_online/app/repository/user_repository.dart'
    as userRepo;

ValueNotifier<Setting> setting = new ValueNotifier(new Setting());

ValueNotifier<Address> deliveryAddress = new ValueNotifier(new Address());

Future<Setting> initSettings() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  Setting _setting;

  // GetVersion.projectVersion.then((value) {
  //   _setting.appVersion = value;
  // });

//   _setting.appName = 'Agenda Beauty';
//   _setting.defaultTax = 0.0;
//   _setting.defaultCurrency;
//   _setting.distanceUnit;
//   _setting.currencyRight = false;
//   _setting.payPalEnabled = true;
//   _setting.stripeEnabled = true;
//   _setting.mainColor = "0xFFc9a556";
//   _setting.mainDarkColor = "0xFFc79400";
//   _setting.secondColor = "0xFF344968";
//   _setting.secondDarkColor ="0xFFccccdd";
//   _setting.accentColor = "0xFF8C98A8";
//   _setting.accentDarkColor = "0xFFccccdd";
//   _setting.scaffoldDarkColor = "0xFF2C2C2C";
//   _setting.scaffoldColor = "0xFFFAFAFA";
//   _setting.googleMapsKey = "AIzaSyD5NeapI6Mo0vN3uVBgMxBH4S5ltv8WdgU";
//   _setting.mobileLanguage = new ValueNotifier(Locale('pt', ''));
// //  _setting.appVersion = "1.0";
//   _setting.enableVersion = true;

//  final String url = '${GlobalConfiguration().getString('api_base_url')}settings';
//  final response = await http.get(url, headers: {HttpHeaders.contentTypeHeader: 'application/json'});
//  if (response.statusCode == 200 && response.headers.containsValue('application/json')) {
//    if (json.decode(response.body)['data'] != null) {
//      SharedPreferences prefs = await SharedPreferences.getInstance();
//      await prefs.setString('settings', json.encode(json.decode(response.body)['data']));
//      _setting = Setting.fromJSON(json.decode(response.body)['data']);
//      if (prefs.containsKey('language')) {
//        _setting.mobileLanguage = new ValueNotifier(Locale(prefs.get('language'), ''));
//      }
  // setting.value = _setting;
  setting.notifyListeners();
//    }
//  }
  return setting.value;
}

Future<dynamic> setCurrentLocation() async {}

Future<Address> changeCurrentLocation(Address _address) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('delivery_address', json.encode(_address.toMap()));
  return _address;
}

Future<Address> getCurrentLocation() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
//  await prefs.clear();
  if (prefs.containsKey('delivery_address')) {
    deliveryAddress.value =
        Address.fromJSON(json.decode(prefs.getString('delivery_address')!));
    return deliveryAddress.value;
  } else {
    deliveryAddress.value = Address.fromJSON({});
    return Address.fromJSON({});
  }
}

void setBrightness(Brightness brightness) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  brightness == Brightness.dark
      ? prefs.setBool("isDark", true)
      : prefs.setBool("isDark", false);
}

Future<void> setDefaultLanguage(String language) async {
  if (language != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', language);
  }
}

Future<String> getDefaultLanguage(String defaultLanguage) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('language')) {
    // ignore: await_only_futures
    defaultLanguage = await prefs.get('language').toString();
  }
  return defaultLanguage;
}

Future<void> setDeepLinkEpresa(String deepLinkEmpresa) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('deepLinkEmpresa', deepLinkEmpresa);
}

Future<void> setUsuarioConvidado(bool valor) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('usuarioConvidado', valor);
}

Future<void> setCurrentUsuario(String valor) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // Utils().printAB('setUsuarioEmail antes: ${valor}');

  await userRepo.encrypt(valor).then((value) async {
    // Utils().printAB('setUsuarioEmail depois: ${value}');

    await prefs.setString('abu', value).then((value) {
      Utils().printAB('setUsuarioEmail setado sucesso');
      // Utils().printAB(value);
    }).onError((error, stackTrace) {
      Utils().printAB('setUsuarioEmail setado erro');
      Utils().printAB(error!);
      Utils().printAB(stackTrace);
    });
  });
}

Future<void> setUsuarioEmail(String valor) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // Utils().printAB('setUsuarioEmail antes: ${valor}');

  await userRepo.encrypt(valor).then((value) async {
    // Utils().printAB('setUsuarioEmail depois: ${value}');

    await prefs.setString('abu', value).then((value) {
      Utils().printAB('setUsuarioEmail setado sucesso');
      // Utils().printAB(value);
    }).onError((error, stackTrace) {
      Utils().printAB('setUsuarioEmail setado erro');
      Utils().printAB(error!);
      Utils().printAB(stackTrace);
    });
  });
}

Future<void> setUsuarioSenha(String valor) async {
  // Utils().printAB('setUsuarioSenha antes: ${valor}');

  SharedPreferences prefs = await SharedPreferences.getInstance();

  await userRepo.encrypt(valor).then((value) async {
    // Utils().printAB('setUsuarioSenha depois: ${value}');

    await prefs.setString('abp', value).then((value) {
      Utils().printAB('setUsuarioSenha setado sucesso');
      // Utils().printAB(value);
    }).onError((error, stackTrace) {
      Utils().printAB('setUsuarioSenha setado erro');
      Utils().printAB(error!);
      Utils().printAB(stackTrace);
    });
  });
}

Future<String> getUsuarioEmail() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String registro = '';
  String result = '';

  if (prefs.containsKey('abu')) {
    registro = await prefs.getString('abu').toString();
    result = await userRepo.dencrypt(registro);
  }

  return result;
}

Future<String> getUsuarioSenha() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String registro = '';
  String result = '';

  if (prefs.containsKey('abp')) {
    registro = await prefs.getString('abp').toString();
    result = await userRepo.dencrypt(registro);
  }

  return result;
}

Future<bool> getUsuarioConvidado() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool result = false;
  if (prefs.containsKey('usuarioConvidado')) {
    result = await prefs.getBool('usuarioConvidado')!;
  }

  return result;
}

String deepLinkEmpresa = "";

Future<String> getDeepLinkEpresa() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  if (prefs.containsKey('deepLinkEmpresa')) {
    deepLinkEmpresa = await prefs.get('deepLinkEmpresa').toString();
  }

  return deepLinkEmpresa;
}
