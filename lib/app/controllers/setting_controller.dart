import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsController extends GetxController {
  final _storage = GetStorage();
  final String _nameKey = "name";
  var username = 'username'.obs;

  @override
  void onInit() {
    super.onInit();
    readName();
  }

  void readName() {
    final nameValue = _storage.read(_nameKey) ?? "username";
    username.value = nameValue;
  }

  void saveName(String name) {
    _storage.write(_nameKey, name);
    readName();
  }
}
