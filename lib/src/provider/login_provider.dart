import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:sample_app/src/constants/hive_constants.dart';
import 'package:sample_app/src/db/database.dart';
import 'package:sample_app/src/models/login_response_model.dart';
import 'package:sample_app/src/service/api_constants.dart';
import 'package:sample_app/src/service/api_services.dart';
import 'package:sample_app/src/utils/utils.dart';

class LoginProvider extends ChangeNotifier {
  bool loginLoader = false;
  LoginResponseModel? loginResponseData;
  Box? loginBox;

  Future<String> login(context, username, password) async {
    updateLoader(true);
    var requestBody = {"username": username, "password": password};
    Response? _response =
        await postApiRequest(context, requestBody, ApiUrls.loginUrl);

    /// check whether response null, request returns null only if there are any http errors
    if (_response == null) {
      updateLoader(false);
      debugPrint("Response null");
    } else {
      var status;

      /// checking api errors by passing status code to handleApiError method
      status = handleApiError(context, _response.statusCode);
      if (status) {
        loginBox = await HiveDataBase().openHiveBox(loginData);
        await HiveDataBase().addHiveData(
            boxName: loginBox, key: loginData, data: _response.body);

        String hiveData = HiveDataBase().getHiveData(loginBox);

        /// conversion of response data into corresponding response model
        loginResponseData = LoginResponseModel.fromJson(json.decode(hiveData));
        debugPrint("Login response Data $loginResponseData");
        updateLoader(false);
        showSuccessSnackBar(context, "Login Successful");
      } else {
        updateLoader(false);
      }
    }
    return "";
  }

  updateLoader(value) {
    loginLoader = value;
    notifyListeners();
  }
}
