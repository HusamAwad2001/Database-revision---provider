import 'package:database_revision/controller/db_operations.dart';
import 'package:database_revision/model/user.dart';
import 'package:database_revision/storage/db_provider.dart';
import 'package:sqflite/sqflite.dart';

class UserDbController extends DbOperation<User> {
  final Database _database = DbProvider().database;

  UserDbController();

  Future<User?> login({required String email, required String password}) async {
    List<Map<String, dynamic>> data = await _database.query('users',
        where: 'email = ? AND password = ?', whereArgs: [email, password]);
    if(data.isNotEmpty){
      return data.map((rowMAp) => User.fromMap(rowMAp)).first;
    }
    return null;
  }

  @override
  Future<int> create(User object) async {
    // TODO: implement create
    return await _database.insert('users', object.toMap());
  }

  @override
  Future<bool> delete(int id) async {
    // TODO: implement delete
    int countOfDeletedRows =
        await _database.delete('users', where: 'id = ?', whereArgs: [id]);
    return countOfDeletedRows > 0;
  }

  @override
  Future<List<User>> read() async {
    // TODO: implement read
    List<Map<String, dynamic>> rows = await _database.query('users');
    if (rows.isNotEmpty) {
      return rows.map((rowMap) => User.fromMap(rowMap)).toList();
    }
    return [];
  }

  @override
  Future<bool> update(User object) async {
    // TODO: implement update
    int countOfUpdatedRows = await _database.update('users', object.toMap(),
        where: 'id = ?', whereArgs: [object.id]);
    return countOfUpdatedRows > 0;
  }

  @override
  Future<User?> show(int id) async {
    // TODO: implement show
    List<Map<String, dynamic>> data =
        await _database.query('users', where: 'id = ?', whereArgs: [id]);
    if (data.isNotEmpty) {
      return data.map((rowMap) => User.fromMap(rowMap)).first;
    }
    return null;
  }
}
