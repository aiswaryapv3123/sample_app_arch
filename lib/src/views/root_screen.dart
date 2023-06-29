import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_app/src/constants/app_constants.dart';
import 'package:sample_app/src/provider/network_provider.dart';
import 'package:sample_app/src/utils/utils.dart';
import 'package:sample_app/src/views/home_page.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _selectedIndex = 0;
  NetworkProvider? networkStatus;

  List<Widget> pages = [const HomePage(), const SettingsPage()];

  @override
  void initState() {
    Provider.of<NetworkProvider>(context, listen: false).checkInternet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    networkStatus = Provider.of<NetworkProvider>(context, listen: true);
    networkStatus?.checkInternet();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
          screenWidth(context),
          screenHeight(context) * 0.09,
        ),
        child: Consumer<NetworkProvider>(
          builder: (context, data, child) {
            return data.networkStatus == "offline"
                ? Container(
                    width: screenWidth(context),
                    height: screenHeight(context) * 0.09,
                    color: AppColors.errorRed,
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: screenHeight(context) * 0.03),
                    child: const Text(
                      "No internet",
                    ),
                  )
                : Container();
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex, //New
        onTap: _onItemTapped,
      ),
      body: pages[_selectedIndex],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Settings Page"),
      ),
    );
  }
}


