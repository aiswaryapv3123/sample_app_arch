import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sample_app/src/provider/login_provider.dart';

class MultiProviderList {
  static List<SingleChildWidget> providerList = [
    ChangeNotifierProvider(create: (_) => LoginProvider()),
  ];
}
