import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void abDialog(BuildContext ctxTela, String titulo, String msg) async {
  return showDialog(
    context: ctxTela,
    builder: (context) {
      String contentText = "Content of Dialog";
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            child: Container(
                width: 300,
                height: 200,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        color: Color.fromRGBO(208, 199, 166, 0.9),
                        child: Row(
                            // A Row widget
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween, // Free space will be equally divided and will be placed between the children.
                            children: [
                              IconButton(
                                  // A normal IconButton
                                  icon: Icon(
                                    Icons.clear,
                                    color: Colors.transparent,
                                  ),
                                  onPressed: () {
                                    // Navigator.of(context).pop();
                                  }),
                              Flexible(
                                // A Flexible widget that will make its child flexible
                                child: Text(
                                  titulo, // A very long text
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromRGBO(31, 73, 68, 0.9),
                                  ), // handles overflowing of text
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: IconButton(
                                    // A normal IconButton
                                    icon: Icon(Icons.clear),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    }),
                              )
                            ]),
                      ),
                      Center(
                          child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(msg),
                      ))
                    ],
                  ),
                )),
          );
        },
      );
    },
  );
}

showErrorToastBottom(String message,
    {time: Toast.LENGTH_SHORT, ToastGravity position: ToastGravity.BOTTOM}) {
  showErrorToast(message, time: time, position: position);
}

showErrorToast(String message,
    {time: Toast.LENGTH_LONG, ToastGravity position: ToastGravity.BOTTOM}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: time,
      gravity: position,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}

showSuccessToastBottom(String message,
    {time: Toast.LENGTH_SHORT, ToastGravity position: ToastGravity.BOTTOM}) {
  showSuccessToast(message, time: time, position: position);
}

showSuccessToast(String message,
    {time: Toast.LENGTH_SHORT, ToastGravity position: ToastGravity.TOP}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: time,
      gravity: position,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0);
}

showAlertaToastBottom(String message,
    {time: Toast.LENGTH_SHORT, ToastGravity position: ToastGravity.CENTER}) {
  showAlertaToast(message, time: time, position: position);
}

showAlertaToast(String message,
    {time: Toast.LENGTH_LONG, ToastGravity position: ToastGravity.CENTER}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: time,
      gravity: position,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.amber,
      textColor: Colors.blueGrey,
      fontSize: 16.0);
}
