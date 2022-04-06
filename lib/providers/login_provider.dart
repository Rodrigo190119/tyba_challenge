import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tyba_flutter_challenge/models/export_models.dart';
import 'package:tyba_flutter_challenge/services/export_services.dart';

class LoginProvider extends ChangeNotifier {

  final FirebaseService _firebaseService = FirebaseService();

  bool _loader = false;

  bool _hiddenPassword = false;

  getLoader(){
    return _loader;
  }

  setLoader(bool newState){
    _loader = newState;
    notifyListeners();
  }

  getHiddenPasswordState(){
    return _hiddenPassword;
  }

  setHiddenPasswordState(){
    _hiddenPassword = !_hiddenPassword;
    notifyListeners();
  }

  Future<User?> loginUser(UserLoginDto userLoginDto) async {
    return await _firebaseService.firebaseLogin(userLoginDto);
  }

  Future<void> signOut() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
  }

  Future<void> registerUser(UserLoginDto userLoginDto) async {
    await _firebaseService.firebaseSignUp(userLoginDto);
    User? user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection("users").doc(user!.uid).set({
      'uid': user.uid,
      'email': userLoginDto.email,
      'password': userLoginDto.password
    });
  }

}