import 'package:flutter/material.dart';

PopupMenuButton loginPopupWidget({required BuildContext context}) =>
    PopupMenuButton(
        onSelected: (selected) {
          switch (selected.toString()) {
            case 'Login':
              Navigator.pushNamed(context, '/login');
              return;

            case 'Register':
              Navigator.pushNamed(context, '/register');
              return;
          }
        },
        itemBuilder: (context) => [
              PopupMenuItem(value: 'Login', child: Text('Login')),
              PopupMenuItem(value: 'Register', child: Text('Register')),
            ]);
