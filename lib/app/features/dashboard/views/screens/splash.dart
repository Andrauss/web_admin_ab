import 'package:agenda_beauty_online/app/features/dashboard/views/screens/login.dart';
import 'package:agenda_beauty_online/app/model/Usuario.dart';
import 'package:agenda_beauty_online/app/util/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:agenda_beauty_online/app/config/app_config.dart' as config;
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:agenda_beauty_online/app/repository/user_repository.dart'
    as userRepo;
import 'package:agenda_beauty_online/app/repository/settings_repository.dart'
    as settingRepo;
import 'package:shared_preferences/shared_preferences.dart';

import 'dashboard_screen.dart';

class SplashScreenState extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreenState> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  bool logado = false;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () async {
      verificar();
    });
  }

  Future verificar() async {
    var email = '';
    var senha = '';
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      if (await prefs.containsKey('abu') && await prefs.containsKey('abp')) {
        var retEmail = await settingRepo.getUsuarioEmail();

        if (retEmail.isNotEmpty) {
          email = retEmail;
        }

        var retSenha = await settingRepo.getUsuarioSenha();

        if (retSenha.isNotEmpty) {
          senha = retSenha;
        }

        Usuario user = new Usuario(preferredEmail: email, senha: senha);
        var retorno = await userRepo.login(user);
        print('splah retonro login');
        print(retorno);
      } else {
        //Desloga removendo os dados do localstorage do browser
        await Utils().logout();
      }

      verificaAcesso();
    } catch (a) {
      print(a);
    }
  }

  void verificaAcesso() async {
    Utils().printAB('usuario conectado:');
    Usuario user = await userRepo.getCurrentUserAB();
    Utils().printAB(user.toJson());

    if (user.enabled == false || user.admin == null) {
      Utils().logout();
      Get.toNamed('/login');
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (c) => Login()));
      return;
    }

    if (user.admin == false || user.admin == null) {
      Utils().logout();
      Get.toNamed('/login');
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (c) => Login()));
      return;
    }
    Get.toNamed('/dashboard');

    // Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: (c) => DashboardScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: config.Colors().mainColor(0.9),
        body: Center(
            child: Stack(
          children: [
            Container(
              width: 500,
              height: 500,
              child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 20, bottom: 10),
                  child: Image.asset("assets/images/logo.png",
                      height: 100,
                      width: 100,
                      filterQuality: FilterQuality.medium,
                      color: Colors.white)),
            )
          ],
        ))
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
