import 'package:flutter/material.dart';

AlertDialog okDialogWidget(
        {required BuildContext context, required String message}) =>
    AlertDialog(
      title: Text('AdsifiedHub'),
      content: Text(message),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Ok'))
      ],
    );
