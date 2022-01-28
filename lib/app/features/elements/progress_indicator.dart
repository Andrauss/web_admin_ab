import 'package:agenda_beauty_online/app/features/elements/styles.dart';
import 'package:flutter/material.dart';

class AgendaBeautyProgressIndicator extends StatelessWidget {
  final double size;
  final Color color;

  const AgendaBeautyProgressIndicator(
      {this.size = 200, this.color = AppStyle.accentColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      child: Center(
          child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          color,
        ),
      )),
    );
  }
}
