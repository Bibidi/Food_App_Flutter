import 'package:flutter/material.dart';
import 'package:food_order_app/src/helpers/screen_navigation.dart';
import 'package:food_order_app/src/helpers/style.dart';
import 'package:food_order_app/src/providers/product.dart';
import 'package:food_order_app/src/screens/details.dart';
import 'package:food_order_app/src/widgets/custom_text.dart';
import 'package:food_order_app/src/widgets/product.dart';
import 'package:provider/provider.dart';

class ProductSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: white,
        leading: IconButton(icon: Icon(Icons.close), onPressed: (){
          Navigator.pop(context);
        },),
        title: CustomText(text: "Products", size: 30,),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: (){})
        ],
      ),

      body: productProvider.searchedProducts.length < 1 ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search, color: grey, size: 20,),
            SizedBox(
              height: 15,
            ),
            CustomText(text: "No products found", color: grey, weight: FontWeight.w300, size: 22,),
          ],
        ),
      ) : ListView.builder(
        itemCount: productProvider.searchedProducts.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              changeScreen(context, Details(product: productProvider.searchedProducts[index]));
            },
            child: ProductWidget(product: productProvider.searchedProducts[index],),);
        },
      ),
    );
  }
}
