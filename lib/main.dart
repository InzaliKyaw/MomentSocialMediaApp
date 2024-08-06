import 'package:chatty/pages/login_page.dart';
import 'package:chatty/pages/user_welcome_page.dart';
import 'package:chatty/resources/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyCv6YLL4yNHgoe60B4cVS9Eiw8OLJXOMds",
        projectId: "chatty-1a165",
        storageBucket: "chatty-1a165.appspot.com",
        appId: "1:598701750514:android:c6446e464b9d5bce31b86b",
        messagingSenderId: '895232237528',
      )
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white
      ),
      home: UserWelcomePage(),
    );
  }
}