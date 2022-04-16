
class User{
  late int id;
  late String name;
  late String email;
  late String password;

  User();

  /**
   * When a select query executed, data returned as MAP for each row,
   * so we will convert row from Map to Object.
   */
  User.fromMap(Map<String, dynamic> rowMap){
    id = rowMap['id'];
    name = rowMap['name'];
    email = rowMap['email'];
    password = rowMap['password'];
  }

  /**
   * This function is used in:
   * 1) CREATE new row in database, so we must convert data from object to map.
   * 2) UPDATE existing row in database, so we must provide the map of the updated object.
   */
  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = <String, dynamic>{};
    map['name'] = name;
    map['email'] = email;
    map['password'] = password;
    return map;
  }
}