import 'package:flutter/material.dart';
import 'package:food_order_app/src/helpers/restaurant.dart';
import 'package:food_order_app/src/models/restaurant.dart';

class RestaurantProvider with ChangeNotifier {
  RestaurantServices _restaurantServices = RestaurantServices();
  List<RestaurantModel> restaurants = [];

  RestaurantProvider.initialize() {
    _loadRestaurants();
  }

  _loadRestaurants() async {
    restaurants = await _restaurantServices.getRestaurants();
    notifyListeners();
  }
}