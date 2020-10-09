import 'package:flutter/material.dart';
import 'package:food_order_app/src/helpers/style.dart';
import 'package:food_order_app/src/models/order.dart';
import 'package:food_order_app/src/providers/app.dart';
import 'package:food_order_app/src/providers/user.dart';
import 'package:food_order_app/src/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: white,
        elevation: 0.0,
        title: CustomText(
          text: "Orders",
        ),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: userProvider.orders.length,
        itemBuilder: (_, index) {
          OrderModel _order = userProvider.orders[index];
          return ListTile(
            leading: CustomText(
              text: "\$${_order.total / 100}",
              weight: FontWeight.bold,
            ),
            title: Text(_order.description),
            subtitle: Text(DateTime.fromMillisecondsSinceEpoch(_order.createdAt).toString()),
            trailing: CustomText(text: _order.status, color: green,),
          );
        },),
    );
  }
}
