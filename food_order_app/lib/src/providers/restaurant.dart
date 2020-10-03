import 'package:flutter/material.dart';
import 'package:food_order_app/src/helpers/restaurant.dart';
import 'package:food_order_app/src/models/restaurant.dart';

class RestaurantProvider with ChangeNotifier {
  RestaurantServices _restaurantServices = RestaurantServices();
  List<RestaurantModel> restaurants = [];
  List<RestaurantModel> searchedRestaurants = [];
  RestaurantModel restaurant;

  RestaurantProvider.initialize() {
    _loadRestaurants();
  }

  _loadRestaurants() async {
    restaurants = await _restaurantServices.getRestaurants();
    notifyListeners();
  }

  loadSingleRestaurant({String restaurantId}) async {
    restaurant = await _restaurantServices.getRestaurantById(id: restaurantId);
    notifyListeners();
  }

  Future search({String name}) async {
    searchedRestaurants = await _restaurantServices.searchRestaurants(restaurantName: name);
    print("RESTAURANTS ARE: ${searchedRestaurants.length}");
    notifyListeners();
  }
}