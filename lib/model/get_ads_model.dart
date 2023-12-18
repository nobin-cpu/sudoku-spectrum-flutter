class GetAds {
  String? redUrl;
  String? photo;

  GetAds({
    this.redUrl,
    this.photo,
  });

  // Add a factory method to convert JSON to GetAds object
  factory GetAds.fromJson(Map<String, dynamic> json) {
    return GetAds(
      redUrl: json['redUrl'],
      photo: json['photo'],
    );
  }
}
