import 'package:database_revision/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences{

  static final UserPreferences _instance = UserPreferences._();
  late SharedPreferences _sharedPreferences;

  factory UserPreferences(){
    return _instance;
  }
  UserPreferences._();

  Future<void> initPreferences() async{
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> save(User user) async{
    await _sharedPreferences.setBool('logged_in', true);
    await _sharedPreferences.setInt('id', user.id);
    await _sharedPreferences.setString('name', user.name);
    await _sharedPreferences.setString('email', user.email);
    await _sharedPreferences.setString('password', user.password);
  }

  int get id => _sharedPreferences.getInt('id') ?? 0;

  bool get isLoggedIn => _sharedPreferences.getBool('logged_in') ?? false;
  // bool isLoggedIn() => _sharedPreferences.getBool('logged_in') ?? false;

  Future<bool> logout() async{
    return await _sharedPreferences.clear();
  }

}