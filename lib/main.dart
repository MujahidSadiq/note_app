import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:note_app/views/homeScreen.dart';
import 'package:note_app/views/loginScreen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  if(Platform.isAndroid){
    await Firebase.initializeApp(options: const FirebaseOptions(
      projectId: "note-app-6151c",
      apiKey: "AIzaSyAxxcpZNj0l4DEZbsYbREYHRzkf4P4yLuk",
      appId: "1:899709959630:android:38bb701fde61f2ec55ff9f",
      messagingSenderId: "",
    ));
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? user;

  @override
  void initState() {

    super.initState();
    user=FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:user !=null? const HomeScreen():LoginScreen(),
    );
  }
}
