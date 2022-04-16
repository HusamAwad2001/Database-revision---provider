import 'package:database_revision/mixins/helpers.dart';
import 'package:database_revision/model/note.dart';
import 'package:database_revision/preferences/user_preferences.dart';
import 'package:database_revision/providers/notes_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CreateNoteScreen extends StatefulWidget {
  @override
  State<CreateNoteScreen> createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> with Helpers {
  bool _noteStatus = false;
  DateTime? _pickedDateValue;
  String? _pickedDate;
  late TextEditingController _titleTextController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleTextController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _titleTextController.dispose();
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
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: const Text(
          'CREATE NOTE',
          style: TextStyle(color: Colors.black),
        ),
        actionsIconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          children: [
            TextField(
              controller: _titleTextController,
              keyboardType: TextInputType.text,
              maxLength: 30,
              decoration: const InputDecoration(
                hintText: 'Title',
                counterText: ' ',
              ),
            ),
            const SizedBox(height: 10),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Status'),
              subtitle: const Text('Set note status'),
              value: _noteStatus,
              onChanged: (bool value) {
                setState(() {
                  _noteStatus = value;
                });
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Date'),
              subtitle: const Text('Select note data'),
              trailing: Text(_pickedDate ?? 'D/M/Y'),
              onTap: () async {
                await pickDate();
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async{
                await performSave();
              },
              child: const Text('SAVE'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50)
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future pickDate() async {
    DateTime? dateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021, 1, 1),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (dateTime != null) {
      _pickedDateValue = dateTime;
      var format = DateFormat.yMd('en');
      _pickedDate = format.format(dateTime);
      print('Date: $_pickedDate');
    }
  }

  Future performSave() async {
    if (checkDate()) {
      await save();
    }
  }

  bool checkDate() {
    if (_pickedDate != null && _titleTextController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context, message: 'Enter required data', error: true);
    return false;
  }

  Future save() async {
    bool created =
        await Provider.of<NotesProvider>(context, listen: false).create(note);
    String message = created ? 'Created Successfully' : 'Failed to create note';
    showSnackBar(context, message: message, error: !created);
    Navigator.pop(context);
  }

  Note get note {
    Note note = Note();
    note.title = _titleTextController.text;
    note.status = _noteStatus ? 1 : 0;
    note.date = _pickedDateValue!;
    note.userId = UserPreferences().id;
    return note;
  }
}
