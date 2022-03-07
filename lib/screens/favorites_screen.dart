import 'package:adsifiedhub/models/Advert.dart';
import 'package:adsifiedhub/models/CurrentUser.dart';
import 'package:adsifiedhub/services/database.dart';
import 'package:adsifiedhub/widgets/main_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<CurrentUser?>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: StreamProvider<List<Advert>>.value(
        value: DatabaseService(uid: currentUser!.uid).favorites,
        initialData: [],
        child: MainListWidget(),
      ),
    );
  }
}
