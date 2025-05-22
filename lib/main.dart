import 'package:assign_project_s/controllers/map_data_controller.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'controllers/project_controller.dart';
import 'firebase_options.dart';
import 'controllers/auth_controller.dart';
import 'views/auth/login_view.dart';
import 'views/home/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
    // Use 'playIntegrity' or 'safetyNet' in production
  );

  Get.put(AuthController()); // inject controller
  Get.put(ProjectController());
  Get.put(MapDataController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clean Firebase Auth',
      home: AuthGate(),
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(side: BorderSide(color: Colors.green, width: 2)),
          ),
        ),
      ),
    );
  }
}

class AuthGate extends StatelessWidget {
  final controller = AuthController.instance;

  AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    // FirebaseAuth.instance.ac
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder(
          stream: controller.authStateChanges,
          builder: (context, snapshot) {
            return snapshot.hasData && (snapshot.data != null) ? HomeView() : LoginView();
          },
        ),
      ),
    );
  }
}
