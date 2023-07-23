import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prac_http_api/controllers/login_controller.dart';
import 'package:prac_http_api/ui/home_page.dart';
import 'package:prac_http_api/ui/login_page.dart';

Future<void> main() async {
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(AuthController());
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: Scaffold(
        body: GetBuilder<AuthController>(
          builder:(_){
            return _.isSignedIn.value ? HomePage(): LoginPage();
      }
    ),
      ),
    );
  }
}

