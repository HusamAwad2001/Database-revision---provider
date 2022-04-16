import 'package:database_revision/mixins/helpers.dart';
import 'package:database_revision/preferences/user_preferences.dart';
import 'package:database_revision/providers/notes_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotesScreen extends StatefulWidget {
  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> with Helpers {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<NotesProvider>(context, listen: false).read();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'NOTES',
          style: TextStyle(color: Colors.black),
        ),
        actionsIconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/create_note_screen');
            },
            icon: const Icon(Icons.note_add),
          ),
          IconButton(
            onPressed: () async {
              await logout();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Consumer<NotesProvider>(
        builder: (BuildContext context, NotesProvider value, Widget? child) {
          if (value.notes.isNotEmpty) {
            return ListView.builder(
              itemCount: value.notes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.note),
                  title: Text(value.notes[index].title),
                  subtitle:
                      Text(value.notes[index].status == 1 ? 'Done' : 'Waiting'),
                  trailing: IconButton(
                    onPressed: () async {
                      await delete(value.notes[index].id);
                    },
                    icon: const Icon(Icons.delete),
                  ),
                  onTap: () {},
                );
              },
            );
          } else {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.warning,
                    color: Colors.grey.shade500,
                    size: 80,
                  ),
                  Text(
                    'NO DATA',
                    style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Future logout() async {
    bool status = await UserPreferences().logout();
    if (status) {
      // Provider.of<NotesProvider>(context, listen: false).clear();
      Navigator.pushReplacementNamed(context, '/login_screen');
    }
  }

  Future delete(int id) async {
    bool deleted =
        await Provider.of<NotesProvider>(context, listen: false).delete(id);
    String message =
        deleted ? 'Note deleted successfully' : 'Failed to delete note';
    showSnackBar(context, message: message, error: !deleted);
  }
}
