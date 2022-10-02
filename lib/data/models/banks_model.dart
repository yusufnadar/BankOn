class BanksModel {
  int? id;
  String? name;
  num? amount;

  BanksModel({this.id, this.name,this.amount});

  factory BanksModel.fromJson(Map<String, dynamic> json) => BanksModel(
        id: json['id'],
        amount: json['amount'],
        name: json['name'],
      );
}
