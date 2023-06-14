import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_app/src/provider/login_provider.dart';
import 'package:sample_app/src/utils/utils.dart';
import 'package:sample_app/src/widgets/password_field.dart';
import 'package:sample_app/src/widgets/submit_button.dart';
import 'package:sample_app/src/widgets/user_textfield.dart';
import 'package:sample_app/src/widgets/vertical_space.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // var data = Provider.of<LoginProvider>(context, listen: false);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth(context) * 0.1),
        child: Consumer<LoginProvider>(builder: (context, data, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Login"),
              const VerticalSpace(height: 0.02),
              UserTextField(
                  textEditingController: userNameController, label: "UserName"),
              const VerticalSpace(height: 0.02),
              PasswordField(
                  textEditingController: passwordController, label: "Password"),
              const VerticalSpace(height: 0.02),
              SubmitButton(
                label: "LOGIN",
                loading: data.loginLoader,
                onTap: () async {
                  await data.login(context, userNameController.text,
                      passwordController.text);
                  userNameController.clear();
                  passwordController.clear();
                },
              ),
              const VerticalSpace(height: 0.02),
              data.loginResponseData == null
                  ? Container()
                  : Text(
                      "USERNAME : ${data.loginResponseData?.firstName} ${data.loginResponseData?.lastName} \nEmail :${data.loginResponseData?.email} \nGender :${data.loginResponseData?.gender}")
            ],
          );
        }),
      ),
    );
  }
}
