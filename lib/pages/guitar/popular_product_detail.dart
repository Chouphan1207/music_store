import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:music_store/controllers/popular_product_controller.dart';
import 'package:music_store/pages/cart/cart_page.dart';
import 'package:music_store/utils/dimensions.dart';
import 'package:music_store/widgets/app_icon.dart';

import '../../controllers/cart_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../widgets/app_columm.dart';
import '../../utils/app_constants.dart';
import '../../widgets/big_text.dart';
import '../../widgets/expandable_text_widget.dart';
import '../../widgets/icon_and_text_widget.dart';
import '../../widgets/small_text.dart';
import '../../widgets/title_text.dart';
import '../cart/cart_page.dart';
import '../cart/cart_page.dart';

class PopularProductDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const PopularProductDetail({Key? key,required this.pageId, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>().initProduct(product,Get.find<CartController>());

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: Dimensions.height15*7,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: (){
                      if(page=="cartpage"){
                        Get.toNamed(RouteHelper.getCartPage());
                      }else{
                        Get.toNamed(RouteHelper.getInitial());
                      }
                    },
                    child: AppIcon(icon: Icons.arrow_back_ios_sharp,backgroundColor: Colors.black54,iconColor: Colors.white,iconSize: 20)
                ),

                GetBuilder<PopularProductController>(builder: (controller){
                  return GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.getCartPage());
                    },
                    child: Stack(children: [
                      AppIcon(icon: Icons.shopping_cart,backgroundColor: Colors.black54,iconColor: Colors.white,iconSize: 24,),
                      Get.find<PopularProductController>().totalItems>=1?
                      Positioned(
                          right:0,top:0,
                          child: AppIcon(icon: Icons.circle, size: 20,iconColor: Colors.transparent,backgroundColor: AppColors.mainColor,)):
                      Container(),
                      Get.find<PopularProductController>().totalItems>=1?
                      Positioned(
                          right:5,top:3,
                          child: BigText(text: Get.find<PopularProductController>().totalItems.toString(),
                          size: 12,color: Colors.white,
                          ),
                      ):
                      Container(),

                    ],),
                  );
                }),


        ],
      ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(90),
              child: Container(
                color: AppColors.backgroundColor1.withOpacity(0.7),
                child:  AppColumn(text: product.name,),
                width: double.maxFinite,
                padding: EdgeInsets.only(top:Dimensions.height15/2,bottom: Dimensions.height15/2,left: Dimensions.width10/2),
              ),//product name

            ),
            backgroundColor: Colors.white,
            pinned: true,
            expandedHeight: Dimensions.expandedProductSizeP,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstants.BASE_URL+AppConstants.UPLOAD_URL+product.img!,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),

            ),//product picture
          ), // Product title

          SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20,bottom: Dimensions.height10/2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Dimensions.radius20),
                      topLeft: Radius.circular(Dimensions.radius20),
                    ),
                    color: AppColors.backgroundColor1,
                ),
                child: Column(//product introduction
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Dimensions.height10,),
                    BigText(text: "Introduce",color: Colors.black,),
                    SizedBox(height: Dimensions.height10/2,),
                    ExpandableTextWidget(text: product.description!)

                  ],
                ),
              ))//scrollable product descriptions
        ],
      ),

      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (popularProduct){
        return Container(
          height: Dimensions.height45*1.65,
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
                    GestureDetector(
                        onTap: (){
                          popularProduct.setQuantity(false);
                        },
                        child: Icon(Icons.remove,color: AppColors.signColor,)),
                    SizedBox(width: Dimensions.width10,),
                    BigText(text: popularProduct.inCartItem.toString()),
                    SizedBox(width: Dimensions.width10,),
                    GestureDetector(
                        onTap: (){
                          popularProduct.setQuantity(true);
                        },
                        child: Icon(Icons.add,color: AppColors.signColor,))
                  ],
                ),
              ),
              GestureDetector(
                onTap:(){
                  popularProduct.addItem(product);
                },
                child: Container(
                  padding: EdgeInsets.only(top: Dimensions.height20/2,bottom: Dimensions.height20/2,left: Dimensions.width20,right: Dimensions.width20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                      color: AppColors.mainColor
                  ),
                      child: TitleText(text: "\$ ${product.price!} | Add to cart",color: Colors.white,),
                ),
              )
            ],
          ),
        );
      },),//add to cart navigation bar
    );
  }
}
