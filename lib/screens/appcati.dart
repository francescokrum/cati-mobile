import 'package:cati_mobile/screens/login_screen.dart';
import 'package:flutter/material.dart';

class AppCati extends StatelessWidget {
  const AppCati({super.key});


  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginScreen(),
    );
  }
}