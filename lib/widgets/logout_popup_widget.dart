import 'package:adsifiedhub/services/auth_service.dart';
import 'package:flutter/material.dart';

PopupMenuButton logoutPopupWidget({required BuildContext context}) =>
    PopupMenuButton(
        onSelected: (selected) async {
          switch (selected.toString()) {
            case 'My Adverts':
              Navigator.pushNamed(context, '/user_adverts');
              return;
            case 'Favorites':
              Navigator.pushNamed(context, '/favorites');
              return;
            case 'Profile':
              Navigator.pushNamed(context, '/profile');
              return;
            case 'All Advertisers':
              Navigator.pushNamed(context, '/all_advertisers');
              return;
            case 'Logout':
              await AuthService().logOut();
              return;
          }
        },
        itemBuilder: (context) => [
              PopupMenuItem(value: 'My Adverts', child: Text('My Adverts')),
              PopupMenuItem(value: 'Favorites', child: Text('Favorites')),
              PopupMenuItem(value: 'Profile', child: Text('My Profile')),
              PopupMenuItem(
                  value: 'All Advertisers', child: Text('All Advertisers')),
              PopupMenuItem(value: 'Logout', child: Text('Log Out')),
            ]);
