import 'dart:io';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelperService {
  static late Database database;
  var aa = 10;

  static Future<void> init() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'bank_accounts.db');
    var exists = await databaseExists(path);
    if (!exists) {
      var data =
          await rootBundle.load(join('assets', 'db', 'bank_accounts.db'));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true);
    }
    database = await openDatabase(path, readOnly: false);
  }

  Future getBanks() async {
    try {
      return await database.rawQuery('SELECT * from names');
    } catch (error) {
      print('error $error');
    }
  }

  Future addBank(name) async {
    try {
      return await database.rawInsert(
          "INSERT INTO names (name,amount) values ('$name','0')");
    } catch (error) {
      print('error $error');
    }
  }

  Future deleteBank(id) async {
    try {
      await database.rawDelete("DELETE FROM transactions WHERE bank_id = '$id';");
      await database.rawDelete("DELETE FROM names WHERE id = '$id';");
    } catch (error) {
      print('error $error');
    }
  }

  Future updateBank(id, name) async {
    try {
      return await database.rawUpdate(
        "UPDATE names SET name = '$name' where id = $id",
      );
    } catch (error) {
      print('error $error');
    }
  }

  Future getTransactions(id) async {
    try {
      //return await database.rawQuery("SELECT * from transactions inner join names on transactions.bank_id = names.id");
      return await database.rawQuery("SELECT * from transactions where bank_id = $id order by id desc");
    } catch (error) {
      print('error $error');
    }
  }

  Future addTransaction({title, amount, description,id,is_income}) async{
    try {
      return await database.rawInsert(
          "INSERT INTO transactions (title,amount,description,bank_id,is_income,created_at) values ('$title','$amount','$description','$id','$is_income','${DateTime.now()}')");
    } catch (error) {
      print('error $error');
    }
  }

  Future deleteTransaction(id) async{
    try {
      return await database.rawDelete("DELETE FROM transactions WHERE id = '$id';");
    } catch (error) {
      print('error $error');
    }
  }

  Future updateTransaction(transactionId, title, amount, description, groupValue) async{
    try {
      print('hh $transactionId');
      return await database.rawUpdate(
        "UPDATE transactions SET title = '$title',amount = '$amount' ,description = '$description', is_income = ${groupValue} where id = $transactionId",
      );
    } catch (error) {
      print('error $error');
    }
  }

  Future getTransactionsAll() async {
    try {
      //return await database.rawQuery("SELECT * from transactions inner join names on transactions.bank_id = names.id");
      return await database.rawQuery("SELECT * from transactions");
    } catch (error) {
      print('error $error');
    }
  }

  getBank(id) async{
    try {
      //return await database.rawQuery("SELECT * from transactions inner join names on transactions.bank_id = names.id");
      return await database.rawQuery("SELECT * from names where id = $id");
    } catch (error) {
      print('error $error');
    }
  }
}
