import 'dart:convert';
import 'package:agenda_beauty_online/app/model/Usuario.dart';
import 'package:agenda_beauty_online/app/security/AuthStore.dart';
import 'package:agenda_beauty_online/app/service/auth_service.dart';
import 'package:agenda_beauty_online/app/service/auth_service.dart';
import 'package:agenda_beauty_online/app/service/usuario_service.dart';
import 'package:agenda_beauty_online/app/util/Utils.dart';
import 'package:agenda_beauty_online/app/util/prefs.dart';
import 'package:agenda_beauty_online/app/util/prefs.dart';
import 'package:catcher/catcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:encrypt/encrypt.dart' as cry;

ValueNotifier<Usuario> currentUserAB = new ValueNotifier(Usuario());
ValueNotifier<bool> retonroUsuaio = new ValueNotifier(false);
ValueNotifier<String> retonroString = new ValueNotifier("");
ValueNotifier<String> deepLink = new ValueNotifier("");
BaseAuth _auth = Auth();
// FirebaseUser currentFirebaseUser;
// Usuario currentApiUser;

Future<Usuario> login(Usuario usuario) async {
  retonroUsuaio.value = false;

  await _auth
      .signIn(
          usuario.preferredEmail!.trim().toString(), usuario.senha.toString())
      .then((result) async {
    Usuario usuarioAB = new Usuario();

    try {
//        Utils().printAB('result login Fireabse: ');
//        Utils().printAB(result.toString());

      // FirebaseUser firebase = result;

      Utils().printAB('Login');
      // Utils().printAB('result usuario uid: ${firebase.uid}');
      // Utils().printAB('result usuario email: ${firebase.email}');

      try {
        await Auth().authApi();

        var authStore = await AuthStore.getInstance();
        var usuarioUpdated = authStore.currentUser;

        Utils().printAB('usuarioUpdated.refreshToken');
        Utils().printAB(usuarioUpdated!.toJson());

        usuarioAB.id = usuarioUpdated.id;
        usuarioAB.preferredEmail = result!.email;
        usuarioAB.admin = usuarioUpdated.admin;
        usuarioAB.name = usuarioUpdated.name;
        usuarioAB.phoneNumber = usuarioUpdated.phoneNumber;
        usuarioAB.pictureUrl = usuarioUpdated.pictureUrl;
        usuarioAB.pictureUrlOld = usuarioUpdated.pictureUrlOld;
        usuarioAB.refreshToken = usuarioUpdated.refreshToken;

        if (result.email != "convidado@agendabeauty.com.br") {
          usuarioAB.pushToken = await Prefs.getString('FirebaseToken');
        }
        usuarioAB.enabled = usuarioUpdated.enabled;
        currentUserAB.value = usuarioAB;

        Utils().printAB('currentUserAB result toJson: ');
        Utils().printAB(currentUserAB.value);

        //Seta o usuario local currente
        setCurrentUserAB(currentUserAB.value);

        Utils().printAB('setou o currentUserAB ');

        // updatePushToken();

      } catch (error, stackTrace) {
        Catcher.reportCheckedError(error, stackTrace);
//          Utils().printAB(ex);
//          Utils().printAB(trace);
        retonroUsuaio.value = true;
        retonroString.value = "Não foi possível se conectar!";
      }
    } catch (ex, trace) {
      retonroUsuaio.value = true;
      var errorCode = ex is PlatformException ? ex.code : (ex).toString();

      Utils().printAB(ex);

      var errorMessage = ['ERROR_WRONG_PASSWORD', 'ERROR_USER_NOT_FOUND']
              .contains(errorCode)
          ? "Usuário ou senha incorretos"
          : errorCode == 'ERROR_TOO_MANY_REQUESTS'
              ? "Falhas sucessivas de login, tente mais tarde!"
              : errorCode == 'ERROR_EMAIL_ALREADY_IN_USE'
                  ? "Esse endereço de email já está em uso!"
                  : errorCode == 'ERROR_INVALID_EMAIL'
                      ? "Endereço de email inválido! \n Verifique se você digitou corretamente."
                      : "Usuário ou senha inválida!";

      Utils().printAB("retorno firebase");
      Utils().printAB(errorMessage);

      retonroString.value = errorMessage;
    }
  });

  return currentUserAB.value;
}

Future<Usuario> register(Usuario user) async {
  Utils().printAB('dados para cadastro');
  Utils().printAB(user.toString());

  Usuario usuarioAB = new Usuario();

  retonroUsuaio.value = false;

  try {
    dynamic result = await _auth.signUp(user.preferredEmail!, user.senha!);

    try {
      await Auth().authApi();

      Utils().printAB('authApi - login');
//            Utils().printAB(result.userId);

      var authStore = await AuthStore.getInstance();
      var usuarioUpdated = authStore.currentUser;
      usuarioAB.id = usuarioUpdated!.id;
      usuarioAB.preferredEmail = result.email;
      usuarioAB.admin = false;
      usuarioAB.name = user.name;
      usuarioAB.pictureUrl = null;
      usuarioAB.phoneValidated = true;
      usuarioAB.phoneNumber = user.phoneNumber;
      // usuarioAB.versionCli = VersaoAPP.getVersaoCODE();
      usuarioAB.pushToken = await Prefs.getString('FirebaseToken');
      currentUserAB.value = usuarioAB;

      Utils().printAB('registro - usuarioAB toJson: ');
      Utils().printAB(usuarioAB.toJson());

      //Seta o usuario local currente
      setCurrentUserAB(currentUserAB.value.toJson());

      Utils().printAB('setou o currentUserAB ');

      Utils().printAB('UsuarioService enviando para o servidor ');
      //Salva o usuario no servirdor do projeto
      await UsuarioService().update(usuarioAB);
      Utils().printAB('UsuarioService enviando  ');

      retonroUsuaio.value = false;
      retonroString.value = "Bem vindo!";
    } catch (exception, stackTrace) {
      // Catcher.reportCheckedError(exception, stackTrace);
//            Utils().printAB("erro no auth api");
//            Utils().printAB(e.toString());
      retonroUsuaio.value = true;
      retonroString.value = "Não foi possível se conectar!";
    }
  } catch (ex, trace) {
    retonroUsuaio.value = true;

    var errorCode = ex is PlatformException ? ex.code : (ex).toString();

    Utils().printAB(ex);

    var errorMessage = ['ERROR_WRONG_PASSWORD', 'ERROR_USER_NOT_FOUND']
            .contains(errorCode)
        ? "Falha no login, usuário ou senha incorretos"
        : errorCode == 'ERROR_TOO_MANY_REQUESTS'
            ? "Falhas sucessivas de login, tente mais tarde!"
            : errorCode == 'ERROR_EMAIL_ALREADY_IN_USE'
                ? "Esse endereço de email já está em uso!"
                : errorCode == 'ERROR_INVALID_EMAIL'
                    ? "Endereço de email inválido! \n Verifique se você digitou corretamente."
                    : "Falha no login";

    Utils().printAB("retorno firebase");
    Utils().printAB(errorMessage);

    retonroString.value = errorMessage;
  }

  return currentUserAB.value;
}

Future<Usuario?> updatePushToken() async {
  final authStore = await AuthStore.getInstance();
  final currentToken = await Prefs.getString('FirebaseToken');

  Utils().printAB('currentToken PushToken: ${currentToken}');

  if (authStore.currentUser!.pushToken != currentToken) {
    Usuario usuario = authStore.currentUser!;
    usuario.pushToken = currentToken;
    try {
      UsuarioService().update(usuario).then((value) {
        Utils().printAB('Updated User token on API');
      });
    } catch (error, stackTrace) {
      Catcher.reportCheckedError(error, stackTrace);
//      Utils().printAB(e);
//      Utils().printAB(ex);
    }
  }
}

Future<bool?> resetPassword(Usuario usuario) async {
  retonroUsuaio.value = false;

  try {
    var isEmailCadastrado =
        await Auth().checkUserExists(usuario.preferredEmail.toString());

    Utils().printAB('isEmailCadastrado');
    Utils().printAB(isEmailCadastrado);

    if (isEmailCadastrado == false) {
      retonroUsuaio.value = true;
      retonroString.value = "Não encontramos esse endereço de email!";
    } else {
      final res = await UsuarioService()
          .sendPasswordResetEmail(usuario.preferredEmail.toString());

      if (res) {
        retonroUsuaio.value = false;
      } else {
        retonroUsuaio.value = true;
        retonroString.value = 'Falha ao realizar a operação';
      }
    }
  } catch (error, stackTrace) {
    Catcher.reportCheckedError(error, stackTrace);
    retonroUsuaio.value = true;
    retonroString.value = 'Falha ao realizar a operação';
  }
}

Future<bool?> resetarPassword(String email) async {
  retonroUsuaio.value = false;

  try {
    var isEmailCadastrado = await Auth().checkUserExists(email);

    Utils().printAB('isEmailCadastrado');
    Utils().printAB(isEmailCadastrado);

    if (isEmailCadastrado == false) {
      retonroUsuaio.value = true;
      retonroString.value = "Não encontramos esse endereço de email!";
    } else {
      final res = await UsuarioService().sendPasswordResetEmail(email);

      if (res) {
        retonroUsuaio.value = false;
      } else {
        retonroUsuaio.value = true;
        retonroString.value = 'Falha ao realizar a operação';
      }
    }
  } catch (error, stackTrace) {
    Catcher.reportCheckedError(error, stackTrace);
    retonroUsuaio.value = true;
    retonroString.value = 'Falha ao realizar a operação';
  }
}

Future<void> logout() async {
  currentUserAB.value = new Usuario();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('current_user_ab');
  await prefs.remove('abu');
  await prefs.remove('abp');
  await prefs.remove('phone');
}

void setCurrentUserAB(jsonString) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var authStore = await AuthStore.getInstance();

  if (prefs.containsKey('current_user_ab')) {
    return;
  }

  Utils().printAB('setCurrentUserAB2 - 1');
  Utils().printAB(jsonString);
  Utils().printAB('setCurrentUserAB2 - 2');
  Utils().printAB(json.encode(jsonString));

  await Auth().getCurrentUser();

  // try {
  //   await Auth().authApi();
  // } catch (a) {
  //   QR.navigator.replaceAll('/login');
  // }

  // Utils().printAB("currentUser authStore refreshToken");
  // Utils().printAB(authStore.currentData.refreshToken);

  if (jsonString != null) {
    // await prefs.setString('current_user_ab', json.encode(jsonString));

    await encrypt(json.encode(jsonString)).then((value) async {
      // Utils().printAB('setUsuarioEmail depois: ${value}');

      await prefs.setString('current_user_ab', value).then((value) async {
        Utils().printAB('current_user_ab encrypt setado sucesso');
        // Utils().printAB(value);

        var resultD =
            await dencrypt(prefs.getString('current_user_ab').toString());

        Utils().printAB('current_user_ab resultD');
        Utils().printAB(resultD);
      }).onError((error, stackTrace) {
        Utils().printAB('current_user_ab encrypt setado erro');
        Utils().printAB(error!);
        Utils().printAB(stackTrace);
      });
    }).onError((error, stackTrace) {
      Utils().printAB('current_user_ab encrypt');
      // Utils().printAB(error);
      Utils().printAB('-----');
      Utils().printAB(stackTrace);
    });
  }
}

Future<String> encrypt(String valor) async {
  var key = cry.Key.fromBase64(
      'UHJvamV0b0FiQ3JpYWRvX0VtXzIwMTlfcG9ySFNGTlM='); // obviously, insert your own value!
  var iv = cry.IV.fromBase64('8PzGKSMLuqSm0MVbviaWHA==');

  final encrypter = cry.Encrypter(cry.AES(key));

  final encrypted = encrypter.encrypt(valor, iv: iv);

  return encrypted.base64;
}

Future<String> dencrypt(String valor) async {
  var key = cry.Key.fromBase64(
      'UHJvamV0b0FiQ3JpYWRvX0VtXzIwMTlfcG9ySFNGTlM='); // obviously, insert your own value!
  var iv = cry.IV.fromBase64('8PzGKSMLuqSm0MVbviaWHA==');

  final encrypter = cry.Encrypter(cry.AES(key));

  final decrypted = encrypter.decrypt(cry.Encrypted.fromBase64(valor), iv: iv);
  String result = decrypted;

  return result;
}

Future<Usuario> getCurrentUserAB() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  Utils().printAB('getCurrentUserAB - Entrou na rotina');

  if (await prefs.containsKey('current_user_ab')) {
    final authStore = AuthStore.instace();

    var resultD = await dencrypt(prefs.getString('current_user_ab').toString());

    Utils().printAB('getCurrentUserAB current_user_ab resultD 1');
    Utils().printAB(resultD);

    Usuario user = Usuario.fromJson(jsonDecode(resultD));

    Utils().printAB('current_user_ab getCurrentUserAB - resultD 2');
    Utils().printAB(user);

    currentUserAB.value = user;

    currentUserAB.notifyListeners();

//    await UsuarioService().update(user);

  } else {
    Utils().printAB('getCurrentUserAB - não tem dados salvos');
    currentUserAB.notifyListeners();
  }
  return currentUserAB.value;
}

void getDeepLink() async {
  Prefs.getString("deepLinkEpresaID").then((value) {
    deepLink.value = value;
    deepLink.notifyListeners();
  });
}
