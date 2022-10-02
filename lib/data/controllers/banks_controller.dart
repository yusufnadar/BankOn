import 'package:control_bank_accounts/core/init/database_helper_service.dart';
import 'package:control_bank_accounts/core/init/locator_service.dart';
import 'package:control_bank_accounts/data/models/banks_model.dart';
import 'package:control_bank_accounts/data/models/transactions_model.dart';
import 'package:get/get.dart';

class BanksController extends GetxController {
  final _banks = <BanksModel>[].obs;

  List<BanksModel> get banks => _banks;

  set banks(List<BanksModel> banks) => _banks.value = banks;

  final _transactions = <TransactionsModel>[].obs;

  List<TransactionsModel> get transactions => _transactions;

  set transactions(List<TransactionsModel> transactions) =>
      _transactions.value = transactions;

  var amounts = 0.0.obs;

  final databaseHelperService = Locator.getIt.get<DatabaseHelperService>();

  Future getBanks() async {
    try {
      var responses2 = await databaseHelperService.getTransactionsAll();
      List<TransactionsModel> transactions2 = List<TransactionsModel>.from(
        responses2.map((e) => TransactionsModel.fromJson(e)),
      );
      List<dynamic> responses = await databaseHelperService.getBanks();
      banks = List<BanksModel>.from(
        responses.map(
          (e) => BanksModel.fromJson(e),
        ),
      );
      amounts.value = 0;
      for (var item2 in transactions2) {
        for (var item in banks) {
          if (item2.bank_id == item.id) {
            if(item2.is_income == 0 ){
              item.amount = item.amount! + item2.amount!;
              amounts.value = amounts.value + item2.amount!;
            }else{
              item.amount = item.amount! - item2.amount!;
              amounts.value = amounts.value - item2.amount!;
            }
          }
        }
      }
    } catch (error) {
      print('getBanks $error');
    }
  }

  Future addBank(name) async {
    try {
      await databaseHelperService.addBank(name);
      getBanks();
      _banks.refresh();
    } catch (error) {
      print('addbank error $error');
    }
  }

  Future deleteBank(id) async {
    try {
      await databaseHelperService.deleteBank(id);
      getBanks();
    } catch (error) {
      print('deleteBank error $error');
    }
  }

  Future updateBank(id, name) async {
    try {
      await databaseHelperService.updateBank(id, name);
      await getBanks();
      _banks.refresh();
      Get.back();
      Get.back();
    } catch (error) {
      print('updateBank error $error');
    }
  }

  Future getTransactions(id) async {
    try {
      transactions = [];
      List<dynamic> responses = await databaseHelperService.getTransactions(id);
      transactions = List<TransactionsModel>.from(
        responses.map((e) => TransactionsModel.fromJson(e)),
      );
      _transactions.refresh();
      update();
    } catch (error) {
      print('getTransactions $error');
    }
  }

  Future addTransaction(id, title, amount, description, is_income) async {
    try {
      await databaseHelperService.addTransaction(
        title: title,
        amount: amount,
        description: description,
        id: id,
        is_income: is_income,
      );
      getTransactions(id);
      getBanks();
      _transactions.refresh();
      Get.back();
    } catch (error) {
      print('addTransaction error $error');
    }
  }

  Future deleteTransaction(id, id2, bankTitle, amount) async {
    try {
      await databaseHelperService.deleteTransaction(id);
      getBanks();
      getTransactions(id2);
    } catch (error) {
      print('deleteTransaction error $error');
    }
  }


  Future updateTransaction(bankId,transactionId, title, amount, description, groupValue) async{
    try {
      await databaseHelperService.updateTransaction(transactionId, title, amount, description, groupValue);
      getBanks();
      getTransactions(bankId);
      _transactions.refresh();
      Get.back();
    } catch (error) {
      print('updateTransaction error $error');
    }
  }

  Future getBank(id) async{
    try{
      return await databaseHelperService.getBank(id);
    }catch(error){
      print('get bank error $error');
    }
  }

}
