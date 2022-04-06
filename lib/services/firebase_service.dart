import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:tyba_flutter_challenge/models/export_models.dart';

class FirebaseService {

  FirebaseService();

  Future<User?> firebaseLogin(UserLoginDto userLoginDto) async{
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential =
        await auth.signInWithEmailAndPassword(email: userLoginDto.email, password: userLoginDto.password);
      user = userCredential.user;
    } on FirebaseAuthException catch(e) {
      if(e.code == "user-not-found") {
        print("No user found for this email");
      }
    }

    return user;
  }

  Future<void> firebaseSignUp(UserLoginDto userLoginDto) async {

    FirebaseAuth auth = FirebaseAuth.instance;

    await auth.createUserWithEmailAndPassword(email: userLoginDto.email, password: userLoginDto.password);
  }

}