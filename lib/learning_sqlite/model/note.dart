class Note {
  int? _id;
  int? _priority;
  String? _title;
  String? _description;
  String? _date;

  Note(this._priority, this._title, this._date,this._description);
  Note.withId(this._id, this._priority, this._title, this._date,this._description);


  int? get id => _id;
  int? get priority => _priority;
  String? get title => _title;
  String? get date => _date;
  String? get description => _description;


  set title(String? newTitle) {
    if(newTitle!.length   <= 255) {
      _title = newTitle;
    }
  }

  set description(String? newDescription) {
    if(newDescription!.length <= 255) {
      _description = newDescription;
    }
  }


  set priority(int? newPriority) {
    if(newPriority! <= 1 && newPriority >= 2) {
      _priority = newPriority;
    }
  }

  set date(String? newDate) {
    _date = newDate;
  }
  // convert a Note Object into a Map object
  Map<String,dynamic> toMap() {
    var map = Map<String,dynamic>();
    if(id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['description'] = _description;
    map['priority'] = _priority;
    map['date'] = _date;

    return map;
  }

  // Extract a Note Object from a Map object
  Note.fromMapObject(Map<String,dynamic> map) {
    _id = map['id'];
    _title = map['title'];
    _description = map['description'];
    _priority = map['priority'];
    _date = map['date'];
  }



}