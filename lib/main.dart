// lib/main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'user.controller.dart';

void main() {
  // Registra el controlador antes de ejecutar la aplicación
  Get.put(UserController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GetX State Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Management'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'User List:',
              style: TextStyle(fontSize: 20),
            ),
            GetBuilder<UserController>(
              builder: (controller) => Expanded(
                child: ListView.builder(
                  itemCount: controller.userList.length,
                  itemBuilder: (context, index) {
                    var user = controller.userList[index];
                    return ListTile(
                      title: Text('${user.name}, ${user.age} years old'),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.to(AddUserScreen());
              },
              child: Text('Add User'),
            ),
          ],
        ),
      ),
    );
  }
}

class AddUserScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: ageController,
              decoration: InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Obtener el controlador y añadir un nuevo usuario
                Get.find<UserController>().addUser(
                  nameController.text,
                  int.tryParse(ageController.text) ?? 0,
                );
                // Volver a la pantalla anterior
                Get.back();
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
