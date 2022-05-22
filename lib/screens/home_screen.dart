import 'package:adsifiedhub/models/Category.dart';
import 'package:adsifiedhub/models/CurrentUser.dart';
import 'package:adsifiedhub/widgets/drawer_widget.dart';
import 'package:adsifiedhub/widgets/login_popup_widget.dart';
import 'package:adsifiedhub/widgets/logout_popup_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<CurrentUser?>(context);
    Widget getSubsWidget(List<String> subs) {
      return new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: subs
              .map((sub) => new TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/adverts',
                        arguments: {'title': sub, 'category': 'subCategory'});
                  },
                  child: Text(
                    sub,
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 18),
                  )))
              .toList());
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/add_ad');
        },
        label: Text(
          'Post',
          style: TextStyle(fontSize: 18),
        ),
        icon: FaIcon(FontAwesomeIcons.rectangleAd),
      ),
      drawer: drawerWidget(context: context),
      appBar: AppBar(
        title: Text('AdsifiedHub'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search_rounded)),
          currentUser == null
              ? loginPopupWidget(context: context)
              : logoutPopupWidget(context: context)
        ],
      ),
      body: MasonryGridView.count(
        crossAxisCount: 2,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) => Card(
            elevation: 10.0,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ListTile(
                  title: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/adverts', arguments: {
                        'title': categories[index].main,
                        'category': 'category'
                      });
                    },
                    child: Text(
                      categories[index].main,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  trailing: categories[index].icon,
                ),
                getSubsWidget(categories[index].subs)
              ],
            )),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
    );
  }
}
