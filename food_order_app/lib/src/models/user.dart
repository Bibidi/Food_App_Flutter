import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_order_app/src/models/cart_item.dart';

class UserModel {
  static const NAME = "name";
  static const EMAIL = "email";
  static const ID = "id";
  static const STRIPE_ID = "stripeId";
  static const CART = "cart";

  String _name;
  String _email;
  String _id;
  String _stripeId;

  // getters
  String get name => _name;
  String get email => _email;
  String get id => _id;
  String get stripeId => _stripeId;

  // public variable
  List cart;

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    _name = snapshot.data()[NAME];
    _email = snapshot.data()[EMAIL];
    _id = snapshot.data()[ID];
    _stripeId = snapshot.data()[STRIPE_ID];
    cart = snapshot.data()[CART] ?? [];
  }

  // List<CartItemModel> _convertCartItems(List<Map> cart) {
  //   List<CartItemModel> convertedCart = [];
  //   for (Map cartItem in cart) {
  //     convertedCart.add(CartItemModel.fromMap(cartItem));
  //   }
  //   return convertedCart;
  // }
}