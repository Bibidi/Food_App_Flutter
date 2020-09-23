import 'package:flutter/material.dart';
import 'package:food_order_app/src/models/category.dart';

import '../helpers/style.dart';
import 'custom_text.dart';

List<CategoryModel> categoryList = [];

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoryList.length,
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
                          offset: Offset(4, 6),
                          blurRadius: 20
                      )
                    ],
                  ),
                  child: Padding(padding: EdgeInsets.all(4),
                    child: Image.asset("images/${categoryList[index].image}", width: 50,),
                  ),
                ),
                SizedBox(height: 10,),
                CustomText(text: categoryList[index].name, size: 14, color: black,),
              ],
            ),
          );
        },
      ),
    );
  }
}
