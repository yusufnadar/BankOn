import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/conts/colors.dart';
import '../../core/conts/fonts.dart';

class ActionButton extends StatelessWidget {
  final String text;
  final Color? boxColor;
  final Function()? onTap;
  const ActionButton({Key? key, required this.text, this.boxColor, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return                     GestureDetector(
      onTap: onTap,
      child: Container(
        width: Get.width * 0.2,
        height: Get.height * 0.05,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: boxColor ?? AppColors.redColor,
        ),
        child: Text(
          text,
          style: Fonts.boldTextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
