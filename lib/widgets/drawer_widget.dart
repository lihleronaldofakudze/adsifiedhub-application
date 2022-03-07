import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Drawer drawerWidget({required BuildContext context}) {
  return Drawer(
    child: SingleChildScrollView(
      child: Column(
        children: [
          DrawerHeader(
            child: Column(
              children: [
                Container(
                  height: 89,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/logo.png'),
                        fit: BoxFit.scaleDown),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: FaIcon(
                          FontAwesomeIcons.facebook,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: FaIcon(FontAwesomeIcons.whatsapp)),
                    IconButton(
                        onPressed: () {},
                        icon: FaIcon(FontAwesomeIcons.twitter)),
                    IconButton(
                        onPressed: () {},
                        icon: FaIcon(FontAwesomeIcons.linkedin)),
                  ],
                )
              ],
            ),
          ),
          ListTile(
            onTap: () {},
            title: Text(
              'How To Post An Ad',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            onTap: () {},
            title: Text(
              'Terms of Use',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            onTap: () {},
            title: Text(
              'Contact US',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            onTap: () {},
            title: Text(
              'About AdsifiedHub',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    ),
  );
}
