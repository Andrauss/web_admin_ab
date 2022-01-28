import 'package:agenda_beauty_online/app/security/AuthData.dart';
import 'package:agenda_beauty_online/app/util/date_time_util_ab.dart';
import 'Endereco.dart';
import 'enums/ComoConheceu.dart';

class Usuario {
  bool? admin;
  bool? enabled;
  String? id;
  String? name;
  DateTime? nascimento;
  String? senha;
  String? phoneNumber;
  dynamic pictureUrl;
  String? pictureUrlOld;
  String? pushToken;
  String? refreshToken;
  String? preferredEmail;
  bool? validated;
  bool? phoneValidated;

  ComoConheceu? comoConheceu;
  int? versionPro;
  int? versionCli;
  String? appPlatform;
  List<Endereco>? enderecos;

  bool? changed = false;

  Usuario({
    this.admin,
    this.enabled,
    this.id,
    this.pushToken,
    this.refreshToken,
    this.name,
    this.nascimento,
    this.senha,
    this.phoneNumber,
    this.pictureUrl,
    this.pictureUrlOld,
    this.preferredEmail,
    this.versionPro,
    this.versionCli,
    this.appPlatform,
    this.comoConheceu,
    this.validated,
    this.phoneValidated,
    this.enderecos,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        admin: json["admin"],
        enabled: json["enabled"],
        id: json["id"],
        name: json["name"],
        nascimento: json["nascimento"] == null
            ? null
            : DateTime.parse(json["nascimento"]),
        phoneNumber: json["phoneNumber"],
        pictureUrl: json["pictureUrl"],
        pictureUrlOld: json["pictureUrl"],
        pushToken: json["pushToken"],
        refreshToken: json["refreshToken"],
        preferredEmail: json["preferredEmail"],
        validated: json["validated"],
        comoConheceu: json["comoConheceu"] == null
            ? null
            : comoConheceuFromString(json["comoConheceu"]),
        versionPro: json["versionPro"],
        versionCli: json["versionCli"],
        appPlatform: json["appPlatform"],
        phoneValidated: json["phoneValidated"],
        enderecos: json["enderecos"] == null
            ? []
            : List<Endereco>.from(
                json["enderecos"].map((x) => Endereco.fromJson(x))),
      );

  Map<String?, dynamic> toJson() => {
        "admin": admin,
        "enabled": enabled,
        "id": id,
        "name": name,
        "nascimento":
            nascimento == null ? null : DateUtilsAB.getAsYYYYMMDD(nascimento!),
        "pushToken": pushToken,
        "refreshToken": refreshToken,
        "phoneNumber": phoneNumber,
        "pictureUrl": pictureUrl,
        "preferredEmail": preferredEmail,
        "validated": validated,
        "comoConheceu":
            comoConheceu == null ? null : comoConheceuToString(comoConheceu!),
        "versionPro": versionPro,
        "versionCli": versionCli,
        "appPlatform": appPlatform,
        "phoneValidated": phoneValidated,
      };

  Usuario.fromAuthData(AuthData currentData) {
    id = currentData.userId;
    preferredEmail = currentData.email;
    name = currentData.name;
    admin = currentData.isAdmin;
    enabled = currentData.enabled;
    validated = currentData.validated;
    phoneValidated = currentData.phoneValidated;
    phoneNumber = currentData.phoneNumber;
    pictureUrl = currentData.pictureUrl;
    versionCli = currentData.versionCli;
    versionPro = currentData.versionPro;
    appPlatform = currentData.appPlatform;
    pushToken = currentData.pushToken;
  }

  @override
  String toString() {
    return 'Usuario{admin: $admin, enabled: $enabled, id: $id, name: $name, nascimento: $nascimento, senha: $senha, phoneNumber: $phoneNumber, pictureUrl: $pictureUrl, pictureUrlOld: $pictureUrlOld, pushToken: $pushToken, refreshToken: $refreshToken, preferredEmail: $preferredEmail, validated: $validated, phoneValidated: $phoneValidated, comoConheceu: $comoConheceu, versionPro: $versionPro, versionCli: $versionCli, appPlatform: $appPlatform, enderecos: $enderecos, changed: $changed}';
  }
}
