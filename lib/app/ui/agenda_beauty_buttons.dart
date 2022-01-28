import 'package:agenda_beauty_online/app/features/elements/progress_indicator.dart';
import 'package:agenda_beauty_online/app/features/elements/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


final Color RedButtonColor = Colors.red[400]!.withOpacity(0.9);

class AgendaBeautyButtons {
  static Widget Raised(String text, VoidCallback onPressed,
      {round = false, IconData? icon, double fontSize: 14, bold = false}) {
    return Container(
      width: double.infinity,
      height: 45,
      child: Material(
        elevation: 1,
        shadowColor: Colors.black26,
        borderRadius:
            round ? BorderRadius.circular(45) : BorderRadius.circular(5),
        child: icon == null
            ? FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(round ? 45 : 5)),
                disabledColor: Color.fromRGBO(255, 204, 51, 0.3),
                onPressed: onPressed,
//          color: Color.fromRGBO(255, 213, 74, 1),
                color: AppStyle.primaryColor,
                child: Text(
                  text,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: bold ? FontWeight.bold : FontWeight.w500,
                    fontSize: fontSize,
                  ),
                ),
              )
            : FlatButton.icon(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(round ? 45 : 5)),
                disabledColor: Color.fromRGBO(255, 204, 51, 0.3),
                onPressed: onPressed,
//          color: Color.fromRGBO(255, 213, 74, 1),
                color: AppStyle.primaryColor,
                icon: Icon(icon, color: Colors.white),
                label: Text(
                  text,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: bold ? FontWeight.bold : FontWeight.w500,
                    fontSize: fontSize,
                  ),
                ),
              ),
      ),
    );
  }

  static Widget CircleWithLabel(
      {required String label,
      @required IconData? icon,
      double? fontSize: 12,
      double? size: 60.0,
      double iconSize: 25.0,
      disabled = false,
      bold = false}) {
    return Container(
      width: double.infinity,
      height: 100,
      child: Column(
        children: [
          Opacity(
            opacity: disabled ? 0.5 : 1,
            child: Material(
              elevation: 1,
              shadowColor: Colors.black26,
              color: !disabled
                  ? AppStyle.accentColor.withOpacity(0.9)
                  : Color.fromRGBO(255, 204, 51, 0.3),
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(200),
              ),
              child: Container(
                width: size,
                height: size,
                child: InkWell(
                  borderRadius: new BorderRadius.circular(200),
                  onTap: () {
                    if (!disabled) {
                      // onPressed();
                    }
                  },
                  child: Center(
                    child: Icon(icon, color: Colors.white, size: iconSize,),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8),
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: bold ? FontWeight.bold : FontWeight.w500,
                fontSize: fontSize,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget RaisedSuccess(String text, VoidCallback onPressed,
      {round = false, bold = false}) {
    return Container(
      width: double.infinity,
      height: 45,
      child: Material(
        elevation: 1,
        shadowColor: Colors.black26,
        borderRadius: new BorderRadius.circular(round ? 45 : 5),
        child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(round ? 45 : 5)),
          disabledColor: Colors.teal[500]!.withOpacity(0.3),
          onPressed: onPressed,
//          color: Color.fromRGBO(255, 213, 74, 1),
          color: Colors.teal[500],
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: bold ? FontWeight.bold : FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  static Widget RaisedError(String text, VoidCallback onPressed,
      {round = false, bold = false}) {
    return Container(
      width: double.infinity,
      height: 45,
      child: Material(
        elevation: 1,
        shadowColor: Colors.black26,
        borderRadius: new BorderRadius.circular(round ? 45 : 5),
        child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(round ? 45 : 5)),
          disabledColor: Color.fromRGBO(255, 204, 51, 0.3),
          onPressed: onPressed,
//          color: Color.fromRGBO(255, 213, 74, 1),
          color: Colors.red[400]!.withOpacity(0.9),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: bold ? FontWeight.bold : FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  static Widget RaisedWhite(String text, VoidCallback onPressed,
      {round = false}) {
    return Container(
      width: double.infinity,
      height: 45,
      child: Material(
        elevation: 1,
        shadowColor: Colors.black26,
        borderRadius: new BorderRadius.circular(round ? 45 : 5),
        child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(round ? 45 : 5)),
          disabledColor: Colors.grey.withOpacity(0.3),
          onPressed: onPressed,
          color: Colors.white,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  static Widget Outlined(String text, VoidCallback onPressed, {round = false}) {
    return FlatButton(
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(round ? 50.0 : 5.0),
          side: BorderSide(color: AppStyle.primaryColor)),
      textColor: AppStyle.primaryColor,
      disabledColor: AppStyle.primaryColor.withOpacity(0.1),
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14.0,
        ),
      ),
    );
  }

  static Widget OutlinedWithIcon(String text, Widget icon, VoidCallback action,
      {round = false, bordered = true}) {
    return OutlineButton.icon(
      textColor: AppStyle.primaryColor,
      borderSide: bordered
          ? BorderSide(width: 1.0, color: AppStyle.primaryColor)
          : null,
      shape: round
          ? RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)))
          : null,
      highlightedBorderColor: AppStyle.primaryColor,
      icon: icon,
      label: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Text(
          text,
          style: TextStyle(fontSize: 14),
        ),
      ),
      onPressed: action,
    );
  }

  static Widget RedOutlined(String text, VoidCallback action,
      {round = false, bordered = true}) {
    return OutlineButton(
      textColor: RedButtonColor,
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(round ? 50.0 : 5.0),
          side: BorderSide(color: RedButtonColor)),
      borderSide:
          bordered ? BorderSide(width: 1.0, color: RedButtonColor) : null,
      highlightedBorderColor: RedButtonColor,
      child: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Text(
          text,
          style: TextStyle(fontSize: 14),
        ),
      ),
      onPressed: action,
    );
  }

  static Widget RedOutlinedWithIcon(
      String text, Widget icon, VoidCallback action,
      {round = false, bordered = true}) {
    return OutlineButton.icon(
      textColor: RedButtonColor,
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(round ? 50.0 : 5.0),
          side: BorderSide(color: RedButtonColor)),
      borderSide:
          bordered ? BorderSide(width: 1.0, color: RedButtonColor) : null,
      highlightedBorderColor: RedButtonColor,
      icon: icon,
      label: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Text(
          text,
          style: TextStyle(fontSize: 14),
        ),
      ),
      onPressed: action,
    );
  }

  static Widget Loading({round = false}) {
    return FlatButton(
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(round ? 45 : 5.0),
          side: BorderSide(color: AppStyle.primaryColor)),
      textColor: AppStyle.primaryColor,
      disabledColor: AppStyle.primaryColor.withOpacity(0.1),
      padding: EdgeInsets.all(8.0),
      onPressed: null,
      child: AgendaBeautyProgressIndicator(size: 20),
    );
  }

  static Widget RaisedLoading({round = false, disabled = true}) {
    return Container(
      width: double.infinity,
      height: 45,
      child: Material(
          elevation: 1,
          shadowColor: Colors.black26,
          borderRadius:
              round ? BorderRadius.circular(45) : BorderRadius.circular(5),
          child: FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(round ? 45 : 5)),
            disabledColor: AppStyle.primaryColor.withOpacity(0.7),
            onPressed: disabled ? null : () {},
//          color: Color.fromRGBO(255, 213, 74, 1),
            color: AppStyle.primaryColor,
            child: AgendaBeautyProgressIndicator(
              size: 20,
              color: Colors.white,
            ),
          )),
    );
  }
}
