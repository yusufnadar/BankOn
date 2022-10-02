class TransactionsModel {
  dynamic id;
  dynamic title;
  dynamic description;
  dynamic amount;
  dynamic bank_id;
  dynamic is_income;
  dynamic createdAt;

  TransactionsModel({this.amount,this.createdAt,this.id,this.title,this.description,this.bank_id,this.is_income});

  factory TransactionsModel.fromJson(Map<String, dynamic> json) => TransactionsModel(
    id: json['id'],
    amount: json['amount'],
    title: json['title'],
    description: json['description'],
    createdAt: json['created_at'],
    bank_id: json['bank_id'],
    is_income: json['is_income'],
  );
}
