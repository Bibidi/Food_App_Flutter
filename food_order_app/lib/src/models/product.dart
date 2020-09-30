import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  static const ID = "id";
  static const NAME = "name";
  static const RATING = "rating";
  static const RATES = "rates";
  static const IMAGE = "image";
  static const PRICE = "price";
  static const DESCRIPTION = "description";
  static const RESTAURANT_ID = "restaurantId";
  static const RESTAURANT = "restaurant";
  static const CATEGORY = "category";
  static const FEATURED = "featured";


  String _id;
  String _name;
  double _rating;
  int _rates;
  String _image;
  double _price;
  String _description;
  String _restaurantId;
  String _restaurant;
  String _category;
  bool _featured;

  // getters
  String get id => _id;

  String get name => _name;

  bool get featured => _featured;

  String get category => _category;

  String get description => _description;

  String get restaurant => _restaurant;

  String get restaurantId => _restaurantId;

  double get price => _price;

  String get image => _image;

  int get rates => _rates;

  double get rating => _rating;

  ProductModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data()[ID];
    _name = snapshot.data()[NAME];
    _image = snapshot.data()[IMAGE];
    _rating = snapshot.data()[RATING].toDouble();
    _rates = snapshot.data()[RATES];

    _price = snapshot.data()[PRICE].toDouble();
    _description = snapshot.data()[DESCRIPTION];
    _restaurantId = snapshot.data()[RESTAURANT_ID];
    _restaurant = snapshot.data()[RESTAURANT];
    _category = snapshot.data()[CATEGORY];
    _featured = snapshot.data()[FEATURED];
  }
}