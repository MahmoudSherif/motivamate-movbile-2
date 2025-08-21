import 'package:flutter/material.dart';
import '../models/note.dart';

class NotesProvider extends ChangeNotifier {
  final List<Note> _notes = [];

  List<Note> get notes => List.unmodifiable(_notes);

  void addNote(Note note) {
    _notes.insert(0, note); // Add new notes at the beginning
    notifyListeners();
  }

  void updateNote(Note note) {
    final index = _notes.indexWhere((n) => n.id == note.id);
    if (index != -1) {
      _notes[index] = note.copyWith(updatedAt: DateTime.now());
      notifyListeners();
    }
  }

  void deleteNote(String noteId) {
    _notes.removeWhere((note) => note.id == noteId);
    notifyListeners();
  }

  List<Note> searchNotes(String query) {
    if (query.isEmpty) return notes;
    
    return _notes.where((note) {
      return note.title.toLowerCase().contains(query.toLowerCase()) ||
             note.content.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  List<Note> getNotesByCategory(String category) {
    return _notes.where((note) => note.category == category).toList();
  }

  List<String> getAllCategories() {
    final categories = <String>{};
    for (final note in _notes) {
      if (note.category.isNotEmpty) {
        categories.add(note.category);
      }
    }
    return categories.toList()..sort();
  }
}