import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_pro/app/constants/colors.dart';
import 'package:quran_pro/app/data/db/db_note.dart';
import 'package:quran_pro/app/modules/pages/note_add_update_page.dart';

class NoteListPage extends StatelessWidget {
  const NoteListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false
      ),
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
                  color: Get.isDarkMode ? secondary : tertiary,
                  child: ListTile(
                    title: Text(
                      note.title,
                      style: GoogleFonts.poppins(
                          color: Get.isDarkMode ? background : secondary),
                    ),
                    subtitle: Text(note.description,
                        style: GoogleFonts.poppins(
                            color: Get.isDarkMode ? background : secondary)),
                    onTap: () async {
                      final selectedNote =
                          await controller.getNoteById(note.id!);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              NoteAddUpdatePage(note: selectedNote),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Get.isDarkMode ? secondary : secondaryDark,
        child: const Icon(Icons.add),
        onPressed: () {
          Get.to(() => const NoteAddUpdatePage());
        },
      ),
    );
  }
}
