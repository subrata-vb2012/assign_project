import 'package:assign_project_s/views/auth/login_view.dart';
import 'package:assign_project_s/views/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../controllers/auth_controller.dart';

class SignupView extends StatelessWidget {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final controller = AuthController.instance;

  SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: emailCtrl, decoration: InputDecoration(labelText: "Email")),
            TextField(controller: passCtrl, obscureText: true, decoration: InputDecoration(labelText: "Password")),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.signup(emailCtrl.text, passCtrl.text);
                Get.to(LoginView());
              },
              child: Text("Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}
