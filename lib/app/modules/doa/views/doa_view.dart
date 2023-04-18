import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_pro/app/constants/colors.dart';
import 'package:quran_pro/app/data/models/doa_model.dart';

import '../controllers/doa_controller.dart';

class DoaView extends GetView<DoaController> {
  const DoaView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Kumpulan Doa', style: GoogleFonts.poppins()),
          centerTitle: true,
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        body: CardDoa(controller: controller));
  }
}

class CardDoa extends StatelessWidget {
  const CardDoa({super.key, required this.controller});
  final DoaController controller;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
          future: controller.getDoaList(),
          builder: (context, data) {
            if (data.hasError) {
              return Center(child: Text("${data.error}"));
            } else if (data.hasData) {
              var items = data.data as List<Doa>;

              return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Get.isDarkMode ? secondary : tertiary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 5,
                      margin:
                          const EdgeInsets.only(left: 10, right: 10, bottom: 5),
                      child: Theme(
                        data: ThemeData(
                          dividerColor: Colors.transparent,
                          unselectedWidgetColor:
                              Get.isDarkMode ? tertiary : secondary,
                          colorScheme: ColorScheme.fromSwatch().copyWith(
                              primary: Get.isDarkMode ? tertiary : secondary),
                        ),
                        child: GetBuilder<DoaController>(
                          builder: (controller) => ExpansionTile(
                            title: Text(
                              items[index].title.toString(),
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            leading: IconButton(
                                onPressed: () {
                                  controller.addBookmark(items[index]);
                                },
                                icon: Icon(Icons.bookmark_add)),
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        child: Container(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 10),
                                            child: Text(
                                                items[index].arab.toString(),
                                                textAlign: TextAlign.end,
                                                style: GoogleFonts.amiri(
                                                    color: Get.isDarkMode
                                                        ? primaryDark
                                                        : secondary,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 25)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8, right: 8),
                                            child: Text(
                                                items[index]
                                                    .latinArab
                                                    .toString(),
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
                                                items[index]
                                                    .translate
                                                    .toString(),
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
                        ),
                      ),
                    );
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        );
  }
}
