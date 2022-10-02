import 'package:auto_size_text/auto_size_text.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../core/const/colors.dart';
import '../../core/const/fonts.dart';
import '../../core/const/icons.dart';
import '../../data/models/transactions_model.dart';

class DetailItem extends StatelessWidget {
  final Function()? deleteTap;
  final Function()? editTap;
  final TransactionsModel? transaction;

  const DetailItem({Key? key, this.deleteTap, this.editTap, this.transaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 0),
            color: Colors.grey,
            blurRadius: 1,
            spreadRadius: 1,
          )
        ],
      ),
      margin: EdgeInsets.only(bottom: Get.height * 0.04),
      padding: EdgeInsets.symmetric(
        horizontal: Get.width * 0.04,
        vertical: Get.height * 0.02,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: Get.width * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    transaction?.title ?? '',
                    maxLines: 1,
                    style: Fonts.boldTextStyle(fontSize: 16),
                    minFontSize: 14,
                    maxFontSize: 16,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: Get.height * 0.009,
                      bottom: Get.height * 0.022,
                    ),
                    child: AutoSizeText(
                      '${double.parse(transaction!.amount.toString()).toStringAsFixed(2)} TL',
                      maxLines: 1,
                      style: Fonts.boldTextStyle(
                        fontSize: 15,
                        letterSpacing: 1.5,
                        color: transaction?.is_income == 0
                            ? AppColors.greenColor
                            : AppColors.redColor,
                        fontWeight: FontWeight.w900,
                      ),
                      minFontSize: 13,
                      maxFontSize: 15,
                    ),
                  ),
                  AutoSizeText(
                    '${transaction?.description}',
                    maxLines: 2,
                    style: Fonts.boldTextStyle(
                      color: AppColors.greyColor,
                      fontSize: 14
                    ),
                    minFontSize: 12,
                    maxFontSize: 14,
                  ),
                ],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: deleteTap,
                child: Image.asset(
                  AppIcons.delete,
                  color: AppColors.redColor,
                  width: 20,
                ),
              ),
              SizedBox(height: Get.height * 0.015),
              GestureDetector(
                onTap: editTap,
                child: Image.asset(
                  AppIcons.edit,
                  color: AppColors.greenColor,
                  width: 20,
                ),
              ),
              SizedBox(height: Get.height * 0.015),
              Text(
                DateFormat.yMMMd('tr').format(
                  DateTime.parse(transaction!.createdAt),
                ) + '\n' + DateFormat.Hm('tr').format(
                  DateTime.parse(transaction!.createdAt),
                ),
                textAlign: TextAlign.end,
              ),
            ],
          )
        ],
      ),
    );
  }
}
