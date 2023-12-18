import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sudoku/model/authorization_response_model.dart';
import 'package:sudoku/model/response_model.dart';
import 'package:sudoku/util/method.dart';
import 'package:sudoku/util/share_preference_helper.dart';


class ApiClient extends GetxService {
  SharedPreferences sharedPreferences;
  ApiClient({required this.sharedPreferences});

  Future<ResponseModel> request(
    String uri,
    String method,
    Map<String, dynamic>? params, {
    bool passHeader = false,
    bool isOnlyAcceptType = false,
  }) async {
    Uri url = Uri.parse(uri);
    http.Response response;

    try {
      if (method == Method.postMethod) {
        if (passHeader) {
          initToken();
          if (isOnlyAcceptType) {
            response = await http.post(url, body: params, headers: {
              "Accept": "application/json",
            });
          } else {
            response = await http.post(url, body: params, headers: {"Accept": "application/json", "Authorization": "$tokenType $token"});
          }
        } else {
          response = await http.post(url, body: params);
        }
      } else if (method == Method.updateMethod) {
        if (passHeader) {
          initToken();

          response = await http.post(url, body: params, headers: {"Accept": "application/json", "Authorization": "$tokenType $token"});
        } else {
          response = await http.post(url, body: params);
        }
      } else if (method == Method.deleteMethod) {
        response = await http.delete(url);
      } else if (method == Method.updateMethod) {
        response = await http.patch(url);
      } else {
        if (passHeader) {
          initToken();

          response = await http.get(url, headers: {"Accept": "application/json", "Authorization": "$tokenType $token"});
          if (response.body.isEmpty) {
            response = await http.get(url, headers: {"Authorization": "$tokenType $token"});
          }
        } else {
          response = await http.get(
            url,
          );
        }
      }

      debugPrint('url--------------${uri.toString()}');
      debugPrint('params-----------${params.toString()}');
      debugPrint('status-----------${response.statusCode}');
      debugPrint('body-------------${response.body.toString()}');
      debugPrint('token------------$token');

      if (response.statusCode == 200) {
        try {
          AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(response.body));
          
        } catch (e) {
          return ResponseModel(false, 'error', 404, "{}");
        }

        return ResponseModel(true, 'success', 200, response.body);
      } else if (response.statusCode == 401) {
      
        
        return ResponseModel(false, "unAuthorized", 401, response.body);
      } else if (response.statusCode == 500) {
        return ResponseModel(false, "serverError", 500, response.body);
      } else {
        return ResponseModel(false, "somethingWentWrong", 499, response.body);
      }
    } on SocketException {
      return ResponseModel(false, "noInternet", 503, '');
    } on FormatException {
      return ResponseModel(false, "badResponseMsg", 400, '');
    } catch (e) {
      return ResponseModel(false, "somethingWentWrong", 499, '');
    }
  }

  String token = '';
  String tokenType = '';

  initToken() {
    if (sharedPreferences.containsKey(SharedPreferenceHelper.accessTokenKey)) {
      String? t = sharedPreferences.getString(SharedPreferenceHelper.accessTokenKey);
      String? tType = sharedPreferences.getString(SharedPreferenceHelper.accessTokenType);
      token = t ?? '';
      tokenType = tType ?? 'Bearer';
    } else {
      token = '';
      tokenType = 'Bearer';
    }
  }

  

  }













