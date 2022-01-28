import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';

class ErrorPanel extends StatelessWidget {
  final String? message;
  final Widget? icon;
  final double? opacity;
  final Color? backgroundBase;
  final List<Widget>? actions;

  static Color baseColor = Colors.red[600]!.withOpacity(0.8);

  const ErrorPanel(this.message,
      {this.icon,
      this.actions,
      this.opacity = 0.9,
      this.backgroundBase = Colors.white})
      : super(key: const ValueKey('ErrorPanel'));

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        color: this.backgroundBase!.withOpacity(opacity!),
        padding:
            const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0, bottom: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(),
            ),
            icon! != null
                ? icon!
                : Icon(
                    EvaIcons.alertTriangleOutline,
                    color: baseColor,
                    size: 80,
                  ),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(
                message!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: baseColor,
                  fontSize: 20,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(),
            ),
            ...(actions! == null ? [] : actions!)
          ],
        ),
      ),
    );
  }

  static Widget ErrorButton(String text, VoidCallback action) {
    return OutlineButton(
      textColor: ErrorPanel.baseColor,
      highlightedBorderColor: ErrorPanel.baseColor,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Text(
          text,
          style: TextStyle(fontSize: 14),
        ),
      ),
      onPressed: action,
    );
  }

  static Widget ErrorIconButton(String text, Widget icon, VoidCallback action) {
    return OutlineButton.icon(
      textColor: ErrorPanel.baseColor,
      highlightedBorderColor: ErrorPanel.baseColor,
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

  static ErrorPanel withTryAgain(String message, Function() onTryAgain,
      {opacity = 0.5}) {
    return ErrorPanel(
      message,
      opacity: opacity,
      actions: <Widget>[
        ErrorPanel.ErrorIconButton(
          'Tentar novamente',
          Icon(Icons.refresh),
          () {
            onTryAgain();
          },
        )
      ],
    );
  }
}
