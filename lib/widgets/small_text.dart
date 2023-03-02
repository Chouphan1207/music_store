import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  final Color? color;
  final String text;
  double size,height;

  SmallText({Key? key,this.color= Colors.black38,
            required this.text,
            this.size= 12,
            this.height=1.2
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Rubik',
        color: color,
        fontSize: size,
        height: height,
      ),
    );
  }
}
