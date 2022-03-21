import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:taxi_flutter_app/resources/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xff3277D8)),
        elevation: 0,
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        color: Colors.white,
        child: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            Image.asset('ic_car_red.png'),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 6),
              child: Center(
                  child: Text("Welcome Aboard!",
                      style:
                          TextStyle(fontSize: 20, color: Color(0xff333333)))),
            ),
            Center(
                child: Text("Sign up with iCab in simple steps",
                    style: TextStyle(fontSize: 16, color: Color(0xff606470)))),
            Padding(
                padding: EdgeInsets.fromLTRB(0, 40, 0, 10),
                child: TextField(
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          borderSide:
                              BorderSide(color: Color(0xffCED0D2), width: 1)),
                      prefixIcon: Container(
                        width: 50,
                        child: Image.asset("ic_user.png"),
                      ),
                      labelText: "Name"),
                )),
            Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: TextField(
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          borderSide:
                              BorderSide(color: Color(0xffCED0D2), width: 1)),
                      prefixIcon: Container(
                        width: 50,
                        child: Image.asset("ic_phone.png"),
                      ),
                      labelText: "Phone Number"),
                )),
            Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
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
            Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                child: TextField(
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
                )),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                child: Text("Sign up",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )),
                onPressed: onSignupClicked,
              ),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Center(
                    child: RichText(
                  text: TextSpan(
                      text: "Already a User?",
                      style: TextStyle(
                        color: Color(0xffCED0D2),
                        fontSize: 18,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: "Login now",
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xff3277D8),
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()));
                              })
                      ]),
                )))
          ],
        )),
      ),
    );
  }

  void onSignupClicked() {}
}
