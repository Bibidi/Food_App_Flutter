import 'package:flutter/material.dart';
import 'package:food_order_app/src/helpers/order.dart';
import 'package:food_order_app/src/helpers/style.dart';
import 'package:food_order_app/src/models/cart_item.dart';
import 'package:food_order_app/src/models/product.dart';
import 'package:food_order_app/src/providers/app.dart';
import 'package:food_order_app/src/providers/user.dart';
import 'package:food_order_app/src/widgets/custom_text.dart';
import 'package:food_order_app/src/widgets/loading.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _key = GlobalKey<ScaffoldState>();
  OrderServices _orderServices = OrderServices();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);

    // appProvider.addPrice(newPrice: userProvider.userModel.cart[index]["price"]);
    // appProvider.addQuantity(newQuantity: userProvider.userModel.cart[index]["quantity"]);
    // appProvider.getTotalPrice();

    return Scaffold(
      key: _key,
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: white,
        elevation: 0.0,
        title: CustomText(
          text: "Shopping Cart",
        ),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: white,
      body: appProvider.isLoading ? Loading() : ListView.builder(
          itemCount: userProvider.userModel.cart.length,
          itemBuilder: (_, index) {
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
                    ]),
                child: Row(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                      child: Image.network(
                        userProvider.userModel.cart[index].image,
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
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: userProvider.userModel.cart[index]
                                          .name +
                                      "\n",
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text:
                                      "\$${userProvider.userModel.cart[index].price.toString()}" +
                                          "\n\n",
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w300)),
                              TextSpan(
                                  text: "Quantity: ",
                                  style: TextStyle(
                                      color: grey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400)),
                              TextSpan(
                                  text: userProvider
                                      .userModel.cart[index].quantity
                                      .toString(),
                                  style: TextStyle(
                                      color: primary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400)),
                            ]),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: red,
                              ),
                              onPressed: () async {
                                appProvider.changeLoading();
                                bool ok = await userProvider.removeFromCart(cartItem: userProvider.userModel.cart[index]);
                                if (ok) {
                                  userProvider.reloadUserModel();
                                  _key.currentState.showSnackBar(
                                      SnackBar(content: Text("Remove from Cart")));
                                  appProvider.changeLoading();
                                }
                                else {
                                  print("ITEM WAS NOT REMOVED");
                                  appProvider.changeLoading();
                                }
                              })
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
      bottomNavigationBar: Container(
        height: 70,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: "Total: ",
                      style: TextStyle(
                          color: grey,
                          fontSize: 22,
                          fontWeight: FontWeight.w400)),
                  TextSpan(
                      text: "\$${userProvider.userModel.totalCartPrice}",
                      style: TextStyle(
                          color: primary,
                          fontSize: 22,
                          fontWeight: FontWeight.normal)),
                ]),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: primary,
                ),
                child: FlatButton(
                  onPressed: () {
                    if (userProvider.userModel.totalCartPrice == 0) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(20.0)), //this right here
                              child: Container(
                                height: 200,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Text(
                                          'Your cart is empty.',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                      return;
                    }
                    else {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(20.0)), //this right here
                              child: Container(
                                height: 200,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Text(
                                          'You will be charged ${userProvider.userModel.totalCartPrice} upon delivery',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      SizedBox(height: 20,),
                                      SizedBox(
                                        width: 320.0,
                                        child: RaisedButton(
                                          onPressed: () async {
                                            var uuid = Uuid();
                                            String id = uuid.v4();

                                            // 데이터를 받는 것이 아니라 주고 끝나기 때문에
                                            // await를 안 쓰는 것인가 생각 중.
                                            _orderServices.createOrder(
                                              userId: userProvider.user.uid,
                                              id: id,
                                              description: "Some random description",
                                              status: "complete",
                                              totalPrice: userProvider.userModel.totalCartPrice,
                                              cart: userProvider.userModel.cart,
                                            );

                                            for (CartItemModel cartItem in userProvider.userModel.cart) {
                                              await userProvider.removeFromCart(cartItem: cartItem);
                                            }

                                            userProvider.reloadUserModel();
                                            _key.currentState.showSnackBar(
                                                SnackBar(content: Text("Order Completed")));

                                            Navigator.pop(context);

                                          },
                                          child: Text(
                                            "Accept",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          color: const Color(0xFF1BC0C5),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 320.0,
                                        child: RaisedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Reject",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          color: red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    }
                  },
                  child: CustomText(
                    text: "Check out",
                    size: 20,
                    color: white,
                    weight: FontWeight.normal,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
