class Advertiser {
  final String id;
  final String image;
  final String name;
  final String email;
  final String number;
  final String anotherNumber;
  final String city;
  final String region;
  final String website;
  final String type;
  final String streetName;
  final int free;

  Advertiser(
      {required this.id,
      required this.website,
      required this.free,
      required this.city,
      required this.number,
      required this.type,
      required this.email,
      required this.image,
      required this.anotherNumber,
      required this.name,
      required this.region,
      required this.streetName});
}
