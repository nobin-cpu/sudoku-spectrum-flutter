import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudoku/api/api_client.dart';
import 'package:sudoku/controller/ads_controller.dart';
import 'package:sudoku/repo/get_ads_repo.dart';
import 'package:url_launcher/url_launcher.dart';

class BannerAds extends StatefulWidget {
  const BannerAds({Key? key}) : super(key: key);

  @override
  State<BannerAds> createState() => _BannerAdsState();
}

class _BannerAdsState extends State<BannerAds> {
  @override
  void initState() {
   
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(GetAdRepo(apiClient: Get.find()));
    AdsController adsController = Get.put(AdsController(getAdRepo: Get.find()));
    adsController.getAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdsController>(
      builder: (adsController) => Align(
        alignment: Alignment.topCenter,
        child: InkWell(
          onTap: () {
            launchUrl(Uri.parse(adsController.redirectUrl.toString()));
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.network(
                  adsController.photoUrl!,
                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.pink,
                          value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1) : null,
                        ),
                      );
                    }
                  },
                  errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                    return const Center(
                      child: Icon(
                        Icons.error_outline,
                        color: Colors.pink,
                        size: 40,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
