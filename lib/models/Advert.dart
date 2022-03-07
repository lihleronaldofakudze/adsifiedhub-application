import 'package:cloud_firestore/cloud_firestore.dart';

class Advert {
  final String id;
  final String uid;
  final List images;
  final String title;
  final String description;
  final double price;
  final String category;
  final String subCategory;
  final String subSubCategory;
  final String condition;
  final String subscription;
  final String negotiable;
  final List likes;
  final Timestamp updatedAt;
  final Timestamp postedAt;

  Advert(
      {required this.id,
      required this.uid,
      required this.category,
      required this.condition,
      required this.images,
      required this.price,
      required this.description,
      required this.postedAt,
      required this.title,
      required this.updatedAt,
      required this.subSubCategory,
      required this.negotiable,
      required this.likes,
      required this.subCategory,
      required this.subscription});
}
