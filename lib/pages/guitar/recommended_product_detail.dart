import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:music_store/utils/dimensions.dart';
import 'package:music_store/utils/app_constants.dart';
import 'package:music_store/widgets/app_icon.dart';

import '../../controllers/cart_controller.dart';
import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../widgets/app_columm.dart';
import '../../widgets/big_text.dart';
import '../../widgets/expandable_text_widget.dart';
import '../../widgets/icon_and_text_widget.dart';
import '../../widgets/small_text.dart';
import '../../widgets/title_text.dart';
import '../cart/cart_page.dart';

class RecommendedProductDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const RecommendedProductDetail({Key? key,required this.page, required this.pageId,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<RecommendedProductController>().recommendedProductList[pageId];
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
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: const AppIcon(icon: Icons.clear,backgroundColor: Colors.black54,iconColor: Colors.white,)),
                // AppIcon(icon: Icons.shopping_cart_outlined,backgroundColor: Colors.black54,iconColor: Colors.white,)
                GetBuilder<PopularProductController>(builder: (controller){
                  return GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.getCartPage());
                    },
                    child: Stack(
                      children: [
                        const AppIcon(icon: Icons.shopping_cart_outlined,backgroundColor: Colors.black54,iconColor: Colors.white,iconSize: 24,),
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
              preferredSize: const Size.fromHeight(90),
              child: Container(
                color: AppColors.backgroundColor1.withOpacity(0.7),
                child:  AppColumn(text: product.name,),
                width: double.maxFinite,
                padding: EdgeInsets.only(top:Dimensions.height15/2,bottom: Dimensions.height15,left: Dimensions.width10/2),
              ),//product name

            ),
            backgroundColor: AppColors.backgroundColor1.withOpacity(0.7),
            pinned: true,
            expandedHeight: Dimensions.expandedProductSizeR,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstants.BASE_URL+AppConstants.UPLOAD_URL+product.img!,
                width: double.maxFinite,
                fit: BoxFit.cover,),

            ),//product picture
          ),// Product title
          SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20,bottom: Dimensions.height10/2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Dimensions.radius20),
                      topLeft: Radius.circular(Dimensions.radius20),
                    ),
                    color: AppColors.backgroundColor1
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
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (controller){
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: AppColors.backgroundColor3,
                  boxShadow: [
                    BoxShadow(
                        color: CupertinoColors.systemGrey5,
                        blurRadius: 5.0,
                        offset: -const Offset(0,5)
                    ),
                    const BoxShadow(
                      color: CupertinoColors.systemGrey5,
                      offset:  Offset(-5,0),
                    )
                  ]
              ),
              padding: EdgeInsets.only(
                  left: Dimensions.width20*3.5,
                  right: Dimensions.width20*3.5,
                  top: Dimensions.height10,
                  bottom: Dimensions.height10/2
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: (){
                        controller.setQuantity(false);
                      },
                      child: AppIcon(iconSize: Dimensions.radius24,iconColor: Colors.white,backgroundColor: AppColors.mainColor,icon: Icons.remove)),
                  BigText(text: "\$${product.price!} X ${controller.inCartItem}" ),
                  GestureDetector(
                      onTap: (){
                        controller.setQuantity(true);
                      },
                      child: AppIcon(iconSize: Dimensions.radius24,iconColor: Colors.white,backgroundColor: AppColors.mainColor,icon: Icons.add))
                ],
              ),
            ),
            Container(
              height: Dimensions.height45*1.61,
              padding: EdgeInsets.only(top: Dimensions.height30/2,bottom: Dimensions.height30/2,left: Dimensions.width20,right: Dimensions.width20),
              decoration: BoxDecoration(
                color: AppColors.backgroundColor2,
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.backgroundColor2,
                        blurRadius: 0.5,
                        offset: -const Offset(0,3)
                    ),
                    BoxShadow(
                      color: AppColors.backgroundColor3,
                      offset:  const Offset(-5,5),
                    )
                  ]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: EdgeInsets.only(top: Dimensions.height20/2,bottom: Dimensions.height20/2,left: Dimensions.width20,right: Dimensions.width20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: CupertinoColors.systemGrey6
                      ),
                      child: Icon(
                        Icons.favorite,
                        color: AppColors.mainColor,
                      )
                  ),
                  GestureDetector(
                    onTap:(){
                      controller.addItem(product);
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: Dimensions.height20/2,bottom: Dimensions.height20/2,left: Dimensions.width20,right: Dimensions.width20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius15),
                          color: AppColors.mainColor,
                      ),
                      child: TitleText(text: "\$ ${product.price!} | Add to cart",color: Colors.white,),
                    ),
                  )
                ],
              ),
            )
          ],
        );
      },),//add to cart navigation bar
    );
  }
}
