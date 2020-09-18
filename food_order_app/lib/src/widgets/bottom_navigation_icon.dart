import 'package:flutter/material.dart';

import 'custom_text.dart';

class BottomNavIcon extends StatelessWidget {
  final String image;
  final String name;
  final Function onTap;

  BottomNavIcon({@required this.image, @required this.name, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? null,
      child: Column(
        children: [
          Image.asset(
            "images/$image",
            width: 24,
            height: 24,
          ),
          SizedBox(height: 2,),
          CustomText(text: name,),
        ],
      ),
    );
  }
}