import 'package:adsifiedhub/models/Advert.dart';
import 'package:adsifiedhub/models/Advertiser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  final String? adId;
  final String? byCategory;
  final String? bySubCategory;
  final String? bySubSubCategory;

  DatabaseService(
      {this.uid,
      this.adId,
      this.byCategory,
      this.bySubCategory,
      this.bySubSubCategory});

  final CollectionReference _advertisersCollection =
      FirebaseFirestore.instance.collection('advertisers');
  final CollectionReference _advertsCollection =
      FirebaseFirestore.instance.collection('adverts');

  //User Activities
  Future setAdvertiserProfile(
      {required String image,
      required String email,
      required String name,
      required String number,
      required String anotherNumber,
      required String region,
      required String city,
      required String streetName,
      required String website,
      required String type,
      required int free}) {
    return _advertisersCollection.doc(uid).set({
      'image': image,
      'email': email,
      'name': name,
      'number': number,
      'anotherNumber': anotherNumber,
      'region': region,
      'city': city,
      'website': website,
      'streetName': streetName,
      'type': type,
      'free': free
    });
  }

  Advertiser _advertiserFromSnapshot(DocumentSnapshot snapshot) {
    return Advertiser(
        id: snapshot.id,
        website: snapshot.get('website'),
        free: snapshot.get('free'),
        city: snapshot.get('city'),
        number: snapshot.get('number'),
        email: snapshot.get('email'),
        image: snapshot.get('image'),
        anotherNumber: snapshot.get('anotherNumber'),
        type: snapshot.get('type'),
        name: snapshot.get('name'),
        region: snapshot.get('region'),
        streetName: snapshot.get('streetName'));
  }

  List<Advertiser> _advertisersFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Advertiser(
          id: doc.id,
          website: doc.get('website'),
          free: doc.get('free'),
          city: doc.get('city'),
          number: doc.get('number'),
          type: doc.get('type'),
          email: doc.get('email'),
          image: doc.get('image'),
          anotherNumber: doc.get('anotherNumber'),
          name: doc.get('name'),
          region: doc.get('region'),
          streetName: doc.get('streetName'));
    }).toList();
  }

  Stream<Advertiser> get advertiser {
    return _advertisersCollection
        .doc(uid)
        .snapshots()
        .map(_advertiserFromSnapshot);
  }

  Stream<List<Advertiser>> get advertisers {
    return _advertisersCollection.snapshots().map(_advertisersFromSnapshot);
  }

  //Adverts Activities
  Future addAdvert(
      {required List images,
      required String title,
      required String description,
      required String category,
      required String subCategory,
      required String subSubCategory,
      required String condition,
      required String negotiable,
      required double price,
      required String subscription}) {
    return _advertsCollection.add({
      'uid': uid,
      'images': images,
      'title': title,
      'description': description,
      'category': category,
      'subCategory': subCategory,
      'subSubCategory': subSubCategory,
      'condition': condition,
      'negotiable': negotiable,
      'price': price,
      'subscription': subscription,
      'likes': [],
      'postedAt': new DateTime.now(),
      'updatedAt': new DateTime.now(),
    }).then((value) {
      if (subscription == 'Free') {
        return _advertisersCollection
            .doc(uid)
            .update({'free': FieldValue.increment(1)});
      } else {
        return null;
      }
    });
  }

  List<Advert> _advertsFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Advert(
          id: doc.id,
          uid: doc.get('uid'),
          category: doc.get('category'),
          condition: doc.get('condition'),
          images: doc.get('images'),
          price: doc.get('price'),
          description: doc.get('description'),
          postedAt: doc.get('postedAt'),
          title: doc.get('title'),
          updatedAt: doc.get('updatedAt'),
          subSubCategory: doc.get('subSubCategory'),
          negotiable: doc.get('negotiable'),
          likes: doc.get('likes'),
          subCategory: doc.get('subCategory'),
          subscription: doc.get('subscription'));
    }).toList();
  }

  Advert _advertFromSnapshot(DocumentSnapshot snapshot) {
    return Advert(
        id: snapshot.id,
        uid: snapshot.get('uid'),
        category: snapshot.get('category'),
        condition: snapshot.get('condition'),
        images: snapshot.get('images'),
        price: snapshot.get('price'),
        description: snapshot.get('description'),
        postedAt: snapshot.get('postedAt'),
        title: snapshot.get('title'),
        updatedAt: snapshot.get('updatedAt'),
        subSubCategory: snapshot.get('subSubCategory'),
        negotiable: snapshot.get('negotiable'),
        likes: snapshot.get('likes'),
        subCategory: snapshot.get('subCategory'),
        subscription: snapshot.get('subscription'));
  }

  Stream<Advert> get advert {
    return _advertsCollection.doc(adId).snapshots().map(_advertFromSnapshot);
  }

  Stream<List<Advert>> get adverts {
    return _advertsCollection.snapshots().map(_advertsFromSnapshot);
  }

  Stream<List<Advert>> get userAdverts {
    return _advertsCollection
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map(_advertsFromSnapshot);
  }

  Stream<List<Advert>> get favorites {
    return _advertsCollection
        .where('likes', arrayContains: uid)
        .snapshots()
        .map(_advertsFromSnapshot);
  }

  Stream<List<Advert>> get getCategories {
    return _advertsCollection
        .where('category', isEqualTo: byCategory)
        .snapshots()
        .map(_advertsFromSnapshot);
  }

  Stream<List<Advert>> get getSubCategories {
    return _advertsCollection
        .where('subCategory', isEqualTo: bySubCategory)
        .snapshots()
        .map(_advertsFromSnapshot);
  }

  Stream<List<Advert>> get getSubSubCategories {
    return _advertsCollection
        .where('subSubCategory', isEqualTo: bySubSubCategory)
        .snapshots()
        .map(_advertsFromSnapshot);
  }

  Future like() {
    return _advertsCollection.doc(adId).update({
      'likes': FieldValue.arrayUnion([uid])
    });
  }

  Future unLike() {
    return _advertsCollection.doc(adId).update({
      'likes': FieldValue.arrayRemove([uid])
    });
  }
}
