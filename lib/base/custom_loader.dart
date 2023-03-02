import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:music_store/controllers/auth_controller.dart';
import 'package:music_store/utils/colors.dart';
import 'package:music_store/utils/dimensions.dart';
import 'package:get/get.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("printing loading state"+Get.find<AuthController>().isLoading.toString());
    return Center(
      child: Container(
        height: Dimensions.height20*5,
        width: Dimensions.width20*5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.height20*5/2),
          color: AppColors.mainColor
        ),
        alignment: Alignment.center,
        child: const CircularProgressIndicator(color: Colors.white,),
      ),
    );
  }
}
