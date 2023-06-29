import 'dart:io';

import 'package:flutter/material.dart';

class NetworkProvider extends ChangeNotifier {
  // bool isOnline = true;
  String? networkStatus;

  Future<String?> checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        networkStatus = "online";
      } else {
        networkStatus = "offline";
      }
    } on SocketException catch (_) {
      networkStatus = "offline";
    }
    notifyListeners();
    return networkStatus;
  }
}





