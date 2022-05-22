class Advertiser {
  final String id;
  final String image;
  final String companyName;
  final String emailAddress;
  final String phoneNumber;
  final String secondaryNumber;
  final String city;
  final String region;
  final String websiteLink;
  final String businessType;
  final String streetName;
  final int numberOfFreeAds;
  final int totalAds;

  Advertiser(
      {required this.id,
      required this.websiteLink,
      required this.numberOfFreeAds,
      required this.city,
      required this.phoneNumber,
      required this.businessType,
      required this.emailAddress,
      required this.image,
      required this.secondaryNumber,
      required this.companyName,
      required this.region,
      required this.streetName,
      required this.totalAds});
}
