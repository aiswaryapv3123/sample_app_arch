import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:sample_app/src/constants/preference_key_constatnts.dart';
import 'package:sample_app/src/utils/preference_utils.dart';

import '../utils/utils.dart';

Future<Map<String, String>> prepareHeader() async {
  var kAccessToken = PreferenceUtils.getString(accessToken);

  Map<String, String> header = {
    'Content-Type': 'application/json',
    'Authorization': kAccessToken == '' ? '' : 'Bearer $kAccessToken'
  };
  return header;
}

/// fn For calling http post request
///Url and request body is required as param
///Response is returned as result

Future<Response?> postApiRequest(
    BuildContext context, Map requestBody, String url) async {
  var header = await prepareHeader();
  late Response? _response;
  try {
    _response = await post(Uri.parse(url),
        body: jsonEncode(requestBody), headers: header);
    debugPrint('Post url ----> $url \nPost Header ----> ${header.toString()} '
        '\nRequest body ----> $requestBody'
        '\nResponse Code ----> ${_response.statusCode} '
        '\nRequest body ----> ${_response.body.toString()}');
  } on SocketException {
    _response = null;
    showCommonSnackBar(context, "No internet Connection");
  } on FormatException {
    _response = null;
    showCommonSnackBar(context, "Http Format Exception");
  } on HttpException {
    _response = null;
    showCommonSnackBar(context, "Http Exception");
  } catch (e) {
    _response = null;
    showCommonSnackBar(
        context, "Something went wrong! Please try after some time");
  }
  return _response;
}

/// fn For calling http get request
///Url is required as param
///Response is returned as result

Future<Response?> getApiRequest(BuildContext context, url) async {
  var header = await prepareHeader();
  late Response? _response;
  try {
    _response = await get(Uri.parse(url), headers: header);
    debugPrint('Get url ----> $url \nGet Header ----> ${header.toString()} '
        '\nResponse Code ----> ${_response.statusCode} '
        '\nRequest body ----> ${_response.body.toString()}');
  } on SocketException {
    _response = null;
    showCommonSnackBar(context, "No internet Connection");
  } on FormatException {
    _response = null;
    showCommonSnackBar(context, "Format Exception");
  } on HttpException {
    _response = null;
    showCommonSnackBar(context, "Http Exception");
  } catch (e) {
    _response = null;
    showCommonSnackBar(
        context, "Something went wrong! Please try after some time");
  }
  return _response;
}

/// fn For calling http multipart post request
///Url and request body is required as param
///Response is returned as result
///
Future<Response?> multiPartPostRequest(
    BuildContext context, Map<String, String> requestBody, String url) async {
  var header = await prepareHeader();
  var request = MultipartRequest('POST', Uri.parse(url));
  request.fields.addAll(requestBody);
  request.headers.addAll(header);
  late Response? _response;
  try {
    _response = await Response.fromStream(await request.send());
    debugPrint(
        'Multi Post url ----> $url \nMulti Post Header ----> ${header.toString()} '
        '\nMulti Post Payload ----> ${requestBody.toString()} '
        '\nRequest body ----> $requestBody '
        '\nResponse Code ----> ${_response.statusCode} '
        '\nRequest body ----> ${_response.body.toString()}');
  } on SocketException {
    _response = null;
    showCommonSnackBar(context, "No internet Connection");
  } on FormatException {
    _response = null;
    showCommonSnackBar(context, "Format Exception");
  } on HttpException {
    _response = null;
    showCommonSnackBar(context, "Http Exception");
  } catch (e) {
    _response = null;
    showCommonSnackBar(
        context, "Something went wrong! Please try after some time");
  }
  return _response;
}
