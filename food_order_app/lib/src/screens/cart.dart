import 'package:flutter/material.dart';
import 'package:food_order_app/src/helpers/style.dart';
import 'package:food_order_app/src/models/product.dart';
import 'package:food_order_app/src/providers/user.dart';
import 'package:food_order_app/src/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: white,
        elevation: 0.0,
        title: CustomText(text: "Shopping Cart",),
        leading: IconButton(icon: Icon(Icons.close), onPressed: () {Navigator.pop(context);},),
      ),
      backgroundColor: white,
      body: ListView.builder(
        itemCount: userProvider.userModel.cart.length,
        itemBuilder: (_, index) {
          List shoppingCart = userProvider.userModel.cart;
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: white,
                  boxShadow: [
                    BoxShadow(
                      color: red[50],
                      offset: Offset(3, 2),
                      blurRadius: 30,
                    )
                  ]
              ),
              child: Row(
                children: <Widget> [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                    child: Image.network(
                      userProvider.userModel.cart[index]["image"],
                      height: 120,
                      width: 140,
                      fit: BoxFit.fill,
                    ),
                  ),

                  SizedBox(
                    width: 10,
                  ),

                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        RichText(text: TextSpan(children: [
                          TextSpan(text: userProvider.userModel.cart[index]["name"] + "\n", style: TextStyle(color: black, fontSize: 20, fontWeight: FontWeight.bold)),
                          TextSpan(text: "\$${userProvider.userModel.cart[index]["price"].toString()}" + "\n\n", style: TextStyle(color: black, fontSize: 18, fontWeight: FontWeight.w300)),
                          TextSpan(text: "Quantity: ", style: TextStyle(color: grey, fontSize: 16, fontWeight: FontWeight.w400)),
                          TextSpan(text: userProvider.userModel.cart[index]["quantity"].toString(), style: TextStyle(color: primary, fontSize: 16, fontWeight: FontWeight.w400)),
                        ]),),
                        SizedBox(
                          width: 10,
                        ),

                        IconButton(icon: Icon(Icons.delete, color: red,), onPressed: null)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      ),
      bottomNavigationBar: Container(
        height: 70,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(text: TextSpan(children: [
                TextSpan(text: "Total: ", style: TextStyle(color: grey, fontSize: 22, fontWeight: FontWeight.w400)),
                TextSpan(text: "\$79", style: TextStyle(color: primary, fontSize: 22, fontWeight: FontWeight.normal)),
              ]),),

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: primary,
                ),
                child: FlatButton(onPressed: (){}, child: CustomText(text: "Pay Now", size: 20, color: white, weight: FontWeight.normal,),),
              )

            ],
          ),
        ),
      ),
    );
  }
}
