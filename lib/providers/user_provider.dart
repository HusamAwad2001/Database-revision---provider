import 'package:database_revision/controller/user_db_controller.dart';
import 'package:database_revision/model/user.dart';
import 'package:database_revision/preferences/user_preferences.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier{

  List<User> users = <User>[];
  final UserDbController _userDbController = UserDbController();

  Future<bool> login({required User userData}) async{
    User? user = await _userDbController.login(email: userData.email, password: userData.password);
    if(user != null){
      await UserPreferences().save(user);
      return true;
    }
    return false;
  }

  Future<bool> create(User user) async{
    int id = await _userDbController.create(user);
    if(id != 0){
      user.id = id;
      users.add(user);
      await UserPreferences().save(user);
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> read() async{
    users = await _userDbController.read();
    notifyListeners();
  }

  Future<bool> update(User updatedUser) async{
    bool updated = await _userDbController.update(updatedUser);
    if(updated){
      int index = users.indexWhere((element) => element.id == updatedUser.id);
      if(index != -1){
        users[index] = updatedUser;
        notifyListeners();
        return true;
      }
    }
    return false;
  }

  Future<bool> delete(int id) async{
    bool deleted = await _userDbController.delete(id);
    if(deleted){
      int index = users.indexWhere((element) => element.id == id);
      if(index != -1){
      users.removeAt(index);
      notifyListeners();
      return true;
      }
    }
    return false;
  }

}