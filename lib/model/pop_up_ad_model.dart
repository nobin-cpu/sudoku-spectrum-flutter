class PopUpAd {
  String? redUrls;
  String? photos;

  PopUpAd({
    this.redUrls,
    this.photos,
  });

  // Add a factory method to convert JSON to GetAds object
  factory PopUpAd.fromJson(Map<String, dynamic> json) {
    return PopUpAd(
      redUrls: json['redUrl'],
      photos: json['photo'],
    );
  }
}
