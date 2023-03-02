import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_store/utils/colors.dart';
import 'package:music_store/utils/dimensions.dart';
import 'package:music_store/widgets/app_icon.dart';
import 'package:music_store/widgets/big_text.dart';

class AccountWidget extends StatelessWidget {
  AppIcon appIcon;
  BigText bigText;

  AccountWidget({Key? key,required this.appIcon,required this.bigText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimensions.width45*8.2,
      padding: EdgeInsets.symmetric(
          vertical: Dimensions.height10,
          horizontal: Dimensions.width20
      ),
    margin: EdgeInsets.only(top: Dimensions.height10/10),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(Dimensions.radius15),
        color: AppColors.backgroundColor1,
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            offset: Offset(0, 2),
            color: Colors.grey.withOpacity(0.2),
          )

        ]
      ),
      child: Row(
        children: [
          appIcon,
          SizedBox(width: Dimensions.width20,),
          bigText
        ],
      ),
    );
  }
}
