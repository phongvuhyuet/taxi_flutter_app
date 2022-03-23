import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MsgDialog {
  static void showMsgDialog(BuildContext context, String title, String msg) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(title),
              content: Text(msg),
              actions: [
                new TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(MsgDialog);
                    },
                    child: Text("OK"))
              ],
            ));
  }
}
