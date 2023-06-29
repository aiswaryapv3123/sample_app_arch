import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart';
import 'package:sample_app/src/constants/hive_constants.dart';
import 'package:sample_app/src/db/database.dart';
import 'package:sample_app/src/models/products_model.dart';
import 'package:sample_app/src/service/api_constants.dart';
import 'package:sample_app/src/service/api_services.dart';
import 'package:sample_app/src/utils/utils.dart';

class HomeProvider extends ChangeNotifier {
  ProductsModel? products;
  bool homeLoader = false;
  Box? homeDataBox;

  getProducts(context) async {
    try {
      updateHomeLoader(true);
      Response? _response = await getApiRequest(context, ApiUrls.products);

      /// check whether response null, request returns null only if there are any http errors
      if (_response == null) {
        updateHomeLoader(false);
        debugPrint("Response null");
      } else {
        var status;

        /// checking api errors by passing status code to handleApiError method
        status = handleApiError(context, _response.statusCode);
        if (status) {

          homeDataBox = await HiveDataBase().openHiveBox(homeData);
          await HiveDataBase().addHiveData(
              boxName: homeDataBox, key: homeData, data: _response.body);
          updateHomeLoader(false);
        } else {
          updateHomeLoader(false);
        }
      }
    } catch (e) {
      debugPrint("Home Error $e");
    }
  }

  getHomeData(context) async {
    try {
      updateHomeLoader(true);
      String hiveHomeData = HiveDataBase().getHiveData(homeDataBox);

      /// conversion of response data into corresponding response model
      products = ProductsModel.fromJson((json.decode(hiveHomeData)));
      debugPrint(
          "Home Data from hive \n------------------------------------------------\n$products");
      updateHomeLoader(false);
    } catch (e) {
      debugPrint("Home Provider Error $e");
    }
  }

  updateHomeLoader(bool value) {
    homeLoader = value;
    notifyListeners();
  }
}



