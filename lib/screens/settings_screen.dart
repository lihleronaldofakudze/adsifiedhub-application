import 'package:adsifiedhub/models/Advertiser.dart';
import 'package:adsifiedhub/models/CurrentUser.dart';
import 'package:adsifiedhub/services/database.dart';
import 'package:adsifiedhub/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<CurrentUser?>(context);
    return StreamBuilder<Advertiser>(
      stream: DatabaseService(uid: currentUser!.uid).advertiser,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Edit Profile'),
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text('Please enter all details'),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  )
                ],
              ),
            ),
          );
        } else {
          return LoadingWidget();
        }
      },
    );
  }
}
