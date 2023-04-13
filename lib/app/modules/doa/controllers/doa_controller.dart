import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quran_pro/app/data/models/doa_model.dart';

class DoaController extends GetxController {

  Future<List<Doa>> getDoaList() async {
    String data = await rootBundle.loadString('assets/datas/doa.json');
    return doaFromJson(data);
  }
}
