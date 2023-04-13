import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_pro/app/constants/colors.dart';
import 'package:quran_pro/app/data/db/db_note.dart';
import 'package:quran_pro/app/data/models/note.dart';

class NoteAddUpdatePage extends StatefulWidget {
  final Note? note;
  static const NOTE_ADD_UPDATE_PAGE = '/note-add-update-page';

  const NoteAddUpdatePage({Key? key, this.note}) : super(key: key);

  @override
  State<NoteAddUpdatePage> createState() => _NoteAddUpdatePageState();
}

class _NoteAddUpdatePageState extends State<NoteAddUpdatePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  bool _isUpdate = false;

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _descriptionController.text = widget.note!.description;
      _isUpdate = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Notes'),
          centerTitle: true,
          elevation: 0,),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Judul',
              ),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Deskripsi',
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Get.isDarkMode ? secondary : secondaryDark,
                ),
                child: const Text('Simpan'),
                onPressed: () async {
                  if (!_isUpdate) {
                    final note = Note(
                      title: _titleController.text,
                      description: _descriptionController.text,
                    );
                    Get.find<DbController>().addNote(note);
                  } else {
                    final note = Note(
                      id: widget.note!.id,
                      title: _titleController.text,
                      description: _descriptionController.text,
                    );
                    Get.find<DbController>().updateNote(note);
                  }
                  Navigator.pop(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
