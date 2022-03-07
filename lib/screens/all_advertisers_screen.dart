import 'package:adsifiedhub/widgets/advertisers_list_widget.dart';
import 'package:flutter/material.dart';

class AllAdvertisersScreen extends StatelessWidget {
  const AllAdvertisersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Advertisers'),
      ),
      body: AdvertisersListWidget(),
    );
  }
}
