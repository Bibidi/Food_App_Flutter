import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_order_app/src/helpers/user.dart';
import 'package:food_order_app/src/models/user.dart';

enum Status { Uninitialized, Unauthenticated, Authenticating, Authenticated }

class AuthProvider with ChangeNotifier {
  FirebaseAuth _auth;
  FirebaseUser _user;
  Status _status = Status.Uninitialized;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UserServices _userServices = UserServices();
  UserModel _userModel;

//  getters
  Status get status => _status;

  UserModel get userModel => _userModel;

  FirebaseUser get user => _user;

  final formKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();

  /*
  Provider class를 만들면 생성자를 호출하고 생성자는 initialize를 호출함
  initialize 내에서 Firebase authentication instance를 만들어서
  user authentication state를 FB로부터 읽고 unauthenticated에서
  authenticated(Sign in)로 변하면 이를 인식하고 user change를 반영
  함. (듣기 실력이 부족하여 정확도가 떨어짐)
   */

  AuthProvider.initialize() : _auth = FirebaseAuth.instance {
    _auth.authStateChanges().listen(_onStateChanged);
  }

  Future<bool> signIn() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim());
      return true;
    } catch (e) {
      return _onError(e.toString());
    }
  }

  Future signOut() {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<bool> signUp() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((result) {
        _firestore.collection('users').document(result.user.uid).setData({
          'name': name.text,
          'email': email.text,
          'uid': result.user.uid,
        });
      });
      return true;
    } catch (e) {
      return _onError(e.toString());
    }
  }

  Future<void> _onStateChanged(User firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Uninitialized;
    } else {
      _user = firebaseUser;
      _status = Status.Authenticated;
      _userModel = await _userServices.getUserById(firebaseUser.uid);
    }
    notifyListeners();
  }

//  general methods
  bool _onError(String error) {
    _status = Status.Unauthenticated;
    notifyListeners();
    print("we got an error: " + error);
    return false;
  }

  void clearControllers() {
    email.text = "";
    password.text = "";
    name.text = "";
  }
}
