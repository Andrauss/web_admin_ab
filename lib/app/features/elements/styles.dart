import 'dart:io';

import 'package:agenda_beauty_online/app/util/color_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppStyle {
  static final Color backgroundColor = Colors.grey[50]!.withOpacity(0.7);
  static const Color accentColor = Color.fromRGBO(247, 218, 87, 1);
  static final Color primaryColor = Color(0xFFC9A556);
//  static final Color bodyColor = Color(0xFFEFEFF4);
  static final Color bodyColor = Colors.grey[100]!;
  static final Color bodyColorDark = Colors.grey[900]!;
  static final Color homeTitleTextColor = ColorUtil.fromWeb("#e3c568");
  static final Color homeTitleTextColor2 = ColorUtil.fromWeb("#9c802c");
  static final isAndroid = Platform.isAndroid;

  static final darkTheme = ThemeData.dark().copyWith(
    canvasColor: Colors.grey[800],
    primaryColor: Colors.grey[800],
    accentColor: accentColor,
    toggleableActiveColor: accentColor,
    textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'Poppins'),
    primaryTextTheme: ThemeData.dark()
        .primaryTextTheme
        .apply(fontFamily: 'Poppins')
        .copyWith(headline6: TextStyle(fontSize: 16, fontFamily: 'Poppins')),
    accentTextTheme:
        ThemeData.dark().accentTextTheme.apply(fontFamily: 'Poppins'),
  );

  static final lightTheme = ThemeData(
    fontFamily: 'Poppins',
    primaryColor: Colors.white,
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(color: Colors.black),
      hintStyle: TextStyle(color: Colors.grey),
    ),
    primaryTextTheme: ThemeData.light()
        .primaryTextTheme
        .apply(fontFamily: 'Poppins')
        .copyWith(headline6: TextStyle(fontSize: 16, fontFamily: 'Poppins')),
    canvasColor: Colors.white,
    cardColor: Colors.white,
    primaryColorBrightness: Brightness.light,
    accentColor: accentColor,
//    hintColor: Colors.pink,
    toggleableActiveColor: accentColor,
  );

  static final lightThemeForm = ThemeData(
    fontFamily: 'Poppins',
    primaryColor: primaryColor,
    tabBarTheme: (ThemeData()
          ..tabBarTheme.copyWith(
            labelStyle: TextStyle(color: Colors.grey, fontFamily: 'Poppins'),
          ))
        .tabBarTheme,
    primaryTextTheme: Typography.material2014(
            platform: isAndroid ? TargetPlatform.android : TargetPlatform.iOS)
        .black
        .apply(fontFamily: 'Poppins')
        .copyWith(
          headline6: TextStyle(
              fontFamily: 'Poppins',
              inherit: true,
              fontSize: 16,
              color: Colors.black87,
              decoration: TextDecoration.none),
        ),
    primaryColorBrightness: Brightness.light,
    canvasColor: Colors.white,
    cardColor: Colors.white,
    backgroundColor: Colors.white,
    accentColor: accentColor,
    toggleableActiveColor: accentColor,
  );

  static final defaultBottomSheetBorder = RoundedRectangleBorder(
      borderRadius: new BorderRadius.only(
    topLeft: Radius.circular(16),
    topRight: Radius.circular(16),
  ));

  static final defaultBorderShape = RoundedRectangleBorder(
      borderRadius: new BorderRadius.all(Radius.circular(4)));
}
