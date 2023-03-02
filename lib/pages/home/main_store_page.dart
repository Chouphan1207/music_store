import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:music_store/base/custom_loader.dart';
import 'package:music_store/controllers/user_controller.dart';
import 'package:music_store/utils/colors.dart';
import 'package:music_store/utils/dimensions.dart';
import 'package:music_store/widgets/big_text.dart';
import 'package:music_store/widgets/small_text.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';
import 'guitar_page_body.dart';


class MainStorePage extends StatefulWidget {
  const MainStorePage({Key? key}) : super(key: key);

  @override
  State<MainStorePage> createState() => _MainStorePageState();
}

class _MainStorePageState extends State<MainStorePage> {
  Future<void> _loadResources() async{
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }
  @override
  Widget build(BuildContext context) {

    bool  _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if(_userLoggedIn){
      Get.find<UserController>().getUserInfo();
      // print("User has logged in");
    }
    //print("current height is ${MediaQuery.of(context).size.height}");
    return GetBuilder<UserController>(builder: (userController){
      return _userLoggedIn?(userController.isLoading?RefreshIndicator(
          onRefresh: _loadResources,
          child: Column(
            children: [
              //header
              Container(
                decoration: BoxDecoration(
                    color: AppColors.backgroundColor2,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade400,
                          blurRadius: 15.0,
                          spreadRadius: 1,
                          offset: -Offset(6,6)
                      ),
                      BoxShadow(
                          color: Colors.grey.shade400,
                          blurRadius: 15.0,
                          spreadRadius: 1,
                          offset: -Offset(5.5,5.5)
                      ),]
                ),
                child: Container(
                  margin: EdgeInsets.only(top: Dimensions.height50, bottom: Dimensions.height15),
                  padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(

                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BigText(text: "Hello, ${_userLoggedIn?userController.userModel.name.toString():"Stranger"}!",color: AppColors.mainColor,),
                          SmallText(text: "Feeling like looking for a new guitar?",color: AppColors.textColorWhite,),
                        ],
                      ),
                      GestureDetector(
                        onTap: (){

                        },
                        child: Container(
                          width: Dimensions.width45*1.4,
                          height: Dimensions.height45*1.4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.radius15/2),
                              image: const DecorationImage(
                                image: AssetImage(
                                  "assets/image/logo3.png",
                                ),
                                fit: BoxFit.fitWidth,
                              )
                          ),
                          // child: Icon(Icons.search, color: Colors.white,size: Dimensions.radius24,),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              //body
              Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                        color: AppColors.backgroundColor3,
                        child: GuitarPageBody()),
                  )),
            ],

          )
      ):
      CustomLoader()):
      RefreshIndicator(
          color: AppColors.mainColor,
          backgroundColor: AppColors.backgroundColor1,
          onRefresh: _loadResources,
          child: Column(
            children: [
              //header
              Container(
                decoration: BoxDecoration(
                    color: AppColors.backgroundColor2,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade400,
                          blurRadius: 15.0,
                          spreadRadius: 1,
                          offset: -Offset(6,6)
                      ),
                      BoxShadow(
                          color: Colors.grey.shade400,
                          blurRadius: 15.0,
                          spreadRadius: 1,
                          offset: -Offset(5.5,5.5)
                      ),]
                ),
                child: Container(
                  margin: EdgeInsets.only(top: Dimensions.height50, bottom: Dimensions.height15),
                  padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(

                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BigText(text: "Hello, ${_userLoggedIn?userController.userModel.name.toString():"Stranger"}!",color: AppColors.mainColor,),
                          SmallText(text: "Feeling like looking for a new guitar?",color: AppColors.textColorWhite,),
                        ],
                      ),
                      GestureDetector(
                        onTap: (){

                        },
                        child: Container(
                          width: Dimensions.width45*1.4,
                          height: Dimensions.height45*1.4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.radius15/2),
                            image: const DecorationImage(
                                image: AssetImage(
                              "assets/image/logo3.png",
                              ),
                              fit: BoxFit.fitWidth,
                            )
                          ),
                          // child: Icon(Icons.search, color: Colors.white,size: Dimensions.radius24,),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              //body
              Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                        color: AppColors.backgroundColor3,
                        child: GuitarPageBody()),
                  )),
            ],

          )
      )
      ;
    });
  }
}
