import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_store/controllers/cart_controller.dart';
import 'package:music_store/controllers/popular_product_controller.dart';
import 'package:music_store/pages/home/main_store_page.dart';
import 'package:music_store/utils/colors.dart';
import 'package:music_store/utils/dimensions.dart';
import 'package:music_store/utils/app_constants.dart';
import 'package:music_store/widgets/app_icon.dart';
import 'package:music_store/widgets/big_text.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/location_controller.dart';
import '../../controllers/recommended_product_controller.dart';
import '../../routes/route_helper.dart';
import '../../widgets/small_text.dart';
import '../../widgets/title_text.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor1,
      body: Stack(
        children: [
          Positioned(
              top: Dimensions.height20*3,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcon(icon: Icons.arrow_back_ios_new,iconColor: Colors.white,backgroundColor: AppColors.mainColor,iconSize: Dimensions.radius24,),
                  SizedBox(width: Dimensions.radius20*5,),
                  GestureDetector(
                      onTap: (){
                        Get.toNamed(RouteHelper.getInitial());
                      },
                      child: AppIcon(icon: Icons.home_outlined,iconColor: Colors.white,backgroundColor: AppColors.mainColor,iconSize: Dimensions.radius24,)),
                  AppIcon(icon: Icons.shopping_cart,iconColor: Colors.white,backgroundColor: AppColors.mainColor,iconSize: Dimensions.radius24,)
                ],
              )),
          Positioned(
              top: Dimensions.height20*5,
              left: Dimensions.width20,
              right: Dimensions.width20,
              bottom: 0,
              child:  Container(
                margin: EdgeInsets.only(top: Dimensions.height15),
                // color: AppColors.mainColor,
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: GetBuilder<CartController>(builder: (cartController){
                    var _cartList = cartController.getItems;
                    return ListView.builder(
                        itemCount: cartController.getItems.length,
                        itemBuilder: (_,index){
                          return Container(
                            height: Dimensions.height20*5,
                            width: double.maxFinite,
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    var popularIndex = Get.find<PopularProductController>().popularProductList.indexOf(_cartList[index].product!);
                                    if (popularIndex>=0){
                                      Get.toNamed(RouteHelper.getPopularProduct(popularIndex,"cartpage"));
                                    }else{
                                      var recommendedIndex = Get.find<RecommendedProductController>().recommendedProductList.indexOf(_cartList[index].product!);
                                      if(recommendedIndex<0){
                                        Get.snackbar("History Product", "Product review is not available for history products.",
                                            backgroundColor: AppColors.mainColor,colorText: Colors.white);
                                      }else{
                                        Get.toNamed(RouteHelper.getRecommendedProduct(recommendedIndex,"cartpage"));
                                      }
                                    }
                                  },
                                  child: Container(
                                    width: Dimensions.width20*5,
                                    height: Dimensions.height20*5.5,
                                    margin: EdgeInsets.only(bottom: Dimensions.height10),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              AppConstants.BASE_URL+AppConstants.UPLOAD_URL+cartController.getItems[index].img!
                                          ),
                                        ),
                                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                                    ),
                                  ),
                                ),
                                SizedBox(width: Dimensions.width10,),
                                Expanded(child: Container(
                                    height: Dimensions.height20*4.8,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        BigText(text: cartController.getItems[index].name!,color: Colors.black54,),
                                        SmallText(text: "Electric",),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            BigText(text: "\$ ${cartController.getItems[index].price}", color: AppColors.mainColor),
                                            Container(
                                              padding: EdgeInsets.only(top: Dimensions.height10/2,bottom: Dimensions.height10/2,left: Dimensions.width10,right: Dimensions.width10),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(15),
                                                  color: Colors.white
                                              ),
                                              child: Row(
                                                children: [
                                                  GestureDetector(
                                                      onTap: (){
                                                        cartController.addItem(_cartList[index].product!, -1);
                                                      },
                                                      child: Icon(Icons.remove,color: AppColors.signColor,)),
                                                  SizedBox(width: Dimensions.width10,),
                                                  BigText(text: _cartList[index].quantity.toString()), //popularProduct.inCartItem.toString()
                                                  SizedBox(width: Dimensions.width10,),
                                                  GestureDetector(
                                                      onTap: (){
                                                        cartController.addItem(_cartList[index].product!, 1);
                                                      },
                                                      child: Icon(Icons.add,color: AppColors.signColor,))
                                                ],
                                              ),
                                            )
                                          ],
                                        )
                                      ],

                                    )
                                ))
                              ],
                            ),
                          );
                        });
                  },),
                ),
              ))
        ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(builder: (cartController){
        return Container(
          height: Dimensions.height45*1.61,
          padding: EdgeInsets.only(top: Dimensions.height30/2,bottom: Dimensions.height30/2,left: Dimensions.width20,right: Dimensions.width20),
          decoration: BoxDecoration(
              color: AppColors.backgroundColor2,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius15),
                  topRight: Radius.circular(Dimensions.radius15)
              )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(top: Dimensions.height20/2,bottom: Dimensions.height20/2,left: Dimensions.width20,right: Dimensions.width20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white
                ),
                child: Row(
                  children: [
                    SizedBox(width: Dimensions.width10/2,),
                    BigText(text: "${cartController.totalAmount} \$"),
                    SizedBox(width: Dimensions.width10/2,),
                  ],
                ),
              ),
              GestureDetector(
                onTap:(){
                  if(Get.find<AuthController>().userLoggedIn()){
                    // if(Get.find<LocationController>().addressList.isEmpty){
                    //   // Get.toNamed(RouteHelper.getAddressPage());
                    // }else{
                      cartController.addToHistory();
                      Get.offNamed(RouteHelper.getInitial());
                    //}
                  }else{
                    Get.toNamed(RouteHelper.getSignInPage());
                  }
                },
                child: Container(
                  padding: EdgeInsets.only(top: Dimensions.height20/2,bottom: Dimensions.height20/2,left: Dimensions.width20,right: Dimensions.width20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                      color: AppColors.mainColor
                  ),
                  child: TitleText(text: "Check Out",color: Colors.white,),
                ),
              )
            ],
          ),
        );
      },),//add to cart navigation bar

    );
  }
}
