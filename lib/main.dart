import 'package:flutter/material.dart';
import 'package:taxi_flutter_app/src/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:taxi_flutter_app/src/blocs/auth_bloc.dart';
import 'package:taxi_flutter_app/src/resources/login_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp(
      new AuthBloc(),
      MaterialApp(
        home: LoginPage(),
      )));
}
