import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:food_order_app/src/helpers/screen_navigation.dart';
import 'package:food_order_app/src/helpers/style.dart';
import 'package:food_order_app/src/models/product.dart';
import 'package:food_order_app/src/providers/app.dart';
import 'package:food_order_app/src/providers/user.dart';
import 'package:food_order_app/src/screens/cart.dart';
import 'package:food_order_app/src/widgets/custom_text.dart';
import 'package:food_order_app/src/widgets/loading.dart';
import 'package:food_order_app/src/widgets/small_floating_button.dart';
import 'package:provider/provider.dart';

class Details extends StatefulWidget {
  final ProductModel product;

  Details({@required this.product});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int quantity = 1;
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      key: _key,
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: white,
        elevation: 0.0,
        actions: [
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: (){
            changeScreen(context, CartScreen());
          }),
        ],
        leading: IconButton(icon: Icon(Icons.close), onPressed: () {Navigator.pop(context);},),
      ),
      backgroundColor: white,
      body: appProvider.isLoading ? Loading() : SafeArea(
        child: appProvider.isLoading ? Loading() : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 120,
              backgroundImage: NetworkImage(widget.product.image),
            ),
            SizedBox(height: 15,),

            CustomText(text: widget.product.name, size: 26, weight: FontWeight.bold,),
            CustomText(text: "\$${widget.product.price}", size: 20, weight: FontWeight.w400,),
            SizedBox(height: 10,),

            CustomText(text: "Description", size: 18, weight: FontWeight.w400,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.product.description ?? "null", textAlign: TextAlign.center, style: TextStyle(color: grey, fontWeight: FontWeight.w300),),
            ),
            SizedBox(height: 15,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(icon: Icon(Icons.remove, size: 36,), onPressed: (){
                    if (quantity > 1) {
                      setState(() {
                        quantity--;
                      });
                    }
                  }),
                ),
                GestureDetector(
                  onTap: () async {
                    appProvider.changeLoading();
                    print("All set loading");

                    bool ok = await userProvider.addToCart(product: widget.product, quantity: quantity);
                    if (ok) {
                      _key.currentState.showSnackBar(
                          SnackBar(content: Text("Added to Cart")));
                      userProvider.reloadUserModel();
                    }
                    else {
                      _key.currentState.showSnackBar(
                          SnackBar(content: Text("Item Not added to Cart")));
                    }
                    appProvider.changeLoading();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: appProvider.isLoading ? Loading() : Padding(
                      padding: const EdgeInsets.fromLTRB(28, 12, 28, 12),
                      child: CustomText(
                        text: "Add $quantity To Cart",
                        color: white,
                        size: 22,
                        weight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(icon: Icon(Icons.add, color: red, size: 36,), onPressed: (){
                    setState(() {
                      quantity++;
                    });
                  }),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
