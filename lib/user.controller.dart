// lib/user_controller.dart
import 'package:get/get.dart';

import 'user.dart';

class UserController extends GetxController {
  var userList = <User>[].obs;

  void addUser(String name, int age) {
    var newUser = User(name, age);
    userList.add(newUser);
    // Actualizar la Interfaz de usuario, cuando se añade un nuevo usuario.
    update();
  }
}
