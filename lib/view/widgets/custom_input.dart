import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CustomInput extends StatelessWidget {
  final String? hintText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final int? maxLines;
  final String? Function(String?)? validator;

  const CustomInput({Key? key, this.hintText, required this.controller,this.keyboardType, this.maxLines, this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
//      height: Get.height * 0.07,
      margin: EdgeInsets.only(bottom: Get.height * 0.02),
      child: TextFormField(
        keyboardType: keyboardType,
        inputFormatters: keyboardType != null ? [

            // for below version 2 use this
            //FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
// for version 2 and greater youcan also use this
          FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))

        ] : [],
        maxLines: maxLines,
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          hintText: hintText,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
