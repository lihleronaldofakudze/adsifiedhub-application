import 'package:adsifiedhub/models/Advert.dart';
import 'package:adsifiedhub/models/CurrentUser.dart';
import 'package:adsifiedhub/services/database_service.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class MainListWidget extends StatelessWidget {
  const MainListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final adverts = Provider.of<List<Advert>>(context);
    final currentUser = Provider.of<CurrentUser?>(context);
    if (currentUser == null) {
      return ListView.builder(
        itemCount: adverts.length,
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 250.0,
                      viewportFraction: 1,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                    ),
                    items: adverts[index].images.map((image) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(image),
                                    fit: BoxFit.scaleDown)),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  Text(
                    '${adverts[index].title}',
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'E ${adverts[index].price} - ${adverts[index].negotiable}',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                          Text(
                            '${adverts[index].firstCategory} - ${adverts[index].secondaryCategory} - ${adverts[index].thirdCategory}',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      Container(),
                    ],
                  ),
                  Divider(),
                  Text(
                    '${adverts[index].description}',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                  ),
                  Divider(),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: FaIcon(
                            FontAwesomeIcons.facebook,
                            color: Colors.blue,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: FaIcon(
                            FontAwesomeIcons.instagram,
                            color: Colors.deepOrange,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: FaIcon(
                            FontAwesomeIcons.linkedin,
                            color: Colors.lightBlueAccent,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: FaIcon(
                            FontAwesomeIcons.whatsapp,
                            color: Colors.green,
                          )),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      );
    } else {
      return ListView.builder(
        itemCount: adverts.length,
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 250.0,
                      viewportFraction: 1,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                    ),
                    items: adverts[index].images.map((image) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(image),
                                    fit: BoxFit.scaleDown)),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  Text(
                    '${adverts[index].title}',
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'E ${adverts[index].price}0 - ${adverts[index].negotiable}',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                          Text(
                            '${adverts[index].firstCategory}\n${adverts[index].secondaryCategory}\n${adverts[index].thirdCategory}',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      IconButton(
                          onPressed: () async {
                            if (adverts[index]
                                .likes
                                .contains(currentUser.uid)) {
                              await DatabaseService(
                                      adId: adverts[index].id,
                                      uid: currentUser.uid)
                                  .unLike();
                            } else {
                              await DatabaseService(
                                      adId: adverts[index].id,
                                      uid: currentUser.uid)
                                  .like();
                            }
                          },
                          icon: Icon(
                            adverts[index].likes.contains(currentUser.uid)
                                ? Icons.favorite_rounded
                                : Icons.favorite_border_rounded,
                            color: Colors.red,
                          ))
                    ],
                  ),
                  Divider(),
                  Text(
                    '${adverts[index].description}',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                  ),
                  Divider(),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: FaIcon(
                            FontAwesomeIcons.facebook,
                            color: Colors.blue,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: FaIcon(
                            FontAwesomeIcons.twitter,
                            color: Colors.lightBlue,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: FaIcon(
                            FontAwesomeIcons.linkedin,
                            color: Colors.lightBlueAccent,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: FaIcon(
                            FontAwesomeIcons.whatsapp,
                            color: Colors.green,
                          )),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      );
    }
  }
}
