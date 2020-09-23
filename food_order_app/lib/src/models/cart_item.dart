import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  static const ID = "id";
  static const PRODUCT_ID = "productId";
  static const NAME = "name";
  static const IMAGE = "image";
  static const PRICE = "price";
  static const QUANTITY = "quantity";

  String _id;
  String _productId;
  String _name;
  String _image;
  double _price;
  int _quantity;

  // getter
  String get id => _id;
  String get productId => _productId;
  String get name => _name;
  String get image => _image;
  double get price => _price;
  int get quantity => _quantity;

  CartModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data()[ID];
    _productId = snapshot.data()[PRODUCT_ID];
    _name = snapshot.data()[NAME];
    _image = snapshot.data()[IMAGE];
    _price = snapshot.data()[PRICE];
    _quantity = snapshot.data()[QUANTITY];
  }
}