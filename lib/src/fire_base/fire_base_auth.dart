import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FirAuth {
  final FirebaseAuth _fireBaseAuth = FirebaseAuth.instance;

  void signUp(String email, String pass, String name, String phone,
      Function onSuccess) {
    _fireBaseAuth
        .createUserWithEmailAndPassword(email: email, password: pass)
        .then((authResult) {
      _createUser(authResult.user?.uid as String, name, phone, onSuccess);
    }).catchError((err) {
      print("err: " + err.toString());
    });
  }

  _createUser(String userId, String name, String phone, Function onSuccess) {
    var user = Map<String, String>();
    user["name"] = name;
    user["phone"] = phone;

    var ref = FirebaseDatabase.instance.ref().child("users");
    ref
        .child(userId)
        .set(user)
        .then((vl) {
          print("on value: SUCCESSED");
          onSuccess();
        })
        .catchError((err) {})
        .whenComplete(() {
          print("completed");
        });
  }
}
