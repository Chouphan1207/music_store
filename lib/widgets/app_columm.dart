import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_store/models/products_model.dart';
import 'package:music_store/widgets/small_text.dart';import '../controllers/popular_product_controller.dart';

import 'package:get/get.dart';
import '../utils/colors.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';
import 'icon_and_text_widget.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({Key? key,required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetBuilder<PopularProductController>(builder: (popularProducts){
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BigText(text: text,size: Dimensions.font23,color: AppColors.textColorDark,),
            SizedBox(height: Dimensions.height10),
            Row(
              children: [
                Wrap(
                    children: List.generate(5, (index) {return Icon(Icons.star, color: Colors.orangeAccent,size: Dimensions.radius15);})
                ),
                SizedBox(width: Dimensions.width10,),
                SmallText(text: "4.5"),
                SizedBox(width: Dimensions.width10*2,),
                SmallText(text: "12"),
                SizedBox(width: Dimensions.width10,),
                SmallText(text: "comments")
              ],
            ),
            SizedBox(height: Dimensions.height7,),
            Row(
              children: [
                IconAndTextWidgets(icon: Icons.attach_money, text: "90M VND",iconColor: AppColors.iconColor2),
              ],
            )
          ],
        );
    },
    )
    );
  }
}
