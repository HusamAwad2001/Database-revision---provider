import 'package:database_revision/controller/db_operations.dart';
import 'package:database_revision/model/note.dart';
import 'package:database_revision/preferences/user_preferences.dart';
import 'package:database_revision/storage/db_provider.dart';
import 'package:sqflite/sqflite.dart';

class NotesDbController extends DbOperation<Note> {

  final Database _database = DbProvider().database;

  @override
  Future<int> create(Note object) {
    // TODO: implement create
    return _database.insert('notes', object.toMap());
  }

  @override
  Future<bool> delete(int id) async {
    // TODO: implement delete
    int countOfDeletedRows = await _database.delete(
        'notes', where: 'id = ?', whereArgs: [id]);
    return countOfDeletedRows > 0;
  }

  @override
  Future<List<Note>> read() async {
    // TODO: implement read
    List<Map<String, dynamic>> rowsMap = await _database.query(
      'notes', where: 'user_id = ?', whereArgs: [UserPreferences().id],);
    if (rowsMap.isNotEmpty) {
      return rowsMap.map((rowMap) => Note.fromMap(rowMap)).toList();
    }
    return [];
  }

  @override
  Future<Note?> show(int id) async {
    // TODO: implement show
    List<Map<String, dynamic>> data = await _database.query(
        'notes', where: 'id = ?', whereArgs: [id]);
    if (data.isNotEmpty) {
      return data
          .map((rowMap) => Note.fromMap(rowMap))
          .first;
    }
    return null;
  }

  @override
  Future<bool> update(Note object) async {
    // TODO: implement update
    int countOfUpdatedRows = await _database.update(
        'notes', object.toMap(), where: 'id = ?', whereArgs: [object.id]);
    return countOfUpdatedRows > 0;
  }

}