import 'package:hive/hive.dart';

class HiveDataBase {
  Future<Box> openHiveBox(String boxName) async {
    return await Hive.openBox(boxName);
  }

  Future<void> addHiveData({Box? boxName, required String key, required String data}) async {
    await boxName?.put(key, data);
  }

   String getHiveData(Box? boxName) {
    String? data = boxName?.values.first;
    return data ?? "No Data or Null";
  }
}
