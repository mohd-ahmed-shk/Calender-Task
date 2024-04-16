class UseModel {
  int? id;
  String? use;


  UseModel(this.id,this.use);
  UseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    use = json['use'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['use'] = use;
    return data;
  }


}