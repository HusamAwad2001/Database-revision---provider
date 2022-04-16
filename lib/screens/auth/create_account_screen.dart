import 'package:database_revision/mixins/helpers.dart';
import 'package:database_revision/model/user.dart';
import 'package:database_revision/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateAccountScreen extends StatefulWidget {
  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen>
    with Helpers {
  late TextEditingController _nameTextController;
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameTextController = TextEditingController();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nameTextController.dispose();
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
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        title: const Text('CREATE ACCOUNT',style: TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
        child: Column(
          children: [
            TextField(
              controller: _nameTextController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(hintText: 'Name'),
            ),
            const SizedBox(height: 10),
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
                await performCreateAccount();
              },
              child: const Text('CREATE'),
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50)),
            ),
          ],
        ),
      ),
    );
  }

  Future performCreateAccount() async {
    if(checkData()){
      await createAccount();
    }
  }

  bool checkData() {
    if (_nameTextController.text.isNotEmpty &&
        _emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context, message: 'Enter required data!', error: true);
    return false;
  }

  Future createAccount() async {
    bool created =
        await Provider.of<UserProvider>(context, listen: false).create(user);
    if (created) {
      Navigator.pushNamedAndRemoveUntil(context, '/notes_screen', (route) => false);
    }
  }

  User get user {
    User user = User();
    user.name = _nameTextController.text;
    user.email = _emailTextController.text;
    user.password = _passwordTextController.text;
    return user;
  }
}
