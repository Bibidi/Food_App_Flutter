import 'package:flutter/material.dart';
import 'package:food_order_app/src/models/category.dart';

import '../commons.dart';
import 'custom_text.dart';

List<Category> categoriesList = [
  Category(name: "Salad", image: "salad.png"),
  Category(name: "Steak", image: "steak.png"),
  Category(name: "Fast food", image: "sandwich.png"),
  Category(name: "Dessert", image: "ice-cream.png"),
  Category(name: "Sea food", image: "fish.png"),
  Category(name: "Beer", image: "pint.png"),
];

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoriesList.length,
        itemBuilder: (_, index){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: white,
                    boxShadow: [
                      BoxShadow(
                          color: red[50],
                          offset: Offset(1, 1),
                          blurRadius: 4
                      )
                    ],
                  ),
                  child: Padding(padding: EdgeInsets.all(4),
                    child: Image.asset("images/${categoriesList[index].image}", width: 50,),
                  ),
                ),
                SizedBox(height: 10,),
                CustomText(text: categoriesList[index].name, size: 14, color: black,),
              ],
            ),
          );
        },
      ),
    );
  }
}
