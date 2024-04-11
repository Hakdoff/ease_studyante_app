import 'package:flutter/material.dart';
import 'package:ease_studyante_app/core/config/app_constant.dart';

class CommonDialog {
  static Future<void> showMyDialog({
    required BuildContext context,
    required String body,
    String? title,
    bool isError = false,
    String? btnTitle,
    List<Widget>? buttons,
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title ?? AppConstant.appName,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  body,
                  style: TextStyle(color: isError ? Colors.red : null),
                ),
              ],
            ),
          ),
          actions: buttons ??
              <Widget>[
                TextButton(
                  child: Text(btnTitle ?? "Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
        );
      },
    );
  }
}
