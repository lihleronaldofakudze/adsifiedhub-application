import 'package:adsifiedhub/models/Advertiser.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdvertisersListWidget extends StatelessWidget {
  const AdvertisersListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final advertisers = Provider.of<List<Advertiser>>(context);
    return ListView.builder(
      itemCount: advertisers.length,
      itemBuilder: (context, index) {
        return Card(
          child: Column(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(advertisers[index].image),
                        fit: BoxFit.scaleDown)),
              ),
              ListTile(
                title: Text(
                  '${advertisers[index].name}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                subtitle: Text(
                  'Region : ${advertisers[index].region}\nCity : ${advertisers[index].city}\nStreet Name : ${advertisers[index].streetName}',
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
