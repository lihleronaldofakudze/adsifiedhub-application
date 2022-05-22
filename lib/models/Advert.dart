import 'package:cloud_firestore/cloud_firestore.dart';

class Advert {
  final String id;
  final String uid;
  final List images;
  final String title;
  final String description;
  final int price;
  final String firstCategory;
  final String secondaryCategory;
  final String thirdCategory;
  final String condition;
  final String subscription;
  final String negotiable;
  final List likes;
  final Timestamp updatedAt;
  final Timestamp postedAt;

  Advert(
      {required this.id,
      required this.uid,
      required this.firstCategory,
      required this.condition,
      required this.images,
      required this.price,
      required this.description,
      required this.postedAt,
      required this.title,
      required this.updatedAt,
      required this.thirdCategory,
      required this.negotiable,
      required this.likes,
      required this.secondaryCategory,
      required this.subscription});
}
