import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_pro/app/constants/colors.dart';
import 'package:quran_pro/app/controllers/note_controllers.dart';
import 'package:quran_pro/app/modules/pages/note_add_update_page.dart';

class NoteListPage extends StatelessWidget {
  const NoteListPage({Key? key}) : super(key: key);

  static const noteAddUpdatePage = '/note-add-update-page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Notes'),
          centerTitle: true,
          elevation: 0,
          automaticallyImplyLeading: false),
      body: GetX<DbController>(
        builder: (controller) {
          final notes = controller.notes;

          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return Dismissible(
                key: Key(note.id.toString()),
                background: Container(color: Colors.red),
                onDismissed: (direction) {
                  controller.deleteNote(note.id!);
                },
                child: Card(
                  color: tertiary,
                  child: ListTile(
                    title: Text(
                      note.title,
                      style: GoogleFonts.poppins(color: secondary),
                    ),
                    subtitle: Text(note.description,
                        style: GoogleFonts.poppins(color: background)),
                    onTap: () async {
                      final selectedNote =
                          await controller.getNoteById(note.id!);
                      // ignore: use_build_context_synchronously
                      Get.to(() => NoteAddUpdatePage(note: selectedNote));
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: tertiary,
        child: const Icon(Icons.add),
        onPressed: () {
          Get.to(() => const NoteAddUpdatePage());
        },
      ),
    );
  }
}
