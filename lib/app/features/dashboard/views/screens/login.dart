import 'package:agenda_beauty_online/app/config/app_config.dart' as config;
import 'package:agenda_beauty_online/app/config/routes/app_pages.dart';
import 'package:agenda_beauty_online/app/features/dashboard/controllers/user_controller.dart';
import 'package:agenda_beauty_online/app/features/dashboard/views/screens/dashboard_screen.dart';
import 'package:agenda_beauty_online/app/features/elements/ABProgressIndicator.dart';
import 'package:agenda_beauty_online/app/repository/empresa_perfil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:agenda_beauty_online/app/util/Utils.dart';
import 'package:qlevar_router/qlevar_router.dart';
// import 'home.dart';
// import 'home_screen.dart';

class Login extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends StateMVC<Login> {
  UserController? _con;

  _LoginPageState() : super(UserController()) {
    _con = controller as UserController?;
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool _isLoading = false;

  BuildContext? ctxTela;

  @override
  void initState() {
    super.initState();

    // nameController.text = 'weslley-live@hotmail.com';
    // passwordController.text = '5wcutewhG@';
    ctxTela = context;

    // login();
  }

  void _showLoading(BuildContext ctx) async {
    return showDialog(
      context: ctx,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 80,
                height: 150,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ABProgressIndicator(
                        size: 100,
                      ),
                      Text('Aguarde...')
                    ],
                  ),
                ),
              ),
            ));
          },
        );
      },
    );
  }

  void abDialog(String titulo, String msg) async {
    return showDialog(
      context: ctxTela!,
      builder: (context) {
        String contentText = "Content of Dialog";
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              child: Container(
                  width: 300,
                  height: 200,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          color: Color.fromRGBO(208, 199, 166, 0.9),
                          child: Row(
                              // A Row widget
                              mainAxisAlignment: MainAxisAlignment
                                  .spaceBetween, // Free space will be equally divided and will be placed between the children.
                              children: [
                                IconButton(
                                    // A normal IconButton
                                    icon: Icon(
                                      Icons.clear,
                                      color: Colors.transparent,
                                    ),
                                    onPressed: () {
                                      // Navigator.of(context).pop();
                                    }),
                                Flexible(
                                  // A Flexible widget that will make its child flexible
                                  child: Text(
                                    titulo, // A very long text
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Color.fromRGBO(31, 73, 68, 0.9),
                                    ), // handles overflowing of text
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: IconButton(
                                      // A normal IconButton
                                      icon: Icon(Icons.clear),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      }),
                                )
                              ]),
                        ),
                        Center(
                            child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(msg),
                        ))
                      ],
                    ),
                  )),
            );
          },
        );
      },
    );
  }

  void verificaAcesso() {
    // print('usuario conectado:');
    // print(Utils.currentUser.value.toJson());

    if (Utils.currentUser.value.enabled == false) {
      abDialog('Atenção', 'O seu acesso está bloqueado!');
      return;
    }

    if (Utils.currentUser.value.admin == false) {
      abDialog('Atenção', 'Você não tem permissão de acesso!');
      return;
    }

    // QR.navigator.replaceAll('/dashboard');
    Get.toNamed('/dashboard');

    // Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: (c) => DashboardScreen()));
  }

  login() async {
    _showLoading(ctxTela!);

    try {
      await Utils().logout();

      await _con
          ?.login(nameController.text, passwordController.text)
          .then((value) {
        Navigator.of(ctxTela!).pop();

        if (Utils.currentUser.value == null) {
          Get.defaultDialog(title: 'Atenção!', middleText: 'Login inválido!');
          // abDialog('Atenção', 'Login inválido!');
        } else {
          verificaAcesso();
        }
      }).catchError((error) {
        Navigator.of(ctxTela!).pop();
        abDialog('Atenção', 'Dados inválido, tente novamente!');
        print('usuario conectado erro');
        print(error);
        return;
      });
    } catch (a) {
      Navigator.of(ctxTela!).pop();
      Utils().printAB("erro login retorno: ${a}");
    }

    // var empresa = await EmpresaPerfilService().getEmpresaSearch('weslley');

    // var total = empresa.length;

    // print('getEmpresaSearch total: $total');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: config.Colors().mainColor(0.9),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(flex: 3, child: Text('')),
            Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 20, bottom: 10),
                child: Image.asset(
                  'images/logo.png',
                  scale: 8,
                )),
            widgetBody(),
            Flexible(flex: 10, child: Text('')),
            Flexible(flex: 5, child: Text(''))
          ],
        )

        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  Widget widgetBody() {
    return Stack(
      children: [
        Visibility(
            visible: !_isLoading,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    padding: EdgeInsets.only(top: 20),
                    width: 300,
                    height: 280,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: ListView(
                      children: <Widget>[
                        Padding(
                          padding:
                              EdgeInsetsDirectional.only(start: 30, top: 10),
                          child: Text(
                            'Login',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(31, 73, 68, 0.9)),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 60,
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                          child: TextField(
                            controller: nameController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person),
                                border: OutlineInputBorder(),
                                labelText: 'Email',
                                labelStyle: TextStyle(fontSize: 15)),
                          ),
                        ),
                        Container(
                          height: 60,
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                          child: TextField(
                            obscureText: true,
                            controller: passwordController,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock),
                                border: OutlineInputBorder(),
                                labelText: 'Senha',
                                labelStyle: TextStyle(fontSize: 15)),
                            onSubmitted: (a) => login(),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                            height: 40,
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: RaisedButton(
                              textColor: config.Colors().mainColor(0.9),
                              color: config.Colors().secondColor(0.9),
                              child: Text('Entrar'),
                              onPressed: () {
                                // Utils().printAB(nameController.text);
                                // Utils().printAB(passwordController.text);
                                login();
                              },
                            ))
                      ],
                    ))
              ],
            )),
        Visibility(
            visible: _isLoading,
            child: Center(
                child: Container(
                    height: 80,
                    width: 80,
                    child: CircularProgressIndicator(
                      strokeWidth: 5,
                      backgroundColor: Color(0xFFD0C7A6),
                    )))),
      ],
    );
  }

  validar() {
    if (nameController.text.trim().length == 0 ||
        passwordController.text.trim().length == 0) {
      // Toast.show('Informe os dados de login!', context,
      //     gravity: 100, duration: 1);
      return;
    }
  }
}
