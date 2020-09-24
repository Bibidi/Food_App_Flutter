import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_order_app/src/models/restaurant.dart';
import '../models/category.dart';

class RestaurantServices {
  String collection = "restaurants";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<RestaurantModel>> getRestaurants() async =>
      _firestore.collection(collection).get().then((result) {
        List<RestaurantModel> restaurants = [];
        for (DocumentSnapshot restaurant in result.docs) {
          restaurants.add(RestaurantModel.fromSnapshot(restaurant));
        }
        return restaurants;
      });
}