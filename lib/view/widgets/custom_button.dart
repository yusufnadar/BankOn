import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/const/colors.dart';
import '../../core/const/fonts.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function()? onTap;

  const CustomButton({Key? key, required this.text, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: Get.width,
        height: Get.height * 0.07,
        decoration: BoxDecoration(
          color: AppColors.subColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          text,
          style: Fonts.mediumTextStyle(
            color: AppColors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
