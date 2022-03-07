import 'package:adsifiedhub/models/CurrentUser.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageAdvertsScreen extends StatelessWidget {
  const ManageAdvertsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<CurrentUser?>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage My Advert'),
      ),
    );
  }
}
