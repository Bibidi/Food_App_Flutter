import 'package:flutter/material.dart';
import 'package:food_order_app/src/helpers/screen_navigation.dart';
import 'package:food_order_app/src/helpers/style.dart';
import 'package:food_order_app/src/providers/app.dart';
import 'package:food_order_app/src/providers/product.dart';
import 'package:food_order_app/src/providers/restaurant.dart';
import 'package:food_order_app/src/screens/restaurant.dart';
import 'package:food_order_app/src/widgets/custom_text.dart';
import 'package:food_order_app/src/widgets/loading.dart';
import 'package:food_order_app/src/widgets/restaurant.dart';
import 'package:provider/provider.dart';

class RestaurantSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final restaurantProvider = Provider.of<RestaurantProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: white,
        leading: IconButton(icon: Icon(Icons.close), onPressed: (){
          Navigator.pop(context);
        },),
        title: CustomText(text: "Restaurants", size: 30,),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: (){})
        ],
      ),

      body: appProvider.isLoading ? Loading() : restaurantProvider.searchedRestaurants.length < 1 ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search, color: grey, size: 20,),
            SizedBox(
              height: 15,
            ),
            CustomText(text: "No Restaurants Found", color: grey, weight: FontWeight.w300, size: 22,),
          ],
        ),
      ) : ListView.builder(
        itemCount: restaurantProvider.searchedRestaurants.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              appProvider.changeLoading();
              await productProvider.loadProductsByRestaurant(restaurantId: restaurantProvider.searchedRestaurants[index].id);
              changeScreen(context, RestaurantScreen(restaurantModel: restaurantProvider.restaurants[index],));
              appProvider.changeLoading();
            },
            child: RestaurantWidget(restaurant: restaurantProvider.searchedRestaurants[index],),
          );
        },
      ),
    );
  }
}