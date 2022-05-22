import 'package:adsifiedhub/models/Advert.dart';
import 'package:adsifiedhub/models/CurrentUser.dart';
import 'package:adsifiedhub/services/database_service.dart';
import 'package:adsifiedhub/widgets/main_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserAdvertsScreen extends StatelessWidget {
  const UserAdvertsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<CurrentUser?>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('My Adverts'),
      ),
      body: StreamProvider<List<Advert>>.value(
        value: DatabaseService(uid: currentUser!.uid).userAdverts,
        initialData: [],
        child: MainListWidget(),
      ),
    );
  }
}
