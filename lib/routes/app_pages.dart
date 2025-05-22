import 'package:get/get.dart';
import '../views/auth/login_view.dart';
import '../views/auth/signup_view.dart';
import '../views/auth/forgot_password_view.dart';
import '../views/home/home_view.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/', page: () => LoginView()),
    GetPage(name: '/signup', page: () => SignupView()),
    GetPage(name: '/forgot', page: () => ForgotPasswordView()),
    GetPage(name: '/home', page: () => HomeView()),
  ];
}
