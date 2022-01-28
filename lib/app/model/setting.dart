import 'package:flutter/cupertino.dart';
import 'package:agenda_beauty_online/app/util/Utils.dart';

class Setting {
  String? appName = 'Agenda Beauty';
  double? defaultTax = 0.0;
  String? defaultCurrency;
  String? distanceUnit;
  bool? currencyRight = false;
  bool? payPalEnabled = true;
  bool? stripeEnabled = true;
  String? mainColor = "0xFFc9a556";
  String? mainDarkColor = "0xFFc79400";
  String? secondColor = "0xFF344968";
  String? secondDarkColor = "0xFFccccdd";
  String? accentColor = "0xFF8C98A8";
  String? accentDarkColor = "0xFFccccdd";
  String? scaffoldDarkColor = "0xFF2C2C2C";
  String? scaffoldColor = "0xFFFAFAFA";
  String? googleMapsKey = "AIzaSyD5NeapI6Mo0vN3uVBgMxBH4S5ltv8WdgU";
  ValueNotifier<Locale> mobileLanguage = new ValueNotifier(Locale('pt', ''));
  String? appVersion = "1.0";
  bool? enableVersion = true;

  Setting();

  Setting.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      appName = jsonMap['app_name'] ?? null;
      mainColor = jsonMap['main_color'] ?? null;
      mainDarkColor = jsonMap['main_dark_color'] ?? '';
      secondColor = jsonMap['second_color'] ?? '';
      secondDarkColor = jsonMap['second_dark_color'] ?? '';
      accentColor = jsonMap['accent_color'] ?? '';
      accentDarkColor = jsonMap['accent_dark_color'] ?? '';
      scaffoldDarkColor = jsonMap['scaffold_dark_color'] ?? '';
      scaffoldColor = jsonMap['scaffold_color'] ?? '';
      googleMapsKey = jsonMap['google_maps_key'] ?? null;
      mobileLanguage.value = Locale(jsonMap['mobile_language'] ?? "en", '');
      appVersion = jsonMap['app_version'] ?? '';
      distanceUnit = jsonMap['distance_unit'] ?? 'km';
      enableVersion = jsonMap['enable_version'] == null ? false : true;
      defaultTax = double.tryParse(jsonMap['default_tax']) ??
          0.0; //double.parse(jsonMap['default_tax'].toString());
      defaultCurrency = jsonMap['default_currency'] ?? '';
      currencyRight = jsonMap['currency_right'] == null ? false : true;
      payPalEnabled = jsonMap['enable_paypal'] == null ? false : true;
      stripeEnabled = jsonMap['enable_stripe'] == null ? false : true;
    } catch (e) {
      Utils().printAB(e);
    }
  }

//  ValueNotifier<Locale> initMobileLanguage(String defaultLanguage) {
//    SharedPreferences.getInstance().then((prefs) {
//      return new ValueNotifier(Locale(prefs.get('language') ?? defaultLanguage, ''));
//    });
//    return new ValueNotifier(Locale(defaultLanguage ?? "en", ''));
//  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["app_name"] = appName;
    map["default_tax"] = defaultTax;
    map["default_currency"] = defaultCurrency;
    map["currency_right"] = currencyRight;
    map["enable_paypal"] = payPalEnabled;
    map["enable_stripe"] = stripeEnabled;
    map["mobile_language"] = mobileLanguage.value.languageCode;
    return map;
  }
}
