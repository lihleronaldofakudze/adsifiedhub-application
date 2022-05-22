import 'package:adsifiedhub/models/Advert.dart';
import 'package:adsifiedhub/models/Advertiser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  final String? adId;
  final String? byFirstCategory;
  final String? bySecondCategory;
  final String? byThirdCategory;

  DatabaseService(
      {this.uid,
      this.adId,
      this.byFirstCategory,
      this.bySecondCategory,
      this.byThirdCategory});

  final CollectionReference _advertisersCollection =
      FirebaseFirestore.instance.collection('advertisers');
  final CollectionReference _advertsCollection =
      FirebaseFirestore.instance.collection('adverts');

  //User Activities
  Future setAdvertiserProfile(
      {required String image,
      required String emailAddress,
      required String companyName,
      required String phoneNumber,
      required String secondaryNumber,
      required String region,
      required String city,
      required String streetName,
      required String websiteLink,
      required String businessType,
      required int numberOfFreeAds,
      required int totalAds}) {
    return _advertisersCollection.doc(uid).set({
      'image': image,
      'email_address': emailAddress,
      'company_name': companyName,
      'phone_number': phoneNumber,
      'secondary_number': secondaryNumber,
      'region': region,
      'city': city,
      'website_link': websiteLink,
      'street_name': streetName,
      'business_type': businessType,
      'number_of_free_ads': numberOfFreeAds,
      'total_ads': totalAds,
    });
  }

  Advertiser _advertiserFromSnapshot(DocumentSnapshot snapshot) {
    return Advertiser(
        id: snapshot.id,
        websiteLink: snapshot.get('website_link'),
        numberOfFreeAds: snapshot.get('number_of_free_ads'),
        city: snapshot.get('city'),
        phoneNumber: snapshot.get('phone_number'),
        emailAddress: snapshot.get('email_address'),
        image: snapshot.get('image'),
        secondaryNumber: snapshot.get('secondary_number'),
        businessType: snapshot.get('business_type'),
        companyName: snapshot.get('company_name'),
        region: snapshot.get('region'),
        streetName: snapshot.get('street_name'),
        totalAds: snapshot.get('total_ads'));
  }

  List<Advertiser> _advertisersFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Advertiser(
          id: doc.id,
          websiteLink: doc.get('website_link'),
          numberOfFreeAds: doc.get('number_of_free_ads'),
          city: doc.get('city'),
          phoneNumber: doc.get('phone_number'),
          businessType: doc.get('business_type'),
          emailAddress: doc.get('email_address'),
          image: doc.get('image'),
          secondaryNumber: doc.get('secondary_number'),
          companyName: doc.get('company_name'),
          region: doc.get('region'),
          streetName: doc.get('street_name'),
          totalAds: doc.get('totalAds'));
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
      required String firstCategory,
      required String secondCategory,
      required String thirdCategory,
      required String condition,
      required String negotiable,
      required double price,
      required String subscription}) {
    return _advertsCollection.add({
      'uid': uid,
      'images': images,
      'title': title,
      'description': description,
      'first_category': firstCategory,
      'second_category': secondCategory,
      'third_category': thirdCategory,
      'condition': condition,
      'negotiable': negotiable,
      'price': price,
      'subscription': subscription,
      'likes': [],
      'posted_date': new DateTime.now(),
      'updated_date': new DateTime.now(),
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
          firstCategory: doc.get('first_category'),
          condition: doc.get('condition'),
          images: doc.get('images'),
          price: doc.get('price'),
          description: doc.get('description'),
          postedAt: doc.get('posted_date'),
          title: doc.get('title'),
          updatedAt: doc.get('updated_date'),
          thirdCategory: doc.get('third_category'),
          negotiable: doc.get('negotiable'),
          likes: doc.get('likes'),
          secondaryCategory: doc.get('second_category'),
          subscription: doc.get('subscription'));
    }).toList();
  }

  Advert _advertFromSnapshot(DocumentSnapshot snapshot) {
    return Advert(
        id: snapshot.id,
        uid: snapshot.get('uid'),
        firstCategory: snapshot.get('first_category'),
        condition: snapshot.get('condition'),
        images: snapshot.get('images'),
        price: snapshot.get('price'),
        description: snapshot.get('description'),
        postedAt: snapshot.get('posted_date'),
        title: snapshot.get('title'),
        updatedAt: snapshot.get('updated_date'),
        thirdCategory: snapshot.get('third_category'),
        negotiable: snapshot.get('negotiable'),
        likes: snapshot.get('likes'),
        secondaryCategory: snapshot.get('secondary_category'),
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

  Stream<List<Advert>> get getFirstCategory {
    return _advertsCollection
        .where('first_category', isEqualTo: byFirstCategory)
        .snapshots()
        .map(_advertsFromSnapshot);
  }

  Stream<List<Advert>> get getSecondCategory {
    return _advertsCollection
        .where('secondary_category', isEqualTo: bySecondCategory)
        .snapshots()
        .map(_advertsFromSnapshot);
  }

  Stream<List<Advert>> get getThirdCategory {
    return _advertsCollection
        .where('third_category', isEqualTo: byThirdCategory)
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
