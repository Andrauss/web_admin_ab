import 'dart:js';

import 'package:agenda_beauty_online/app/locator.dart';
import 'package:agenda_beauty_online/app/util/Utils.dart';
// import 'package:agenda_beauty_online/app/util/agenda_beauty_dialog.dart';
import 'package:agenda_beauty_online/app/util/prefs.dart';
import 'package:agenda_beauty_online/app/util/toast_util.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:agenda_beauty_online/app/model/Usuario.dart';
import 'package:agenda_beauty_online/app/security/AuthStore.dart';
import 'package:agenda_beauty_online/app/service/auth_service.dart';
import 'package:agenda_beauty_online/app/service/usuario_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:agenda_beauty_online/app/repository/settings_repository.dart'
    as settingRepo;
import 'package:qlevar_router/qlevar_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:agenda_beauty_online/app/repository/user_repository.dart'
    as repository;

class UserController extends ControllerMVC {
  Usuario? usuarioAB = new Usuario();
  ValueNotifier<Usuario>? currentUser = new ValueNotifier(Usuario());
  bool? hidePassword = true;
  GlobalKey<FormState>? loginFormKey;
  GlobalKey<ScaffoldState>? scaffoldKey;
  // FirebaseMessaging _firebaseMessaging;
  FirebaseAuth? _firebaseAuth;
  EncryptedSharedPreferences? encryptedSharedPreferences;
  SharedPreferences? prefs;

  UserController() {
    loginFormKey = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    this.encryptedSharedPreferences = EncryptedSharedPreferences();
    // _firebaseMessaging = FirebaseMessaging();
    // _firebaseMessaging.getToken().then((String _deviceToken) {
    //   usuarioAB.pushToken = _deviceToken;
    // });
  }

  Future<Usuario?> login(String email, String senha) async {
    // final loading = AgendaBeautyDialog.loading(loginFormKey.currentState.context, 'Aguarde...');
    //
    // loading.show();
    usuarioAB!.preferredEmail = email;
    usuarioAB!.senha = senha;

    repository.logout();

    Usuario usuario = new Usuario();

    await repository.login(usuarioAB!).then((value) async {
      // await settingRepo.setUsuarioConvidado(false);

      if (repository.retonroUsuaio.value == false) {
        String senha = usuarioAB!.senha.toString();

        usuarioAB = value;
        usuarioAB!.senha = senha;
        currentUser!.value = value;

        Utils().printAB("etapa 1");

        Utils().printAB('user_controller value');
        Utils().printAB(value);

        Utils().printAB('user_controller UsuarioService atualzizou o usuario');
//        await locator<UsuarioService>().update(value);
        updateDadosUser();

        if (value != null && value.id != null) {
          Utils().printAB("etapa 2");
          try {
            Utils().printAB("etapa 3");

            await Auth().authApi();

            Utils().printAB("etapa 4");
            var authStore = await AuthStore.getInstance();
            var usuarioAtual = authStore.currentUser;

            Utils().printAB("etapa 5");
            usuarioAtual!.name = usuarioAB!.name;

            var userAB = Usuario(
                id: usuarioAtual.id,
                name: usuarioAtual.name,
                phoneNumber: usuarioAtual.phoneNumber,
                preferredEmail: usuarioAB!.preferredEmail);

            await repository.getCurrentUserAB().then((value) async {
              Utils().printAB("Usuario ativo: ${value.enabled} ");

              if (value.enabled == false) {
                // loading.close();

                await repository.logout();

                showErrorToast("O seu login foi desativado! Entre em contato.");
              } else {
                Utils.currentUser.value = userAB;

                Utils().printAB('Utils currentUser');
                Utils().printAB(Utils.currentUser.value);

                // settingRepo.setUsuarioConvidado(false);

                await settingRepo.setUsuarioEmail(userAB.preferredEmail!);
                await settingRepo.setUsuarioSenha(senha);

                repository.currentUserAB.value = userAB;

                // if (usuarioAB!.preferredEmail ==
                //     "convidado@agendabeauty.com.br") {
                //   settingRepo.setUsuarioConvidado(true);
                // }

                // print('Usario retonro login');
                Utils.currentUser.value = value;
                // print(value);

                usuario = value;

                // QR.navigator.replaceAll('/');
                // loading.close();

              }
            });

            return usuario;
          } catch (a) {
            // loading.close();
            Utils().printAB("error login 2");
            Utils().printAB(a);
            abDialog(scaffoldKey!.currentContext!, 'Atenção',
                repository.retonroString.value);
            // scaffoldKey!.currentState!.showSnackBar(SnackBar(
            //   content: Text(repository.retonroString.value),
            // ));
          }
        } else {
          // loading.close();
          // scaffoldKey!.currentState!.showSnackBar(SnackBar(
          //   content: Text(repository.retonroString.value),
          // ));

          abDialog(scaffoldKey!.currentContext!, 'Atenção',
              repository.retonroString.value);
        }
      } else {
        // loading.close();
        abDialog(scaffoldKey!.currentContext!, 'Atenção',
            repository.retonroString.value);

        // showErrorToast(repository.retonroString.value,
        //     position: ToastGravity.BOTTOM);
      }
    }).catchError((e) {
      // loading.close();
      Utils().printAB('login catchError');
      Utils().printAB(e);

      abDialog(scaffoldKey!.currentContext!, 'Atenção',
          'Dados inválidos, tente novamente!');

      // showErrorToast("Dados inválidos, tente novamente!",
      //     position: ToastGravity.BOTTOM);
    });
  }

  Future loginConvidadoDeepLink(BuildContext ctx) async {
//      final loading = AgendaBeautyDialog.loading(ctx, 'Aguarde...');

    usuarioAB!.preferredEmail = "convidado@agendabeauty.com.br";
    usuarioAB!.senha = "123456";
//      loading.show();

    repository.login(usuarioAB!).then((value) async {
      if (repository.retonroUsuaio.value == false) {
        await settingRepo.setUsuarioConvidado(true);

        Utils().printAB("etapa 1");

        Utils().printAB('user_controller value');
        Utils().printAB(value);

        if (value != null && value.id != null) {
          Utils().printAB("etapa 2");
          try {
            Utils().printAB("etapa 3");

            await Auth().authApi();

            Utils().printAB("etapa 4");
            var authStore = await AuthStore.getInstance();
            var usuarioAtual = authStore.currentUser;

            Utils().printAB("etapa 5");
            usuarioAtual!.name = usuarioAB!.name;

            var userAB = Usuario(
                id: usuarioAtual.id,
                name: usuarioAtual.name,
                phoneNumber: usuarioAtual.phoneNumber);

            repository.currentUserAB.value = userAB;

            Utils().printAB("etapa 6");

//              loading.close();

            if (usuarioAB!.preferredEmail == "convidado@agendabeauty.com.br") {
              settingRepo.setUsuarioConvidado(true);
            }

            var temDeepLink = await settingRepo.getDeepLinkEpresa();

            if (temDeepLink.length > 0) {
              settingRepo.setUsuarioConvidado(true);

              QR.navigator.replaceAll('/${temDeepLink}');
            }
          } catch (a) {
//              loading.close();
            Utils().printAB("error login 2");
            Utils().printAB(a);
          }
        } else {
//          loading.close();

        }
      } else {
//          loading.close();
        showErrorToast(repository.retonroString.value,
            position: ToastGravity.BOTTOM);
//          scaffoldKey.currentState.showSnackBar(SnackBar(
//            content: Text(repository.retonroString.value),
//          ));
      }
      ////
    });
  }

  Future loginConvidado() async {
    // final loading = AgendaBeautyDialog.loading(
    //     loginFormKey.currentState.context, 'Aguarde...');

    usuarioAB!.preferredEmail = "convidado@agendabeauty.com.br";
    usuarioAB!.senha = "123456";
    // loading.show();

    repository.login(usuarioAB!).then((value) async {
      if (repository.retonroUsuaio.value == false) {
        await settingRepo.setUsuarioConvidado(true);
        Utils().printAB("etapa 1");

        Utils().printAB('user_controller value');
        Utils().printAB(value);

        if (value != null && value.id != null) {
          Utils().printAB("etapa 2");
          try {
            Utils().printAB("etapa 3");

            await Auth().authApi();

            Utils().printAB("etapa 4");
            var authStore = await AuthStore.getInstance();
            var usuarioAtual = authStore.currentUser;

            Utils().printAB("etapa 5");
            usuarioAtual!.name = usuarioAB!.name;

            var userAB = Usuario(
                id: usuarioAtual.id,
                name: usuarioAtual.name,
                phoneNumber: usuarioAtual.phoneNumber);

            repository.currentUserAB.value = userAB;

            Utils().printAB("etapa 6");

//            try{
//              Utils().printAB("etapa 7");
////                await locator<UsuarioService>().salvar(userAB);
//              Utils().printAB("etapa 8");
//            }catch(a){
//              Utils().printAB("error login 1");
//              Utils().printAB(a);
//              scaffoldKey.currentState.showSnackBar(SnackBar(
//                content: Text("Erro ao realizar o login!"),
//              ));
//
//            }
            settingRepo.setUsuarioConvidado(true);
            // loading.close();

//            Navigator.of(scaffoldKey.currentContext).pop();
            Navigator.of(scaffoldKey!.currentContext!).pushNamedAndRemoveUntil(
                '/Pages', (Route<dynamic> route) => false);
//            Navigator.of(context).pushReplacementNamed('/Pages', arguments: 2);

          } catch (a) {
            // loading.close();
            Utils().printAB("error login 2");
            Utils().printAB(a);
            scaffoldKey!.currentState!.showSnackBar(SnackBar(
              content: Text(repository.retonroString.value),
            ));
          }
        } else {
          // loading.close();
          scaffoldKey!.currentState!.showSnackBar(SnackBar(
            content: Text(repository.retonroString.value),
          ));
        }
      } else {
        // loading.close();
        showErrorToast(repository.retonroString.value,
            position: ToastGravity.BOTTOM);
//          scaffoldKey.currentState.showSnackBar(SnackBar(
//            content: Text(repository.retonroString.value),
//          ));
      }
      ////
    });
  }

  Future<Usuario?> register() async {
    if (loginFormKey!.currentState!.validate()) {
      loginFormKey!.currentState!.save();

      repository.logout();

      try {
        var result = await repository.register(usuarioAB!);
        currentUser!.value = usuarioAB!;
        Utils().printAB('Retorno  register - User controller');
        // Utils().printAB(result);
        Utils().printAB(repository.retonroUsuaio.value);
        Utils().printAB(repository.retonroString.value);

        await settingRepo.setUsuarioEmail(usuarioAB!.preferredEmail!);
        await settingRepo.setUsuarioSenha(usuarioAB!.senha!);

        updatePhoneValidate();

        return result;
      } catch (a) {
        return null;
      }
    }
  }

  void register_old() async {
//    Utils().printAB('userAB register');
//    Utils().printAB(usuarioAB.toString());

    if (loginFormKey!.currentState!.validate()) {
      loginFormKey!.currentState!.save();

      // final loading = AgendaBeautyDialog.loading(loginFormKey.currentState.context, 'Aguarde...');
      //
      // loading.show();

      repository.register(usuarioAB!).then((value) {
        Utils().printAB('retorno usuario ');
        Utils().printAB(repository.retonroUsuaio.value);

        if (repository.retonroUsuaio.value == false) {
          Utils().printAB('retorno usuario entrou na pagina de home ');
          QR.navigator.replaceAll('/');
          Navigator.of(scaffoldKey!.currentContext!).pushNamedAndRemoveUntil(
              '/Pages', (Route<dynamic> route) => false);
//          Navigator.of(context).pushReplacementNamed('/Pages', arguments: 2);

        } else {
          // loading.close();
          Utils().printAB('retorno usuario entrou na  showSnackBar');
          showErrorToast(repository.retonroString.value,
              position: ToastGravity.BOTTOM);
//          scaffoldKey.currentState.showSnackBar(SnackBar(
//            content: Text(repository.retonroString.value),
//          ));
        }
      });
    }
  }

  void resetPassword() {
    if (loginFormKey!.currentState!.validate()) {
      loginFormKey!.currentState!.save();

      // final loading = AgendaBeautyDialog.loading(
      //     loginFormKey.currentState.context, 'Aguarde...');

      // loading.show();

      repository.resetPassword(usuarioAB!).then((value) {
        if (repository.retonroUsuaio.value == false) {
          // loading.close();

          showSuccessToastBottom("Email enviado com sucesso!",
              position: ToastGravity.BOTTOM);

          QR.navigator.replaceAll('/');
        } else {
          // loading.close();
          showErrorToast(repository.retonroString.value,
              position: ToastGravity.BOTTOM);
        }
      });
    }
  }

  void resetSenha(String email, BuildContext context) {
    // final loading = AgendaBeautyDialog.loading(context, 'Aguarde...');

    // loading.show();

    repository.resetarPassword(email).then((value) {
      if (repository.retonroUsuaio.value == false) {
        // loading.close();

        showSuccessToastBottom(
            "Link de alteração de senha enviado com sucesso!",
            position: ToastGravity.BOTTOM);

        Navigator.of(context).pop();
      } else {
        // loading.close();
        showErrorToast(repository.retonroString.value,
            position: ToastGravity.BOTTOM);
      }
    });
  }

  Future<bool> _checkEmailJaCadastrado(BuildContext context) async {
//    setLoading(true);

    try {
      final usuario = usuarioAB;
      final email = usuario!.preferredEmail;
      final checkUserExists = await Auth().checkUserExists(email!);
      final currentUser = await Auth().getCurrentUser();

      // Se: usuário existe e não está logado
      // ou está logado mas não é o mesmo do cadastro (no caso de retry após erro)
      if (checkUserExists &&
          (currentUser == null ||
              currentUser.email != usuario.preferredEmail)) {
        Utils().printAB('usuario Exists');
        setState(() {
//          emailBlackList.add(email);
//          emailBlackList = [...emailBlackList];
//          if (widget.onUserJaExiste != null) {
//            widget.onUserJaExiste.call();
//          }
//          _formKey.currentState.validate();
        });

//      var res = await Future.delayed(Duration(seconds: 2), () => true);

        return true;
      }
    } catch (e) {
      Utils().printAB("veririca email: ${e}");

      showErrorToast('Falha ao verificar e-mail!',
          position: ToastGravity.BOTTOM);
      return true;
    }

    return false;
  }

  void registro() async {
    // final loading = AgendaBeautyDialog.loading(
    //     loginFormKey.currentState.context, 'Verificando email...');
    // loading.show();
    final usuarioExists =
        await _checkEmailJaCadastrado(loginFormKey!.currentState!.context);
    // loading.close();

    Utils().printAB("usuarioExists: ${usuarioExists}");

    // var loadingCadastro = AgendaBeautyDialog.loading(
    //     loginFormKey.currentState.context, "Aguarde...");
    // loadingCadastro.show();

    try {
      // FirebaseUser signUp;
      final usuario = usuarioAB;

      // 1: pega o usuário atual caso exista
      var currentUser = await Auth().getCurrentUser();
      // signUp = currentUser;

      // if (signUp == null) {
      //   Utils().printAB("não tem usuario local");
      //   // 1: salva no firebase
      //   signUp = await Auth().signUp(usuario.preferredEmail, usuario.senha);
      // }

      // var userUpdateInfo = UserUpdateInfo();
      // userUpdateInfo.displayName = usuario.name;
      // await signUp.updateProfile(userUpdateInfo);

      // 2: cria o usuário na API e gera o access token
      await Auth().authApi();

      var authStore = await AuthStore.getInstance();
      var usuarioUpdated = authStore.currentUser;
      usuario!.id = usuarioUpdated!.id;
      usuario.admin = false;
      usuario.name = usuario.name;
      usuario.pushToken = await Prefs.getString('FirebaseToken');
      // usuario.versionCli = VersaoAPP.getVersaoCODE();

      Utils().printAB('USUARIO JSON');
      Utils().printAB(usuario.toJson());

      await locator<UsuarioService>().update(usuario);

      // loadingCadastro.close();
      Navigator.of(scaffoldKey!.currentContext!)
          .pushNamedAndRemoveUntil('/Pages', (Route<dynamic> route) => false);
//        Navigator.of(context).pushReplacementNamed('/Pages', arguments: 2);

    } catch (e) {
      // loadingCadastro.close();
      Utils().printAB('------------- FALHA SAVE USUARIO -----------');
      Utils().printAB(e);
      showErrorToast('Falha ao realizar cadastro!',
          position: ToastGravity.BOTTOM);
    }
  }

  void updatePuskToken() async {
    Utils().printAB('updatePuskToken usuario');
    var authStore = await AuthStore.getInstance();
    var usuario = authStore.currentUser;
    usuario!.pushToken = await Prefs.getString('FirebaseToken');
    await locator<UsuarioService>().update(usuario);
  }

  void updateDadosUser() async {
    var authStore = await AuthStore.getInstance();
    var usuario = authStore.currentUser;
    await locator<UsuarioService>().update(usuario!);
  }

  void updateDadosUserTelefone(String telefone) async {
    var authStore = await AuthStore.getInstance();
    var usuario = authStore.currentUser;
    usuario!.phoneValidated = true;
    usuario.phoneNumber = telefone;
    await locator<UsuarioService>().update(usuario);
  }

  void updatePhoneValidate() async {
    var authStore = await AuthStore.getInstance();
    var usuario = authStore.currentUser;
    usuario!.phoneValidated = true;
    usuario.phoneNumber = '00000000000';
    await locator<UsuarioService>().updatePhoneValidate(usuario);
  }

  void updatePhone(String phone) async {
    var authStore = await AuthStore.getInstance();
    var usuario = authStore.currentUser;
    usuario!.phoneValidated = true;
    usuario.phoneNumber = '${phone}';
    await locator<UsuarioService>().updatePhoneValidate(usuario);
  }
}
