import 'package:flutter/material.dart';
import 'package:food_order_app/src/helpers/product.dart';
import 'package:food_order_app/src/models/product.dart';

class ProductProvider with ChangeNotifier {
  ProductServices _productServices = ProductServices();
  List<ProductModel> products = [];
  List<ProductModel> productsByCategory = [];
  List<ProductModel> productsByRestaurant = [];
  List<ProductModel> searchedProducts = [];

  ProductProvider.initialize() {
    _loadRestaurants();
  }

  _loadRestaurants() async {
    products = await _productServices.getProducts();
    notifyListeners();
  }

  Future loadProductsByCategory({String categoryName}) async {
    productsByCategory = await _productServices.getProductsOfCategory(category: categoryName);
    notifyListeners();
  }

  Future loadProductsByRestaurant({String restaurantId}) async {
    productsByRestaurant = await _productServices.getProductsByRestaurant(id: restaurantId);
    notifyListeners();
  }

  Future search({String productName}) async {
    searchedProducts = await _productServices.searchProducts(productName: productName);
    print("THE NUMBER OF PRODUCTS DETECTED IS : ${searchedProducts.length}");
    print("THE NUMBER OF PRODUCTS DETECTED IS : ${searchedProducts.length}");
    print("THE NUMBER OF PRODUCTS DETECTED IS : ${searchedProducts.length}");
    notifyListeners();
  }
}