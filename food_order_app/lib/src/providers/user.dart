import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_order_app/src/helpers/order.dart';
import 'package:food_order_app/src/helpers/user.dart';
import 'package:food_order_app/src/models/cart_item.dart';
import 'package:food_order_app/src/models/order.dart';
import 'package:food_order_app/src/models/product.dart';
import 'package:food_order_app/src/models/user.dart';
import 'package:uuid/uuid.dart';

enum Status { Uninitialized, Unauthenticated, Authenticating, Authenticated }

class UserProvider with ChangeNotifier {
  FirebaseAuth _auth;
  User _user;
  Status _status = Status.Uninitialized;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UserServices _userServices = UserServices();
  OrderServices _orderServices = OrderServices();
  UserModel _userModel;

  // getters
  Status get status => _status;

  UserModel get userModel => _userModel;

  User get user => _user;

  // public variables
  List<OrderModel> orders = [];

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

  UserProvider.initialize() : _auth = FirebaseAuth.instance {
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
        _firestore.collection('users').doc(result.user.uid).set({
          'name': name.text,
          'email': email.text,
          'uid': result.user.uid,
          'likedFoods': [],
          'likedRestaurants': [],
        });
      });
      return true;
    } catch (e) {
      return _onError(e.toString());
    }
  }

  Future<void> reloadUserModel() async {
    _userModel = await _userServices.getUserById(user.uid);
    notifyListeners();
  }

  Future<void> _onStateChanged(User firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Uninitialized;
    } else {
      _user = firebaseUser;
      _status = Status.Authenticated;
      _userModel = await _userServices.getUserById(user.uid);
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

  Future<bool> addToCart({ProductModel product, int quantity}) async {
    try {
      var uuid = Uuid();
      String cartItemId = uuid.v4();
      List cart = _userModel.cart;
      // bool itemExists = false;
      Map cartItem = {
        "id": cartItemId,
        "name": product.name,
        "image": product.image,
        "restaurantId": product.restaurantId,
        "productId": product.id,
        "price": product.price,
        "quantity": quantity,
      };

      CartItemModel item = CartItemModel.fromMap(cartItem);
      _userServices.addToCart(userId: _user.uid, cartItem: item);
      return true;
    } catch(e) {
      return false;
    }
  }

  Future<bool> removeFromCart({CartItemModel cartItem, int quantity}) async {
    print("The PRODUCT IS: ${cartItem.toString()}");

    try {
      _userServices.removeFromCart(userId: _user.uid, cartItem: cartItem);
      return true;
    } catch(e) {
      return false;
    }
  }


  getOrders() async {
    orders = await _orderServices.getUserOrders(userId: _user.uid);
    notifyListeners();
  }

}
