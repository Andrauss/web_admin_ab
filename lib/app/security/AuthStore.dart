import 'dart:convert';
import 'package:agenda_beauty_online/app/model/Empresa.dart';
import 'package:agenda_beauty_online/app/model/EmpresaUsuario.dart';
import 'package:agenda_beauty_online/app/model/Usuario.dart';
import 'package:agenda_beauty_online/app/util/catcher_util.dart';
import 'package:agenda_beauty_online/app/util/prefs.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:agenda_beauty_online/app/util/Utils.dart';
import '../locator.dart';
import 'AuthData.dart';
import 'package:agenda_beauty_online/app/util/Utils.dart';
import 'package:agenda_beauty_online/app/repository/user_repository.dart'as userRepo;

const AUTH_DATA_KEY = "AuthData";
const AUTH_DATA_EMPRESA_KEY = "AuthDataEmpresaUsuario";

class AuthStore {
  static AuthStore _instance = new  AuthStore();
  static AuthData _data = AuthData as AuthData;

  set currentData(AuthData value) {
    _data = value;
    _storeDataOnPrefs();
  }

  _storeDataOnPrefs() {
    try {
      if (_currentData != null) {
        Prefs.setString(AUTH_DATA_KEY, json.encode(_currentData.toJson()));
      }
     
    } catch (exception, stackTrace) {
      // Catcher.reportCheckedError(exception, stackTrace);
      // CatcherUtil.catchError(exception, stackTrace);
    }
  }

  _loadDataFomPrefs() async {

 var a = await Prefs.getString(AUTH_DATA_KEY);
var _dataJSON = await userRepo.dencrypt(a.toString());

    try {

      if (_dataJSON != null || _dataJSON.isNotEmpty) {
        _data = AuthData.fromJson(json.decode(_dataJSON));
      }
    } catch (exception, stackTrace) {
//      Catcher.reportCheckedError(exception, stackTrace);
    }
  }

  AuthData get currentData {
    if (_data == null) {
      // Caso não possua dados em cache redireciona para o login
        QR.navigator.replaceAll('/login');
      // locator<NavigatorService>().navigateTo(Login());
    }
    return _data;
  }

  AuthData get _currentData => _data;


  Usuario? get currentUser => _data == null ? null : Usuario.fromAuthData(_data);

  static AuthStore instace() {
    if (_instance == null) {
      _instance = AuthStore();
    }
    return _instance;
  }

  updateUserData(Usuario usuario) {
    _instance._currentData.pictureUrl = usuario.pictureUrl;
    _instance._currentData.name = usuario.name;
    _instance._currentData.email = usuario.preferredEmail;
    _instance._currentData.validated = usuario.validated;
    _instance._currentData.phoneValidated = usuario.phoneValidated;
  }

  static Future<AuthStore> getInstance() async {
    if (_instance == null) {
      _instance = AuthStore();

      if (_data == null) {
        await _instance._loadDataFomPrefs();
      }

      return _instance;
    }
    return _instance;
  }

  static Future<Usuario?> getUsuario() async {
    var authStore = await getInstance();
    return authStore.currentUser;
  }

  static Future<Map> getAuthHeaders() async {
    var authStoreInstance = await AuthStore.getInstance();
    return {
      'Authorization': 'Bearer ${authStoreInstance.currentData.accessToken}'
    };
  }

  void signOut() async {
    try {
      
      // Prefs.setString(AUTH_DATA_KEY, );
      // Prefs.setString(AUTH_DATA_EMPRESA_KEY, null);
    } catch (exception, stackTrace) {
      // Catcher.reportCheckedError(exception, stackTrace);
      // CatcherUtil.catchError(exception, stackTrace);
      Utils().printAB(exception);
    }
  }

}
