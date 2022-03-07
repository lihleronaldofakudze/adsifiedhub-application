import 'package:adsifiedhub/models/Advert.dart';
import 'package:adsifiedhub/services/database.dart';
import 'package:adsifiedhub/widgets/main_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdvertsScreen extends StatelessWidget {
  const AdvertsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    if (args['category'] == 'category') {
      return Scaffold(
        appBar: AppBar(
          title: Text(args['title']),
        ),
        body: StreamProvider<List<Advert>>.value(
          value: DatabaseService(byCategory: args['title']).getCategories,
          initialData: [],
          child: MainListWidget(),
        ),
      );
    } else if (args['category'] == 'subCategory') {
      return Scaffold(
        appBar: AppBar(
          title: Text(args['title']),
        ),
        body: StreamProvider<List<Advert>>.value(
          value: DatabaseService(bySubCategory: args['title']).getSubCategories,
          initialData: [],
          child: MainListWidget(),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(args['title']),
        ),
        body: StreamProvider<List<Advert>>.value(
          value: DatabaseService(bySubSubCategory: args['title'])
              .getSubSubCategories,
          initialData: [],
          child: MainListWidget(),
        ),
      );
    }
  }
}
