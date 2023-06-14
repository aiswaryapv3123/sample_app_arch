import 'package:flutter/material.dart';
import 'package:sample_app/src/constants/app_constants.dart';
import 'package:sample_app/src/constants/text_styles.dart';
import 'package:sample_app/src/utils/utils.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController textEditingController;
  final String label;
  const PasswordField(
      {Key? key, required this.textEditingController, required this.label})
      : super(key: key);

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool visibility = true;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight(context) * 0.05,
      child: TextFormField(
        controller: widget.textEditingController,
        obscureText: visibility ? false : true,
        style: AppFontStyles().textFieldText,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.textFieldBorder,
                ),
                borderRadius: BorderRadius.circular(4)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.secondaryColor,
                ),
                borderRadius: BorderRadius.circular(4)),
            labelText: widget.label,
            labelStyle: AppFontStyles().textFieldText,
            hintText: 'username',
            hintStyle: AppFontStyles().textFieldHintText,
            suffix: GestureDetector(
              onTap: () {
                setState(() {
                  visibility = !visibility;
                });
              },
              child: Icon(
                visibility ? Icons.visibility : Icons.visibility_off,
                color: AppColors.secondaryColor,
              ),
            )),
      ),
    );
  }
}
