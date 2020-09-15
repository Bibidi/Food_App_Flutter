import 'package:flutter/material.dart';

import 'custom_text.dart';

class BottomNavIcon extends StatelessWidget {
  final String image;
  final String name;

  const BottomNavIcon({Key key, this.image, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          "images/$image",
          width: 24,
          height: 24,
        ),
        SizedBox(height: 2,),
        CustomText(text: name,),
      ],
    );
  }
}