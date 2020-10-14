import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  static const ID = "id";
  static const RESTAURANT_IDS = "restaurantIds";
  static const DESCRIPTION = "description";
  static const CART = "cart";
  static const USER_ID = "userId";
  static const TOTAL = "total";
  static const STATUS = "status";
  static const CREATED_AT = "createdAt";

  String _id;
  List _restaurantIds;
  String _description;
  String _userId;
  String _status;
  int _createdAt;
  double _total;


  // getters
  String get id => _id;
  List get restaurantIds => _restaurantIds;
  String get description => _description;
  String get userId => _userId;
  double get total => _total;
  String get status => _status;
  int get createdAt => _createdAt;
  
  // public
  List cart;


  OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data()[ID];
    _restaurantIds = snapshot.data()[RESTAURANT_IDS];
    _description = snapshot.data()[DESCRIPTION];
    _userId = snapshot.data()[USER_ID];
    _total = snapshot.data()[TOTAL];
    _status = snapshot.data()[STATUS];
    _createdAt = snapshot.data()[CREATED_AT];
    cart = snapshot.data()[CART];
  }

}