import 'package:adsifiedhub/models/Advertiser.dart';
import 'package:adsifiedhub/services/database.dart';
import 'package:adsifiedhub/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AdvertiserScreen extends StatefulWidget {
  const AdvertiserScreen({Key? key}) : super(key: key);

  @override
  _AdvertiserScreenState createState() => _AdvertiserScreenState();
}

class _AdvertiserScreenState extends State<AdvertiserScreen> {
  @override
  Widget build(BuildContext context) {
    final advertiserId = ModalRoute.of(context)!.settings.arguments as String;
    return StreamBuilder<Advertiser>(
      stream: DatabaseService(uid: advertiserId).advertiser,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Advertiser? advertiser = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              title: Text(advertiser!.name),
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.settings_rounded,
                      color: Colors.white,
                    ))
              ],
            ),
            body: ListView(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(advertiser.image),
                          fit: BoxFit.scaleDown)),
                ),
                Divider(),
                ListTile(
                  title: Text(
                    'Location',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Region : ${advertiser.region}\nCity : ${advertiser.city}\nStreet Name : ${advertiser.streetName}',
                    style: TextStyle(fontSize: 20),
                  ),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: FaIcon(
                      FontAwesomeIcons.internetExplorer,
                      color: Colors.blue,
                    ),
                    tooltip: 'Website',
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text(
                    'Contact Us',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Email : ${advertiser.email}\nNumber : ${advertiser.number} / ${advertiser.anotherNumber}',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text(
                    'Business Info',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Business Type : ${advertiser.type}',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          );
        } else {
          return LoadingWidget();
        }
      },
    );
  }
}
