import 'package:flutter/material.dart';
import 'package:food_order_app/src/helpers/style.dart';
import 'package:food_order_app/src/models/restaurant.dart';
import 'package:food_order_app/src/widgets/small_floating_button.dart';
import 'package:transparent_image/transparent_image.dart';

import 'loading.dart';

class RestaurantWidget extends StatelessWidget {
  final RestaurantModel restaurant;

  const RestaurantWidget({Key key, this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0, left: 2, right: 2, bottom: 4),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Positioned.fill(
                    child: Align(
                  alignment: Alignment.center,
                  child: Container(height: 120, child: Loading()),
                )),
                Center(
                  child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage, image: restaurant.image),
                ),
              ],
            ),
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
                        Text(restaurant.rating.toString()),
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
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "${restaurant.name} \n",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: "avg meal price: ",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w300)),
                        TextSpan(
                            text: "\$${restaurant.avgPrice} \n",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                      style: TextStyle(color: white),
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
