import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food_order_app/src/helpers/screen_navigation.dart';
import 'package:food_order_app/src/helpers/style.dart';
import 'package:food_order_app/src/providers/category.dart';
import 'package:food_order_app/src/providers/user.dart';
import 'package:food_order_app/src/screens/bag.dart';
import 'package:food_order_app/src/widgets/bottom_navigation_icon.dart';
import 'package:food_order_app/src/widgets/categories.dart';
import 'package:food_order_app/src/widgets/custom_text.dart';
import 'package:food_order_app/src/widgets/featured_products.dart';
import 'package:food_order_app/src/widgets/small_floating_button.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);

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
      body: SafeArea(
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
                      decoration: InputDecoration(
                        hintText: "Find food and restaurants",
                        border: InputBorder.none,
                      ),
                    ),
                    trailing: Icon(
                      Icons.filter_list,
                      color: red,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoryProvider.categories.length,
                itemBuilder: (context, index) {
                  return CategoryWidget(category: categoryProvider.categories[index],);
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

                  CustomText(text: "see all", size: 14, color: primary,),
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

                  CustomText(text: "see all", size: 14, color: primary,),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset("images/food.jpg"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SmallButton(Icons.favorite),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Container(
                            width: 50,
                            decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Icon(
                                    Icons.star,
                                    color: Colors.yellow[900],
                                    size: 20,
                                  ),
                                ),
                                Text("4.5"),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            // Box decoration takes a gradient
                            gradient: LinearGradient(
                                // Where the linear gradient begins and ends
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,

                                // Add one stop for each color. Stops should increase from 0 to 1
                                colors: [
                                  // Colors are easy thanks to Flutter's Colors class
                                  Colors.black.withOpacity(0.8),
                                  Colors.black.withOpacity(0.7),
                                  Colors.black.withOpacity(0.6),
                                  Colors.black.withOpacity(0.6),
                                  Colors.black.withOpacity(0.4),
                                  Colors.black.withOpacity(0.1),
                                  Colors.black.withOpacity(0.05),
                                  Colors.black.withOpacity(0.025),
                                ])),
                      ),
                    ),
                  ),
                  Positioned.fill(
                      child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
                          child: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: "Santos Tacho \n",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: "avg meal price: ",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300)),
                              TextSpan(
                                  text: "\$5.99 \n",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ], style: TextStyle(color: white),),
                          ),
                        ),
                      ],
                    ),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
