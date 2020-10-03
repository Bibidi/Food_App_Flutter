import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food_order_app/src/helpers/screen_navigation.dart';
import 'package:food_order_app/src/helpers/style.dart';
import 'package:food_order_app/src/providers/app.dart';
import 'package:food_order_app/src/providers/category.dart';
import 'package:food_order_app/src/providers/product.dart';
import 'package:food_order_app/src/providers/restaurant.dart';
import 'package:food_order_app/src/providers/user.dart';
import 'package:food_order_app/src/screens/bag.dart';
import 'package:food_order_app/src/screens/category.dart';
import 'package:food_order_app/src/screens/product_search.dart';
import 'package:food_order_app/src/screens/restaurant.dart';
import 'package:food_order_app/src/screens/restaurant_search.dart';
import 'package:food_order_app/src/widgets/categories.dart';
import 'package:food_order_app/src/widgets/custom_text.dart';
import 'package:food_order_app/src/widgets/featured_products.dart';
import 'package:food_order_app/src/widgets/loading.dart';
import 'package:food_order_app/src/widgets/restaurant.dart';
import 'package:food_order_app/src/widgets/small_floating_button.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final restaurantProvider = Provider.of<RestaurantProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: white),
        elevation: 0.5,
        backgroundColor: primary,
        title: CustomText(
          text: "FoodApp",
          color: white,
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  changeScreen(context, ShoppingBag());
                },
              ),
              Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      color: green,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  )),
            ],
          ),
          Stack(
            children: [
              IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                    color: green,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: black,
                ),
                accountName: CustomText(
                  text: userProvider.userModel?.name ?? "loading",
                  color: white,
                  weight: FontWeight.bold,
                  size: 18,
                ),
                accountEmail: CustomText(
                  text: userProvider.userModel?.email ?? "loading",
                  color: white,
                  weight: FontWeight.bold,
                  size: 18,
                )),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.home),
              title: CustomText(
                text: "Home",
              ),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.fastfood),
              title: CustomText(
                text: "Food I like",
              ),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.restaurant),
              title: CustomText(
                text: "Liked restaurants",
              ),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.bookmark_border),
              title: CustomText(
                text: "My orders",
              ),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.shopping_cart),
              title: CustomText(
                text: "Cart",
              ),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.settings),
              title: CustomText(
                text: "Settings",
              ),
            ),
          ],
        ),
      ),
      backgroundColor: white,
      body: appProvider.isLoading ? Loading() : SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: primary,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, left: 8.0, right: 8.0, bottom: 10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: white,
                  ),
                  child: ListTile(
                    leading: Icon(
                      Icons.search,
                      color: red,
                    ),
                    title: TextField(
                      textInputAction: TextInputAction.search,
                      onSubmitted: (pattern) async {
                        appProvider.changeLoading();
                        if (appProvider.search == SearchBy.PRODUCTS) {
                          await productProvider.search(productName: pattern);
                          changeScreen(context, ProductSearchScreen());
                        }
                        else if (appProvider.search == SearchBy.RESTAURANTS) {
                          await restaurantProvider.search(name: pattern);
                          changeScreen(context, RestaurantSearchScreen());
                        }
                        appProvider.changeLoading();
                      },
                      decoration: InputDecoration(
                        hintText: "Find food and restaurants",
                        border: InputBorder.none,
                      ),
                    ),
                  )
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomText(text: "Search by: ", color: grey, weight: FontWeight.w300,),
                DropdownButton<String>(
                  underline: Container(
                    color: white,
                  ),
                  value: appProvider.filterBy,
                  style: TextStyle(
                    color: primary,
                    fontWeight: FontWeight.w300
                  ),
                  icon: Icon(
                      Icons.filter_list,
                      color: primary),
                  elevation: 0,
                  onChanged: (value) {
                    if (value == "Products") {
                      appProvider.changeSearchBy(newSearchBy: SearchBy.PRODUCTS);
                    }
                    else if (value == "Restaurants") {
                      appProvider.changeSearchBy(newSearchBy: SearchBy.RESTAURANTS);
                    }
                  },
                  items: <String>["Products", "Restaurants"].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),

                ),
              ],
            ),
            Divider(),

            SizedBox(
              height: 10,
            ),

            // Category
            Container(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoryProvider.categories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      // appProvider.changeLoading();
                      await productProvider.loadProductsByCategory(categoryName: categoryProvider.categories[index].name);
                      // appProvider.changeLoading();
                      changeScreen(context, CategoryScreen(categoryModel: categoryProvider.categories[index],));
                    },
                    child: CategoryWidget(
                      category: categoryProvider.categories[index],
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "Featured",
                    size: 20,
                    color: grey,
                  ),
                  CustomText(
                    text: "see all",
                    size: 14,
                    color: primary,
                  ),
                ],
              ),
            ),
            Featured(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "Popular",
                    size: 20,
                    color: grey,
                  ),
                  CustomText(
                    text: "see all",
                    size: 14,
                    color: primary,
                  ),
                ],
              ),
            ),
            Column(
              children: restaurantProvider.restaurants
                  .map((item) => GestureDetector(
                        onTap: () async {
                          // appProvider.changeLoading();
                          await productProvider.loadProductsByRestaurant(restaurantId: item.id);
                          // appProvider.changeLoading();

                          changeScreen(context, RestaurantScreen(restaurantModel: item,));
                        },
                        child: RestaurantWidget(
                          restaurant: item,
                        ),
                      ))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}
