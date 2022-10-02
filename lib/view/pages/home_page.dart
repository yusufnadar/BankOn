import 'package:control_bank_accounts/core/conts/app.dart';
import 'package:control_bank_accounts/core/conts/colors.dart';
import 'package:control_bank_accounts/core/conts/icons.dart';
import 'package:control_bank_accounts/core/conts/routing/pages.dart';
import 'package:control_bank_accounts/data/controllers/banks_controller.dart';
import 'package:control_bank_accounts/utils/extension/padding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_input.dart';
import '../widgets/custom_item.dart';



class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: GetX<BanksController>(
        init: BanksController(),
        initState: (func) {
          func.controller?.getBanks();
        },
        builder: (controller2) => SizedBox(
          height: Get.height,
          width: Get.width,
          child: Stack(
            children: [
              ListView.builder(
                padding: EdgeInsets.only(
                  top: Get.height * 0.086,
                  bottom: Get.height * 0.013,
                ),
                itemCount: controller2.banks.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return CustomItem(
                    text1: controller2.banks[index].name ?? '',
                    text2: double.parse(controller2.banks[index].amount!.toString()).toStringAsFixed(2),
                    onTap: () => Get.toNamed(Pages.accountDetails, arguments: {
                      'id': controller2.banks[index].id,
                      'name': controller2.banks[index].name,
                      'amount': controller2.banks[index].amount,
                    }),
                  );
                },
              ).customHorizontal(),
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: Container(
                  width: Get.width,
                  color: AppColors.white,
                  child: CustomItem(
                    text1: 'Total Amount',
                    text2: controller2.amounts.value.toStringAsFixed(2),
                    boxColor: AppColors.subColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text('BankOn'),
      toolbarHeight: Get.height * 0.1,
      titleSpacing: Get.width * 0.045,
      actions: [
        GestureDetector(
          onTap: () => buildShowModalBottomSheet(),
          child: buildAddIcon(),
        )
      ],
    );
  }

  Container buildAddIcon() {
    return Container(
      margin: EdgeInsets.only(right: App.horizontal),
      child: Image.asset(
        AppIcons.add,
        width: Get.width * 0.07,
      ),
    );
  }

  Future<dynamic> buildShowModalBottomSheet() {
    TextEditingController nameController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          left: App.horizontal,
          right: App.horizontal,
          top: App.vertical,
          bottom: App.vertical + MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomInput(
                hintText: 'Bank Account Name',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'You can not leave this field blank';
                  }
                  return null;
                },
                controller: nameController,
              ),
              CustomButton(
                  text: 'Save',
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      Get.put(BanksController())
                          .addBank(
                            nameController.text,
                          )
                          .then((value) => Get.back());
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
