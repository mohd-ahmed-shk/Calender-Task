class BankModel {
  int? id;
  String? bank;


  BankModel(this.id,this.bank);
  BankModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bank = json['bank'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['bank'] = bank;
    return data;
  }


}