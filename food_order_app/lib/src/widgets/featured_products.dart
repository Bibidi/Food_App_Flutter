import 'package:flutter/material.dart';
import 'package:food_order_app/src/helpers/screen_navigation.dart';
import 'package:food_order_app/src/models/product.dart';
import 'package:food_order_app/src/screens/details.dart';

import '../helpers/style.dart';
import 'custom_text.dart';

List<ProductModel> productList = [];

class Featured extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: productList.length,
          itemBuilder: (_, index) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(12, 14, 16, 12),
              child: GestureDetector(
                onTap: () {
                  changeScreen(_, Details(product: productList[index],));
                },
                child: Container(
                  height: 220,
                  width: 200,
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey[300],
                          offset: Offset(-2, -1),
                          blurRadius: 5)
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                        child: Image.asset(
                          "images/${productList[index].image}",
                          height: 126,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomText(
                              text: productList[index].name,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: white,
                                boxShadow: [
                                  BoxShadow(
                                      color: grey[300],
                                      offset: Offset(1, 1),
                                      blurRadius: 4)
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Icon(
                                  Icons.favorite,
                                  color: red,
                                  size: 18,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: CustomText(text: productList[index].rating.toString(), color: Colors.grey, size: 14,),
                              ),
                              SizedBox(width: 2,),
                              Icon(Icons.star, color: red, size: 16,),
                              Icon(Icons.star, color: red, size: 16,),
                              Icon(Icons.star, color: red, size: 16,),
                              Icon(Icons.star, color: grey, size: 16,),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0,),
                            child: CustomText(text: "\$${productList[index].price}", weight: FontWeight.bold,),
                          )
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}

