class AuthData {
  String? accessToken;
  String? refreshToken;
  String? pushToken;
  String? pictureUrl;
  List<String>? roles;
  String? name;
  String? userId;
  String? email;
  bool? enabled;
  bool? isAdmin;
  bool? validated;
  bool? phoneValidated;
  String? phoneNumber;
  int? versionPro;
  int? versionCli;
  String? appPlatform;

  AuthData.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    pushToken = json['push_token'];
    validated = json['validated'];
    phoneValidated = json['phone_validated'];
    phoneNumber = json['phoneNumber'];
    pictureUrl = json['picture_url'];
    if (json['roles'] != null) {
      roles = json['roles'].forEach((v) {
        roles?.add(v.toString());
      });
    }
    name = json['name'];
    userId = json['userId'];
    email = json['email'];
    enabled = json['enabled'];
    isAdmin = json['isAdmin'];

    versionPro = json['version_pro'];
    versionCli = json['version_cli'];
    appPlatform = json['app_platform'];
  }

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "push_token": pushToken,
        "refresh_token": refreshToken,
        "email": email,
        "enabled": enabled,
        "isAdmin": isAdmin,
        "name": name,
        "picture_url": pictureUrl,
        "roles": List<dynamic>.from(roles!.map((x) => x)),
        "userId": userId,
        "validated": validated,
        "phone_validated": phoneValidated,
        "version_pro": versionPro,
        "version_cli": versionCli,
        "app_platform": appPlatform,
      };
}
