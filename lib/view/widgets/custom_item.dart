import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/conts/colors.dart';
import '../../core/conts/fonts.dart';

class CustomItem extends StatelessWidget {
  final String text1;
  final String text2;
  final Color? boxColor;
  final Function()? onTap;

  const CustomItem(
      {Key? key, required this.text1, required this.text2, this.boxColor, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: boxColor == null ? Get.height * 0.013 : 0,
        ),
        height: Get.height*0.073,
        padding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.04,
          //vertical: Get.height * 0.025,
        ),
        decoration: BoxDecoration(
          color: boxColor ?? AppColors.primaryColor,
          borderRadius: BorderRadius.circular(boxColor  == null ? 12 : 0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 2,
              child: AutoSizeText(
                text1,
                style: Fonts.boldTextStyle(color: AppColors.white, fontSize: 16),
                maxLines: 2,
                maxFontSize: 16,
                minFontSize: 12,
              ),
            ),
            SizedBox(width: Get.width*0.01),
            Flexible(
              flex: 1,
              child: AutoSizeText(
                '$text2 TL',
                style: Fonts.semiBoldTextStyle(
                  color: boxColor != null ? AppColors.primaryColor : AppColors.white,
                  letterSpacing: 1.5,
                  fontSize: 15,
                ),
                maxLines: 1,
                maxFontSize: 15,
                minFontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
