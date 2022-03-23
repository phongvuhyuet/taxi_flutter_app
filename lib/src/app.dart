import 'package:flutter/material.dart';
import 'package:taxi_flutter_app/src/blocs/auth_bloc.dart';
import 'package:taxi_flutter_app/src/resources/login_page.dart';
import 'package:taxi_flutter_app/src/resources/register_page.dart';

// class MyApp extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(home: RegisterPage());
//   }
// }

class MyApp extends InheritedWidget {
  final AuthBloc authBloc;
  final Widget child;

  MyApp(this.authBloc, this.child) : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }

  static MyApp? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyApp>();
  }
}
