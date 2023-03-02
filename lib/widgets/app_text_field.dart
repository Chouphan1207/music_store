import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_store/utils/colors.dart';
import 'package:music_store/utils/dimensions.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final IconData icon;
  bool isObscure;
  AppTextField({Key? key, required this.hintText,required this.icon,required this.textController,this.isObscure=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
        margin: EdgeInsets.symmetric(horizontal: Dimensions.width10),
        decoration: BoxDecoration(
            color: AppColors.backgroundColor3,
            borderRadius: BorderRadius.circular(Dimensions.radius15),//10:05:19
            boxShadow:[ BoxShadow(
                blurRadius: 3,
                spreadRadius: 1,
                offset: Offset(1,1),
                color: Colors.grey.withOpacity(0.18)
            )
            ]
        ),
        child: TextField(
          cursorColor: AppColors.mainColor,
          obscureText: isObscure?true:false,
          controller: textController,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(icon,color: AppColors.mainColor,),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimensions.radius15),
                borderSide: BorderSide(
                    width: 1.0,
                    color: AppColors.backgroundColor3
                )
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimensions.radius15),
                borderSide: BorderSide(
                    width: 1.0,
                    color: AppColors.backgroundColor3
                )
            ),
          ),
        )
    );
  }
}
