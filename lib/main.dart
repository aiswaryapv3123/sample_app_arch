import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_app/src/provider/multiprovider_list.dart';
import 'package:sample_app/src/views/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: MultiProviderList.providerList,
      child: const MaterialApp(
        title: 'Flutter Demo',
        home: LoginPage(),
      ),
    );
  }
}
