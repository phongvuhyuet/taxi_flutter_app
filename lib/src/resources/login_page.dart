import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:taxi_flutter_app/src/resources/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          constraints: BoxConstraints.expand(),
          color: Colors.white,
          child: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              SizedBox(
                height: 140,
              ),
              Image.asset('ic_car_green.png'),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 40, 0, 6),
                  child: Center(
                      child: Text("Welcome back!",
                          style: TextStyle(
                              fontSize: 22, color: Color(0xff333333))))),
              Center(
                  child: Text("Login to continue using iCab",
                      style:
                          TextStyle(fontSize: 16, color: Color(0xff606470)))),
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 100, 0, 10),
                  child: TextField(
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                            borderSide:
                                BorderSide(color: Color(0xffCED0D2), width: 1)),
                        prefixIcon: Container(
                          width: 50,
                          child: Image.asset("ic_mail.png"),
                        ),
                        labelText: "Email"),
                  )),
              TextField(
                style: TextStyle(fontSize: 18, color: Colors.black),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        borderSide:
                            BorderSide(color: Color(0xffCED0D2), width: 1)),
                    prefixIcon: Container(
                      width: 50,
                      child: Image.asset("ic_lock.png"),
                    ),
                    labelText: "Password"),
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  alignment: AlignmentDirectional.centerEnd,
                  child: Text("Forgot password?",
                      style: TextStyle(color: Color(0xffCED0D2)))),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: onLoginClicked,
                    child: Text("Login",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white))),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: RichText(
                    text: TextSpan(
                        text: "New user?",
                        style:
                            TextStyle(color: Color(0xffCED0D2), fontSize: 18),
                        children: <TextSpan>[
                      TextSpan(
                          text: "Sign up for new account",
                          style:
                              TextStyle(fontSize: 18, color: Color(0xff3277D8)),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisterPage(),
                                  ));
                            })
                    ])),
              )
            ],
          ))),
    );
  }

  void onLoginClicked() {}
}
