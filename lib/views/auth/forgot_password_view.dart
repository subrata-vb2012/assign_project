import 'package:flutter/material.dart';
import '../../../controllers/auth_controller.dart';

class ForgotPasswordView extends StatelessWidget {
  final emailCtrl = TextEditingController();
  final controller = AuthController.instance;

  ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Forgot Password")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: emailCtrl, decoration: InputDecoration(labelText: "Email")),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => controller.resetPassword(emailCtrl.text),
              child: Text("Send Reset Email"),
            ),
          ],
        ),
      ),
    );
  }
}
