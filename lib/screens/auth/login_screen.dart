import 'package:database_revision/mixins/helpers.dart';
import 'package:database_revision/model/user.dart';
import 'package:database_revision/preferences/user_preferences.dart';
import 'package:database_revision/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Helpers{
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text('LOGIN',style: TextStyle(color: Colors.black),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
        child: Column(
          children: [
            TextField(
              controller: _emailTextController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(hintText: 'Email'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _passwordTextController,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: const InputDecoration(hintText: 'Password'),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () async{
                await performLogin();
              },
              child: const Text('LOGIN'),
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50)),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, '/create_account_screen'),
              child: const Text('CREATE ACCOUNT'),
              style: ElevatedButton.styleFrom(
                  primary: Colors.grey.shade500,
                  minimumSize: const Size(double.infinity, 50)),
            ),
          ],
        ),
      ),
    );
  }

  Future performLogin() async {
    if(checkData()){
      await login();
    }
  }

  bool checkData() {
    if (_emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context, message: 'Enter required data!', error: true);
    return false;
  }

  Future login() async {
    bool created = await Provider.of<UserProvider>(context, listen: false).login(userData: user);
    if (created) {
      Navigator.pushNamedAndRemoveUntil(context, '/notes_screen', (route) => false);
    }
  }

  User get user {
    User user = User();
    user.email = _emailTextController.text;
    user.password = _passwordTextController.text;
    return user;
  }
}
