import 'dart:convert';

import 'package:sudoku/api/api_client.dart';
import 'package:sudoku/model/get_ads_model.dart';
import 'package:sudoku/model/pop_up_ad_model.dart';
import 'package:sudoku/model/response_model.dart';
import 'package:sudoku/util/method.dart';
import 'package:sudoku/util/url_container.dart';
import 'package:sudoku/widgets/pop_up_ads.dart';

class GetAdRepo {
  ApiClient apiClient;

  GetAdRepo({required this.apiClient});

  Future<GetAds?> getads(String size) async {
    Map<String, String> map = {'size': size};
    String url = '${UrlContainer.baseUrl}${UrlContainer.getads}';

    ResponseModel model = await apiClient.request(url, Method.postMethod, map, passHeader: false);

    if (model.statusCode == 200) {
      GetAds? ads = GetAds.fromJson(jsonDecode(model.responseJson));
      return ads;
    } else {
      // CustomSnackBar.error(errorList: [model.message]);
      return null;
    }
  }

  Future<PopUpAd?> getPopAds(String size) async {
    Map<String, String> map = {'size': size};
    String url = '${UrlContainer.baseUrl}${UrlContainer.getads}';
    
    ResponseModel model = await apiClient.request(url, Method.postMethod, map, passHeader: false);

    if (model.statusCode == 200) {
      PopUpAd? popUpads = PopUpAd.fromJson(jsonDecode(model.responseJson));
      return popUpads;
    } else {
      // CustomSnackBar.error(errorList: [model.message]);
      return null;
    }
  }
}
