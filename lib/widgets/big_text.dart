import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_store/utils/dimensions.dart';

class BigText extends StatelessWidget {
  final Color? color;
  final String text;
  double size;
  TextOverflow overFlow;
  BigText({Key? key,this.color= Colors.black,
                required this.text,
                this.size= 0,
                this.overFlow= TextOverflow.ellipsis
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
        text,
        maxLines: 2,
        overflow: overFlow,
        style: TextStyle(
          fontFamily: 'Rubik',
          color: color,
          fontSize: size==0?Dimensions.font18:size,
          fontWeight: FontWeight.w400,
        ),
    );
  }
}
