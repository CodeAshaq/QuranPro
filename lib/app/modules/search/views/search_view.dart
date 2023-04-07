import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/search_controller.dart';

class SearchView extends GetView<SearchController> {
  static const String settingsTitle = 'Settings';
  const SearchView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(settingsTitle),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          settingsTitle,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
