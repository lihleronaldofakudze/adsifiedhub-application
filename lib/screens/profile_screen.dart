import 'dart:io';

import 'package:adsifiedhub/models/Advertiser.dart';
import 'package:adsifiedhub/models/CurrentUser.dart';
import 'package:adsifiedhub/services/database.dart';
import 'package:adsifiedhub/widgets/loading_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File _image = File('');

  _pickImage(
      {required String uid,
      required String email,
      required String name,
      required String number,
      required String anotherNumber,
      required String region,
      required String city,
      required String streetName,
      required String website,
      required String type,
      required int free}) async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowCompression: true);

    if (result!.files.length > 10) {
      setState(() {
        _image = File('');
      });
    } else {
      setState(() {
        _image = File(result.files.single.path!);
      });
      Reference reference =
          FirebaseStorage.instance.ref().child('profiles').child('$uid.png');
      UploadTask uploadTask = reference.putFile(File(_image.path));
      uploadTask.whenComplete(() async {
        await reference.getDownloadURL().then((value) async {
          await DatabaseService(uid: uid).setAdvertiserProfile(
              image: value,
              email: email,
              name: name,
              number: number,
              anotherNumber: anotherNumber,
              region: region,
              city: city,
              streetName: streetName,
              website: website,
              type: type,
              free: free);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<CurrentUser?>(context);
    return StreamBuilder<Advertiser>(
      stream: DatabaseService(uid: currentUser!.uid).advertiser,
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
                ElevatedButton(
                    onPressed: () => _pickImage(
                        uid: currentUser.uid,
                        name: advertiser.name,
                        city: advertiser.city,
                        streetName: advertiser.streetName,
                        region: advertiser.region,
                        number: advertiser.number,
                        anotherNumber: advertiser.anotherNumber,
                        website: advertiser.website,
                        type: advertiser.type,
                        email: advertiser.email,
                        free: advertiser.free),
                    child: Text('Change Profile Picture')),
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
                    'N0 of Free Adverts : ${advertiser.free}\nBusiness Type : ${advertiser.type}',
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
