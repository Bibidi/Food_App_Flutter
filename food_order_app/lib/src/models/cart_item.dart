import 'package:cloud_firestore/cloud_firestore.dart';

  class CartItemModel {
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
  int _price;
  int _quantity;

  // getter
  String get id => _id;
  String get productId => _productId;
  String get name => _name;
  String get image => _image;
  int get price => _price;
  int get quantity => _quantity;

  CartItemModel.fromMap(Map data) {
    _id = data[ID];
    _productId = data[PRODUCT_ID];
    _name = data[NAME];
    _image = data[IMAGE];
    _price = data[PRICE].toDouble();
    _quantity = data[QUANTITY];
  }

  Map toMap() => {
    ID: _id,
    IMAGE: _image,
    NAME: _name,
    PRODUCT_ID: _productId,
    PRICE: _price,
    QUANTITY: _quantity,
  };
}