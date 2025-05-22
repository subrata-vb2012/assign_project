import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../repositories/auth_repository.dart';

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

  Future<void> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Email and password cannot be empty', snackPosition: SnackPosition.BOTTOM);
      return;
    }
    isLoading.value = true;

    try {
      await _repo.login(email, password);
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Login Unsuccessful",
        e.message ?? "An unknown error occurred",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signup(String email, String password) async {
    try {
      await _repo.signup(email, password);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _repo.resetPassword(email);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> logout() async {
    await _repo.logout();
    Get.snackbar('LogOut', 'SuccessFul'.toString());
  }
}
