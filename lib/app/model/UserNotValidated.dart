import 'package:agenda_beauty_online/app/model/Role.dart';

class UserNotValidated {
  UserNotValidated({
    this.id,
    this.name,
    this.preferredEmail,
    this.phoneNumber,
    this.pictureUrl,
    this.username,
    this.authType,
    this.enabled,
    this.admin,
    this.validated,
    this.pushToken,
    this.roles,
    this.phoneValidated,
    this.nascimento,
    this.versionPro,
    this.versionCli,
    this.versionWeb,
    this.forceValidation,
    this.appPlatform,
    this.plataforma,
  });

  String? id;
  String? name;
  String? preferredEmail;
  String? phoneNumber;
  String? pictureUrl;
  String? username;
  String? authType;
  bool? enabled;
  bool? admin;
  bool? validated;
  String? pushToken;
  List<Role>? roles;
  bool? phoneValidated;
  DateTime? nascimento;
  int? versionPro;
  int? versionCli;
  int? versionWeb;
  int? forceValidation;
  String? appPlatform;
  String? plataforma;

  factory UserNotValidated.fromJson(Map<String?, dynamic> json) =>
      UserNotValidated(
        id: json["id"],
        name: json["name"],
        preferredEmail: json["preferredEmail"],
        phoneNumber: json["phoneNumber"] == null ? '' : json["phoneNumber"],
        pictureUrl: json["pictureUrl"] == null ? '' : json["pictureUrl"],
        username: json["username"],
        authType: json["authType"] == null ? '' : json["authType"],
        enabled: json["enabled"],
        admin: json["admin"],
        validated: json["validated"],
        pushToken: json["pushToken"] == null ? '' : json["pushToken"],
        roles: List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
        phoneValidated: json["phoneValidated"],
        nascimento: DateTime.parse(json["nascimento"]),
        versionPro: json["versionPro"],
        versionCli: json["versionCli"],
        versionWeb: json["versionWeb"] == null ? 0 : json["versionWeb"],
        forceValidation: json["forceValidation"],
        appPlatform: json["appPlatform"] == null ? '' : json["appPlatform"],
        plataforma: json["plataforma"] == null ? '' : json["plataforma"],
      );

  Map<String?, dynamic> toJson() => {
        "id": id,
        "name": name,
        "preferredEmail": preferredEmail,
        "phoneNumber": phoneNumber == '' ? null : phoneNumber,
        "pictureUrl": pictureUrl == '' ? null : pictureUrl,
        "username": username,
        "authType": authType == null ? '' : authType,
        "enabled": enabled,
        "admin": admin,
        "validated": validated,
        "pushToken": pushToken == null ? null : pushToken,
        "roles": List<dynamic>.from(roles!.map((x) => x.toJson())),
        "phoneValidated": phoneValidated,
        "nascimento": "",
        "versionPro": versionPro,
        "versionCli": versionCli,
        "versionWeb": versionWeb == null ? '' : versionWeb,
        "forceValidation": forceValidation,
        "appPlatform": appPlatform == null ? '' : appPlatform,
        "plataforma": plataforma == null ? '' : plataforma,
      };

  @override
  String toString() {
    return 'UserNotValidated{id: $id, name: $name, preferredEmail: $preferredEmail, phoneNumber: $phoneNumber, pictureUrl: $pictureUrl, username: $username, authType: $authType, enabled: $enabled, admin: $admin, validated: $validated, pushToken: $pushToken, roles: $roles, phoneValidated: $phoneValidated, nascimento: $nascimento, versionPro: $versionPro, versionCli: $versionCli, versionWeb: $versionWeb, forceValidation: $forceValidation, appPlatform: $appPlatform, plataforma: $plataforma}';
  }
}

enum AppPlatform { ANDROID }

final appPlatformValues = EnumValues({"ANDROID": AppPlatform.ANDROID});

enum AuthType { FIREBASE }

final authTypeValues = EnumValues({"FIREBASE": AuthType.FIREBASE});

enum Name { ROLE_PROFESSIONAL, ROLE_USER }

final nameValues = EnumValues(
    {"ROLE_PROFESSIONAL": Name.ROLE_PROFESSIONAL, "ROLE_USER": Name.ROLE_USER});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
