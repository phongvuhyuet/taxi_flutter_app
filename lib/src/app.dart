import 'package:flutter/material.dart';
import 'package:taxi_flutter_app/src/resources/login_page.dart';
import 'package:taxi_flutter_app/src/resources/register_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: RegisterPage());
  }
}
