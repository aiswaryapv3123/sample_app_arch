import 'package:hive/hive.dart';

part 'login_model.g.dart';

@HiveType(typeId:0)
class LoginModel extends HiveObject {
  @HiveField(0)
  final String data;
  LoginModel({
    required this.data
});
}