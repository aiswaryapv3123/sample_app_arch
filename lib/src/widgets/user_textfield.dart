import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample_app/src/constants/app_constants.dart';
import 'package:sample_app/src/constants/text_styles.dart';
import 'package:sample_app/src/utils/utils.dart';

class UserTextField extends StatefulWidget {
  final TextEditingController textEditingController;
  final String label;
  const UserTextField(
      {Key? key, required this.textEditingController, required this.label})
      : super(key: key);

  @override
  State<UserTextField> createState() => _UserTextFieldState();
}

class _UserTextFieldState extends State<UserTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight(context) * 0.05,
      child: TextField(
          controller: widget.textEditingController,
          style: AppFontStyles().textFieldText,
          decoration: InputDecoration(
            labelText: widget.label,
            labelStyle: AppFontStyles().textFieldText,
            hintText: 'password',
            hintStyle: AppFontStyles().textFieldHintText,
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
          )),
    );
  }
}
