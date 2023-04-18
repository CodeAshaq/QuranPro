import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_pro/app/constants/colors.dart';

import '../controllers/bookmark_page_controller.dart';

class BookmarkPageView extends GetView<BookmarkPageController> {
  const BookmarkPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('BookmarkPageView'),
          centerTitle: true,
          elevation: 0,
        ),
        body: GetBuilder<BookmarkPageController>(
          builder: (c) {
            return FutureBuilder<List<Map<String, dynamic>>>(
              future: controller.getBookmark(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.data?.length == 0) {
                  return const Center(
                    child: Text("Tidak ada data"),
                  );
                }
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> data = snapshot.data![index];
                      return Card(
                          color: Get.isDarkMode ? secondary : tertiary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 5,
                          margin: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 5),
                          child: Theme(
                            data: ThemeData(
                              dividerColor: Colors.transparent,
                              unselectedWidgetColor:
                                  Get.isDarkMode ? tertiary : secondary,
                              colorScheme: ColorScheme.fromSwatch().copyWith(
                                  primary:
                                      Get.isDarkMode ? tertiary : secondary),
                            ),
                            child: ExpansionTile(
                              leading: IconButton(
                                onPressed: () {
                                  controller.deleteBookmark(data['id']);
                                },
                                icon: Icon(Icons.delete),
                              ),
                              title: Text("${data['title']}"),
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                          child: Container(
                                        padding:
                                            const EdgeInsets.only(bottom: 8),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 10),
                                              child: Text("${data['arab']}",
                                                  textAlign: TextAlign.end,
                                                  style: GoogleFonts.amiri(
                                                      color: Get.isDarkMode
                                                          ? primaryDark
                                                          : secondary,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 25)),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8, right: 8),
                                              child: Text(
                                                  "${data['latinArab']}",
                                                  style: GoogleFonts.poppins(
                                                      color: Get.isDarkMode
                                                          ? primaryDark
                                                          : secondary,
                                                      fontSize: 14,
                                                      fontStyle:
                                                          FontStyle.italic)),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8, right: 8, top: 5),
                                              child: Text(
                                                  "${data['translate']}",
                                                  style: GoogleFonts.poppins(
                                                      color: Get.isDarkMode
                                                          ? primaryDark
                                                          : secondary,
                                                      fontSize: 16)),
                                            )
                                          ],
                                        ),
                                      ))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ));
                    });
              },
            );
          },
        ));
  }
}
