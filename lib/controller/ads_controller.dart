import 'package:get/get.dart';
import 'package:sudoku/model/get_ads_model.dart';
import 'package:sudoku/model/pop_up_ad_model.dart' as popUp;
import 'package:sudoku/repo/get_ads_repo.dart';

class AdsController extends GetxController {
  GetAdRepo getAdRepo;
  AdsController({required this.getAdRepo});
  String uid = "";

  String coins = "";
  List<Map<String, dynamic>> userItems = [];

  bool isSubmitLoading = false;
  String? photoUrl = "";
  String? redirectUrl = "";
  String? popUpPhotoUrl = "";
  String? popUpredirectUrl = "";
  void getAd() async {
    isSubmitLoading = true;
    update();

    GetAds? ads = await getAdRepo.getads("970x250");
    // GetAds? ads = await getAdRepo.getads("320x50");
    // GetAds? ads = await getAdRepo.getads("320x100");
    // GetAds? ads = await getAdRepo.getads("300x250");
    //  GetAds? ads1 = await getAdRepo.getads("468x60");

    if (ads != null) {
      photoUrl = ads.photo;
      redirectUrl = ads.redUrl;

      if (photoUrl != null) {
      } else {
        // CustomSnackBar.error(errorList: [MyStrings.loginFailedTryAgain.tr]);
      }
    }

    isSubmitLoading = false;
    update();
  }

  void getPopUpAd() async {
    isSubmitLoading = true;
    update();

    //  GetAds? ads = await getAdRepo.getads("970x250");
    // GetAds? ads = await getAdRepo.getads("320x50");
    // GetAds? ads = await getAdRepo.getads("320x100");
    // GetAds? ads = await getAdRepo.getads("300x250");
    popUp.PopUpAd? ads1 = (await getAdRepo.getPopAds("300x600")) as popUp.PopUpAd?;

    if (ads1 != null) {
      popUpPhotoUrl = ads1.photos;
      popUpredirectUrl = ads1.redUrls;
      print("thsdocnsdcksdnmcvpksdnmcvpkds=========="+popUpPhotoUrl.toString());
      if (popUpPhotoUrl != null) {
      } else {
        // CustomSnackBar.error(errorList: [MyStrings.loginFailedTryAgain.tr]);
      }
    }

    isSubmitLoading = false;
    update();
  }
}
