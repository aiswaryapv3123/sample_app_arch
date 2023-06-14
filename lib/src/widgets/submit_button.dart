import 'package:flutter/material.dart';
import 'package:sample_app/src/constants/app_constants.dart';
import 'package:sample_app/src/utils/utils.dart';

class SubmitButton extends StatefulWidget {
  final String label;
  final Function onTap;
  final bool loading;
  const SubmitButton(
      {Key? key,
      required this.label,
      required this.onTap,
      this.loading = false})
      : super(key: key);

  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (){
          widget.onTap();
        },
        child: Container(
          width: screenWidth(context) * 0.8,
        padding: EdgeInsets.symmetric(vertical: screenHeight(context) * 0.015),
          decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(8)
          ),
          child: Center(
            child: widget.loading
                ? SizedBox(
                    width: screenWidth(context) * 0.04,
                    height: screenWidth(context) * 0.04,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation(AppColors.primary),
                    ),
                  )
                : Text(widget.label),
          ),
        ));
  }
}
