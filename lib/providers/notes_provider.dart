import 'package:database_revision/controller/notes_db_controller.dart';
import 'package:database_revision/model/note.dart';
import 'package:flutter/material.dart';

class NotesProvider extends ChangeNotifier{

  List<Note> notes = <Note>[];
  final NotesDbController _notesDbController = NotesDbController();

  Future<bool> create(Note note) async{
    int id = await _notesDbController.create(note);
    if(id != 0){
      note.id = id;
      notes.add(note);
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> read() async{
    notes = await _notesDbController.read();
    notifyListeners();
  }

  Future<bool> update(Note updatedNote) async{
    bool updated = await _notesDbController.update(updatedNote);
    if(updated){
      int index = notes.indexWhere((element) => element.id == updatedNote.id);
      if(index != -1){
        notes[index] = updatedNote;
        notifyListeners();
      }
    }
    return false;
  }

  Future<bool> delete(int id) async{
    bool deleted = await _notesDbController.delete(id);
    if(deleted){
      // int index = notes.removeWhere((element) => element.id == id);
      int index = notes.indexWhere((element) => element.id == id);
      if(index != -1){
        notes.removeAt(index);
        notifyListeners();
        return true;
      }
    }
    return false;
  }

  // void clear(){
  //   // notes.clear();
  //   notes = [];
  // }

}