class CalenderModel {
  int? id;
  String? amount;
  String? date;
  String? title;
  String? frequency;
  String? use;
  String? bank;

  CalenderModel(this.id, this.amount, this.use, this.date, this.frequency,
      this.title, this.bank);

  CalenderModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    amount = json['amount'];
    id = json['id'];
    date = json['date'];
    frequency = json['frequency'];
    use = json['use'];
    bank = json['bank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['amount'] = amount;
    data['date'] = date;
    data['frequency'] = frequency;
    data['use'] = use;
    data['bank'] = bank;
    return data;
  }
}
