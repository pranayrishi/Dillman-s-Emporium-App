import 'package:dillmans_emporium_app/pages/account.dart';
import 'package:dillmans_emporium_app/pages/login.dart';
import 'package:dillmans_emporium_app/pages/register.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(), // Supposed to be HomePage()
    );
  }
}

// sidbar code: https://www.youtube.com/watch?v=Z37ukFI4Ot0
