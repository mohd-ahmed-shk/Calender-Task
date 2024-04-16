class Notes {
  final int? id;
  final String title;
  final String description;

  Notes({this.id, required this.title, required this.description});

  factory Notes.fromJson(Map<String, dynamic> json) => Notes(
      title: json['title'], description: json['description'], id: json['id']);


  // Notes.fromJson(Map<String, dynamic> json) {
  //   title =
  //   json['title'];
  //   description =
  //   json['description'];
  //   id =
  //   json['id'];
  // }

  Map<String, dynamic> toJson() => {
    'id':id,
    'title' : title,
    'description' : description
  };

  // Map<String, dynamic> toJson() {
  //   final Map<String,dynamic> data = Map<String,dynamic>();
  //   data['id'] = id;
  //   data['title'] = title;
  //   data['description'] = description;
  //
  //   return data;
  // }

}
