import 'package:dillmans_emporium_app/pages/Authenticate.dart';
import 'package:dillmans_emporium_app/pages/account.dart';
import 'package:dillmans_emporium_app/pages/login.dart';
import 'package:dillmans_emporium_app/pages/register.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Authenticate(), // Supposed to be Authenticate()
    );
  }
}

// sidbar code: https://www.youtube.com/watch?v=Z37ukFI4Ot0
