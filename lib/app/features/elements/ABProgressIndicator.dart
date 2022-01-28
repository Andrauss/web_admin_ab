import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ABProgressIndicator extends StatelessWidget {
  final double? size;
  final Color? color;

  const ABProgressIndicator({this.size = 200, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      child: Center(
          child:
              CupertinoActivityIndicator(animating: true, radius: size! / 5)),
    );
  }
}
