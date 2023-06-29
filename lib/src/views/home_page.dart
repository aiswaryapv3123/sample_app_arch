import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_app/src/constants/app_constants.dart';
import 'package:sample_app/src/provider/home_provider.dart';
import 'package:sample_app/src/provider/network_provider.dart';
import 'package:sample_app/src/utils/utils.dart';
import 'package:sample_app/src/widgets/vertical_space.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    checkConnectivity(context);
    super.initState();
  }

  checkConnectivity(context) async {
    await Provider.of<NetworkProvider>(context, listen: false).checkInternet();
    var data = Provider.of<NetworkProvider>(context, listen: false);
    if (data.networkStatus == "online") {
      /// api call
      await Provider.of<HomeProvider>(context, listen: false)
          .getProducts(context);
      await Provider.of<HomeProvider>(context, listen: false)
          .getHomeData(context);
    } else {
      await Provider.of<HomeProvider>(context, listen: false)
          .getHomeData(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            padding:
                EdgeInsets.symmetric(horizontal: screenWidth(context) * 0.1),
            child: Consumer<HomeProvider>(builder: (context, data, child) {
              return Column(
                children: [
                  const VerticalSpace(height: 0.02),
                  data.homeLoader == true
                      ? Center(
                          child: SizedBox(
                            width: screenWidth(context) * 0.04,
                            height: screenWidth(context) * 0.04,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation(
                                  AppColors.secondaryColor),
                            ),
                          ),
                        )
                      : data.products == null
                          ? const Text("Products null")
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: data.products?.products?.length,
                              itemBuilder: (BuildContext context, int index) {
                                return data.products!.products!.isEmpty
                                    ? const Text("Products empty")
                                    : Text(
                                        data.products?.products?[index].title ??
                                            "No name");
                              },
                            )
                  // Text(
                  //             "USERNAME : ${data.loginResponseData?.firstName} ${data.loginResponseData?.lastName} \nEmail :${data.loginResponseData?.email} \nGender :${data.loginResponseData?.gender}")
                ],
              );
            })),
      ),
    );
  }
}
