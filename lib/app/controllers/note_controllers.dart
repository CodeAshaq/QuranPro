import 'package:get/get.dart';
import 'package:quran_pro/app/data/db/database_helper.dart';
import 'package:quran_pro/app/data/models/note.dart';

class DbController extends GetxController {
  final notes = <Note>[].obs;
  late DatabaseHelper _dbHelper;

  @override
  void onInit() {
    _dbHelper = DatabaseHelper();
    getAllNotes();
    super.onInit();
  }

  void getAllNotes() async {
    final notesData = await _dbHelper.getNotes();
    notes.assignAll(notesData);
  }

  Future<void> addNote(Note note) async {
    await _dbHelper.insertNote(note);
    getAllNotes();
  }

  Future<Note> getNoteById(int id) async {
    return await _dbHelper.getNoteById(id);
  }

  void updateNote(Note note) async {
    await _dbHelper.updateNote(note);
    getAllNotes();
  }

  void deleteNote(int id) async {
    await _dbHelper.deleteNote(id);
    getAllNotes();
  }
}