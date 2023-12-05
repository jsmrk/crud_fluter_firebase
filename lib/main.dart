import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_fluter_firebase/screens/ask_nickname.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/adapters.dart';
import 'firebase_options.dart';

Future<void> main() async {
  //init Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //initHive
  await Hive.initFlutter();
  //openHiveBox
  await Hive.openBox('nicknameBox');
  await Hive.openBox('concernBox');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AskingNickname(),
    );
  }
}
