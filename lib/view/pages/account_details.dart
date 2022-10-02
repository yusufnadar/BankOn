import 'package:bank_on/utils/extension/padding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/const/app.dart';
import '../../core/const/colors.dart';
import '../../data/controllers/banks_controller.dart';
import '../../data/models/transactions_model.dart';
import '../widgets/action_button.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_input.dart';
import '../widgets/detail_item.dart';

class AccountDetailsController extends GetxController {
  RxInt result = 1.obs;
  RxInt _groupValue = 1.obs;

  int get groupValue => _groupValue.value;

  set groupValue(int groupValue) => _groupValue.value = groupValue;

  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();

  var id;
  var name;
  var amount;
  var transactionId;

  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final descriptionController = TextEditingController();

  final editNameController = TextEditingController();
  final editAmountController = TextEditingController();
}

class AccountDetails extends GetWidget<AccountDetailsController> {
  const AccountDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
        actions: buildPopups(),
      ),
      body: GetX<BanksController>(
        init: BanksController(),
        initState: (func) {
          func.controller?.getTransactions(Get.arguments['id']);
          controller.id = Get.arguments['id'];
          controller.editNameController.text = Get.arguments['name'];
          controller.editAmountController.text =
              Get.arguments['amount'].toString();
        },
        builder: (controller2) => ListView.builder(
          padding: EdgeInsets.only(top: Get.height * 0.01),
          itemCount: controller2.transactions.length,
          itemBuilder: (context, index) => DetailItem(
            transaction: controller2.transactions[index],
            deleteTap: () {
              areYouSure(controller2.transactions[index], type: 'detail');
            },
            editTap: ()async{
              controller.titleController.text = controller2.transactions[index].title;
              controller.transactionId = controller2.transactions[index].id;
              controller.amountController.text = controller2.transactions[index].amount.toString();
              controller.descriptionController.text = controller2.transactions[index].description;
              controller.groupValue = controller2.transactions[index].is_income;
              buildShowModalBottomSheet(type: 'add');
            },
          ).customHorizontal(),
        ),
      ),
    );
  }

  List<Widget> buildPopups() {
    return [
      PopupMenuButton(
        onSelected: (value) {
          switch (value) {
            case 1:
              controller.amountController.text = '';
              controller.titleController.text = '';
              controller.descriptionController.text = '';
              controller.groupValue = 0;
              buildShowModalBottomSheet();
              break;
            case 2:
              buildShowModalBottomSheet(type: 'edit');
              break;
            case 3:
              areYouSure(null);
              break;
          }
        },
        itemBuilder: (context) => [
          PopupMenuItem(
            child: Text('Add Transaction'),
            value: 1,
          ),
          PopupMenuItem(
            child: Text('Update Bank Name'),
            value: 2,
          ),
          PopupMenuItem(
            child: Text('Delete Bank'),
            value: 3,
          ),
        ],
      ),
    ];
  }

  void areYouSure(TransactionsModel? item, {type}) {
    var id2 = Get.arguments['id'];
    Get.dialog(
      AlertDialog(
        title: Text('Are you sure want to delete?'),
        actions: [
          ActionButton(
            text: 'Go Back',
            boxColor: AppColors.greyColor,
            onTap: () => Get.back(),
          ),
          ActionButton(
              text: 'Delete',
              onTap: () async {
                if (type == 'detail') {
                  Get.put(BanksController()).deleteTransaction(
                    item!.id,
                    id2,
                    controller.editNameController.text,
                    item.amount,
                  );
                } else {
                  await Get.put(BanksController()).deleteBank(id2);
                  Get.back();
                }
                Get.back();
              })
        ],
      ),
    );
  }

  Future<dynamic> buildShowModalBottomSheet({type}) {
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
        child: type == 'edit' ? buildUpdateName() : buildAddItem(type),
      ),
    );
  }

  SingleChildScrollView buildAddItem(type) {
    return SingleChildScrollView(
      child: Form(
        key: controller.formKey2,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomInput(
              hintText: 'Transaction Name',
              controller: controller.titleController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'You can not leave this field blank';
                }
                return null;
              },
            ),
            CustomInput(
              hintText: 'Transaction Amount',
              controller: controller.amountController,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'You can not leave this field blank';
                }
                return null;
              },
            ),
            CustomInput(
              hintText: 'Description',
              controller: controller.descriptionController,
              maxLines: 4,
            ),
            Container(
              width: Get.width,
              child: GetX<AccountDetailsController>(
                builder: (controller) => Row(
                  children: [
                    Expanded(
                      child: RadioListTile<int>(
                        value: 0,
                        groupValue: controller.groupValue,
                        onChanged: (value) {
                          controller.groupValue = value!;
                        },
                        title: Text('Income'),
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<int>(
                        value: 1,
                        groupValue: controller.groupValue,
                        onChanged: (value) {
                          controller.groupValue = value!;
                        },
                        title: Text('Expense'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            CustomButton(
              text: type == 'add' ? 'Update' : 'Add',
              onTap: () {
                if(controller.formKey2.currentState!.validate()){
                  controller.formKey2.currentState!.save();
                  if (type == 'add') {
                    Get.put(BanksController()).updateTransaction(
                      controller.id,
                      controller.transactionId,
                      controller.titleController.text,
                      controller.amountController.text,
                      controller.descriptionController.text,
                      controller.groupValue,
                    );
                  } else {
                    Get.put(BanksController()).addTransaction(
                      controller.id,
                      controller.titleController.text,
                      controller.amountController.text,
                      controller.descriptionController.text,
                      controller.groupValue,
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView buildUpdateName() {
    return SingleChildScrollView(
      child: Form(
        key: controller.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomInput(
              hintText: 'Bank Account Name',
              controller: controller.editNameController,
              validator: (value){
                if(value!.isEmpty){
                  return 'You can not leave this field blank';
                }return null;
              },
            ),
            CustomButton(
              text: 'Güncelle',
              onTap: (){
                if(controller.formKey.currentState!.validate()){
                  controller.formKey.currentState!.save();
                  Get.put(BanksController()).updateBank(
                    controller.id,
                    controller.editNameController.text,
                  );
                }
              }
            ),
          ],
        ),
      ),
    );
  }
}
