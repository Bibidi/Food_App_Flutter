import 'package:flutter/material.dart';
import 'package:food_order_app/src/helpers/screen_navigation.dart';
import 'package:food_order_app/src/helpers/style.dart';
import 'package:food_order_app/src/models/product.dart';
import 'package:food_order_app/src/providers/product.dart';
import 'package:food_order_app/src/providers/restaurant.dart';
import 'package:food_order_app/src/screens/restaurant.dart';
import 'package:food_order_app/src/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class ProductWidget extends StatelessWidget {
  final ProductModel product;

  const ProductWidget({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final restaurantProvider = Provider.of<RestaurantProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);

    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 4, top: 4, bottom: 10),
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300],
              offset: Offset(-2, -1),
              blurRadius: 5,
            ),
          ]
        ),

        child: Row(
          children: [
            Container(
              width: 140,
              height: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                child: Image.network(product.image, fit: BoxFit.fill,),
              ),
            ),

            Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomText(text: product.name,),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey[300],
                                  offset: Offset(1, 1),
                                  blurRadius: 4,
                                )
                              ]
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Icon(
                                Icons.favorite_border,
                                color: red,
                                size: 18,
                              ),
                            ),

                          ),
                        )
                      ],
                    ),

                    SizedBox(
                      height: 25,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Row(
                        children: [
                          CustomText(text: "from: ", color: grey, weight: FontWeight.w300, size: 14,),
                          SizedBox(width: 10,),
                          GestureDetector(
                            onTap: () async {
                              await productProvider.loadProductsByRestaurant(restaurantId: product.restaurantId);
                              await restaurantProvider.loadSingleRestaurant(restaurantId: product.restaurantId);
                              changeScreen(context, RestaurantScreen(restaurantModel: restaurantProvider.restaurant,));
                            },
                            child: CustomText(text: product.restaurant, color: primary, weight: FontWeight.w300, size: 14,),
                          ),
                        ],
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: CustomText(text: product.rating.toString(), color: grey, size: 14,),
                            ),
                            SizedBox(width: 2,),
                            Icon(Icons.star, color: red, size: 16,),
                            Icon(Icons.star, color: red, size: 16,),
                            Icon(Icons.star, color: red, size: 16,),
                            Icon(Icons.star, color: red, size: 16,),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: CustomText(text: "\$${product.price}", weight: FontWeight.bold,),
                        ),
                      ],
                    )
                  ],
            ))
          ],
        ),
      ),
    );
  }
}
