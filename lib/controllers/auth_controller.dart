import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../repositories/auth_repository.dart';
import '../views/project/project_list_view.dart';

class AuthController extends GetxController {
  static AuthController get instance => Get.find();

  final AuthRepository _repo = AuthRepository();

  bool get isLoggedIn => _repo.currentUser != null;

  final isLoading = false.obs;

  String userName() {
    String name = _repo.currentUser?.email?.split('@').first ?? '';
    return 'Welcome ${name[0].toUpperCase() + name.substring(1)}';
  }

  Stream get authStateChanges => _repo.authStateChanges;

  void login(String email, String password) async {
    // Validation
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Email and password cannot be empty', snackPosition: SnackPosition.BOTTOM);
      return;
    }

    isLoading.value = true;

    try {
      final user = await _repo.login(email, password);
      if (user != null) {
        Get.offAll(() => const ProjectListView());
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Login Successful",
        e.message ?? "An unknown error occurred",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar("Error", "Unexpected error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signup(String email, String password) async {
    try {
      await _repo.signup(email, password);
    } catch (e) {
      // Get.snackbar("Signup Failed", e.toString());
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _repo.resetPassword(email);
      // Get.snackbar("Success", "Password reset email sent.");
    } catch (e) {
      // Get.snackbar("Error", e.toString());
    }
  }

  Future<void> logout() async {
    await _repo.logout();
  }
}
