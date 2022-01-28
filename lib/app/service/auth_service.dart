import 'dart:async';
import 'dart:convert';
import 'package:agenda_beauty_online/app/security/AuthData.dart';
import 'package:agenda_beauty_online/app/security/AuthStore.dart';
import 'package:agenda_beauty_online/app/service/service_config.dart';
import 'package:agenda_beauty_online/app/util/Utils.dart';
import 'package:agenda_beauty_online/app/util/prefs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:agenda_beauty_online/app/repository/user_repository.dart'
    as userRepo;
import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseAuth {
  Future<User?> signIn(String email, String password);

  Future<User> signUp(String email, String password);

  Future<User> getCurrentUser();

  Future<void> sendEmailVerification();

  Future<void> signOut();

  Future<bool> isEmailVerified();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<User?> signIn(String email, String password) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    User? user;
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      user = userCredential.user;

      Utils().printAB('user providerId: ${user?.uid}');
      Utils().printAB('user email: ${user?.email}');
      Utils().printAB('user hashCode: ${user.hashCode}');

      getCurrentUser().then((a) {
        a.getIdToken().then((a) {
          Utils().printAB('getCurrentUser token: ${a}');
        });
      });
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException: ${e.code}');

      if (e.code == "user-not-found") {
        print('Usuário inválido');
      }
    }

    return user;
  }

  Future<AuthData> authApi() async {
    final url = "${Environment.baseUrl}/oauth/token";
    Utils().printAB("AUTH SERVICE:authApi > get: $url");

    final currentUser = await Auth().getCurrentUser();

    final userToken = await currentUser.getIdToken();

    final headers = {'Content-type': 'application/x-www-form-urlencoded'};
    headers.addAll(getBasicAuthHeaders());

    var token = userToken;

    final body = {
      'grant_type': 'firebase',
      'firebase_token_id': "${token}",
    };

    Utils().printAB("auth service =  token: $body");

    final response =
        await http.post(Uri.parse(url), headers: headers, body: body);

    if (response.statusCode != 200) throw new Exception(response.body);
    Utils().printAB("< STATUS: ${response.statusCode}");
    Utils().printAB("< : ${response.body}");

    final dataMap = json.decode(response.body) as Map;

    Utils().printAB("auth service JSON: $dataMap");

    final authData = AuthData.fromJson(dataMap as dynamic);
    final authStore = await AuthStore.getInstance();
    authStore.currentData = authData;

    authSetPrefs(response.body);

    return authData;
  }

  authSetTeste(String chave, String valor) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('AuthData');

    await userRepo.encrypt(valor).then((value) async {
      // Utils().printAB('setUsuarioEmail depois: ${value}');

      await prefs.setString(chave, value).then((value) async {
        Utils().printAB('authSetTeste encrypt setado sucesso');
        // Utils().printAB(value);

        var resultD =
            await userRepo.dencrypt(prefs.getString(chave).toString());

        Utils().printAB('authSetTeste resultD');
        Utils().printAB(resultD);
      }).onError((error, stackTrace) {
        Utils().printAB('authSetTeste encrypt setado erro');
        Utils().printAB(error!);
        Utils().printAB(stackTrace);
      });
    }).onError((error, stackTrace) {
      Utils().printAB('authSetTeste');
      // Utils().printAB(error);
      Utils().printAB('-----');
      Utils().printAB(stackTrace);
    });
  }

  authSetPrefs(String jsonString) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await userRepo.encrypt(jsonString).then((value) async {
      // Utils().printAB('setUsuarioEmail depois: ${value}');

      await prefs.setString(AUTH_DATA_KEY, value).then((value) async {
        Utils().printAB('authSetPrefs encrypt setado sucesso');
        // Utils().printAB(value);

        var resultD =
            await userRepo.dencrypt(prefs.getString(AUTH_DATA_KEY).toString());

        Utils().printAB('authSetPrefs resultD');
        Utils().printAB(resultD);
      }).onError((error, stackTrace) {
        Utils().printAB('authSetPrefs encrypt setado erro');
        Utils().printAB(error!);
        Utils().printAB(stackTrace);
      });
    }).onError((error, stackTrace) {
      Utils().printAB('authSetPrefsencrypt');
      // Utils().printAB(error);
      Utils().printAB('-----');
      Utils().printAB(stackTrace);
    });
  }

  Map<String, String> getBasicAuthHeaders() {
    String username = 'agenda-beauty-app';
    String password = 'voceehlindamaisquedemais';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    return {'Authorization': basicAuth};
  }

  //Cria um novo usuário no firebase
  Future<User> signUp(String email, String password) async {
    UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    User user = result.user!;

    Utils().printAB('user email: ${user.email}');
    Utils().printAB('user uid: ${user.uid}');
    Utils().printAB('user hashCode: ${user.hashCode}');

    return user;
  }

  Future<User> getCurrentUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = await auth.currentUser;
    return user!;
  }

  /// Verifica se existe algum usuário com o email especificado (obs.: considera apenas o tipo password do firebase)
  Future<bool> checkUserExists(String email) async {
    var resultList = await _firebaseAuth.fetchSignInMethodsForEmail(email);
    Utils().printAB(resultList);

    var validList = resultList == null
        ? []
        : resultList.where((sm) => sm.toLowerCase() == 'password').toList();

    return resultList != null && validList.isNotEmpty;
  }

  Future<void> signOut() async {
    final authStore = await AuthStore.getInstance();
    // await authStore.signOut();
    return _firebaseAuth.signOut();
  }

  Future<void> sendEmailVerification() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = await auth.currentUser;
    user?.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = await auth.currentUser;
    return user!.emailVerified;
  }
}
