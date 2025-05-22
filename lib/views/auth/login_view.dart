import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/auth_controller.dart';
import 'signup_view.dart';
import 'forgot_password_view.dart';

class LoginView extends StatelessWidget {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final controller = AuthController.instance;

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AuthController());

    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: emailCtrl, decoration: InputDecoration(labelText: "Email")),
            TextField(
              controller: passCtrl,
              obscureText: true,
              decoration: InputDecoration(labelText: "Password"),
            ),
            SizedBox(height: 20),
            Obx(
              () =>
                  controller.isLoading.value
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                        onPressed: () {
                          controller.login(emailCtrl.text, passCtrl.text);
                        },
                        child: const Text('Login'),
                      ),
            ),
            TextButton(
              onPressed: () => Get.to(() => SignupView()),
              child: Text("Don't have an account? Sign up"),
            ),
            TextButton(onPressed: () => Get.to(() => ForgotPasswordView()), child: Text("Forgot Password?")),
          ],
        ),
      ),
    );
  }
}
