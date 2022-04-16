
class Note{

  late int id;
  late String title;
  late int status;
  late int userId;
  late DateTime date;

  Note();

  Note.fromMap(Map<String, dynamic> rowMap){
    id = rowMap['id'];
    title = rowMap['title'];
    status = rowMap['status'];
    userId = rowMap['user_id'];
    date = DateTime.parse(rowMap['date']);
  }

  Map<String, dynamic> toMap({bool withId = false}){
    Map<String, dynamic> map = <String, dynamic>{};
    if(withId) map['id'] = id;
    map['title'] = title;
    map['status'] = status;
    map['user_id'] = userId;
    map['date'] = date.toIso8601String();
    return map;
  }

}