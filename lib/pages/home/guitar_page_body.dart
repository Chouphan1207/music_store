
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_store/controllers/popular_product_controller.dart';
import 'package:music_store/controllers/recommended_product_controller.dart';
import 'package:music_store/models/products_model.dart';
import 'package:music_store/pages/guitar/popular_product_detail.dart';
import 'package:music_store/routes/route_helper.dart';
import 'package:music_store/utils/dimensions.dart';
import 'package:music_store/widgets/big_text.dart';
import 'package:music_store/widgets/icon_and_text_widget.dart';
import 'package:music_store/widgets/small_text.dart';

import '../../utils/colors.dart';
import '../../widgets/app_columm.dart';
import '../../utils/app_constants.dart';
import '../../widgets/title_text.dart';
import 'package:get/get.dart';

class GuitarPageBody extends StatefulWidget {
  const GuitarPageBody({Key? key}) : super(key: key);

  @override
  State<GuitarPageBody> createState() => _GuitarPageBodyState();
}

class _GuitarPageBodyState extends State<GuitarPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  final double _scaleFactor=0.8;
  final double _height= Dimensions.pageViewContainer;

  @override
  void initState(){
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
        print("Current value is $_currPageValue");
      });
    });
  }

  @override
  void dispose(){
    pageController.dispose();
}

  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
            //slider selection
            GetBuilder<PopularProductController>(builder: (popularProducts){
              return popularProducts.isLoaded?Container(
                margin: EdgeInsets.only(top: Dimensions.height10),
                // color: Colors.orangeAccent,
                height: Dimensions.pageView*1.25,
                child: PageView.builder(
                    controller: pageController,
                    itemCount: popularProducts.popularProductList.length,
                    itemBuilder:(context, position){
                      return _buildPageItem(position,popularProducts.popularProductList[position]);
                    }
                ),
              ):CircularProgressIndicator(
                color: AppColors.mainColor,
              );
            }),
            //dots
            GetBuilder<PopularProductController>(builder: (popularProducts){
              return DotsIndicator(
                dotsCount: popularProducts.popularProductList.isEmpty?1:popularProducts.popularProductList.length,
                position: _currPageValue,
                decorator: DotsDecorator(
                  size: const Size.square(9.0),
                  activeColor: AppColors.mainColor,
                  activeSize: const Size(18.0, 9.0),
                  activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                ),
              );
            }),
            //Popular Text
            SizedBox(height: Dimensions.height30,),
            Container(
              margin: EdgeInsets.only(left: Dimensions.width30),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  BigText(text: "Recommended",color: Colors.black38,),
                  SizedBox(width: Dimensions.width10,),
                  Container(
                      margin: const EdgeInsets.only(bottom: 3),
                      child: BigText(text: ".",color: Colors.black26,)
                  ),
                  SizedBox(width: Dimensions.width10,),
                  Container(
                    margin: const EdgeInsets.only(bottom: 2 ),
                    child: SmallText(text: "Products paring",),
                  )
                ],

              ),
            ),
            //recommended product
            // List of guitars and images
            GetBuilder<RecommendedProductController>(builder: (recommendedProduct){
              return recommendedProduct.isLoaded?ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: recommendedProduct.recommendedProductList.length,
                  itemBuilder: (context, index){
                    return GestureDetector(
                      onTap: (){
                        Get.toNamed(RouteHelper.getRecommendedProduct(index,"home"));
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20, bottom: Dimensions.height10),
                        child: Row(
                          children: [
                            //image section
                            Container(
                                width: Dimensions.listViewImgSize,
                                height:Dimensions.listViewImgSize,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(Dimensions.radius15 ),
                                    color: Colors.white38,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            AppConstants.BASE_URL+AppConstants.UPLOAD_URL+recommendedProduct.recommendedProductList[index].img!
                                        )
                                    )
                                )
                            ),
                            //text container
                            Expanded(
                              child: Container(
                                height: Dimensions.listViewTextContSize,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(Dimensions.radius20 ),
                                    bottomRight: Radius.circular(Dimensions.radius20),

                                  ),
                                  color: AppColors.backgroundColor1,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: Dimensions.width10,right: Dimensions.width10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TitleText(text:recommendedProduct.recommendedProductList[index].name!,),
                                      SizedBox(height: Dimensions.height7,),
                                      SmallText(text: "Electric Guitar"),
                                      SizedBox(height: Dimensions.height10,),
                                      Row(
                                        children: [
                                          IconAndTextWidgets(icon: Icons.attach_money, text: "${recommendedProduct.recommendedProductList[index].price!}M VND",iconColor: AppColors.iconColor2),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),

                            )
                          ],
                        ),
                      ),
                    );
                  }):CircularProgressIndicator(
                color: AppColors.mainColor,
              );
            })
          ],
    );
  }
  Widget _buildPageItem(int index, ProductModel popularProduct){
    Matrix4 matrix = Matrix4.identity();
    if(index==_currPageValue.floor()){
      var currScale = 1-(_currPageValue-index)*(1-_scaleFactor);
      var currTrans = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);

    }else if(index== _currPageValue.floor()+1){
      var currScale = _scaleFactor+(_currPageValue-index+1)*(1-_scaleFactor);
      var currTrans = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }else if(index== _currPageValue.floor()-1){
      var currScale = 1-(_currPageValue-index)*(1-_scaleFactor);
      var currTrans = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }else{
      var currScale=0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, _height*(1-_scaleFactor)/2, 1);
    }


    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: (){
              Get.toNamed(RouteHelper.getPopularProduct(index,"home"));
            },
            child: Container(
              height: Dimensions.pageViewContainer*1.25,
              margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: Colors.white10,
                  image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: NetworkImage(
                          AppConstants.BASE_URL+AppConstants.UPLOAD_URL+popularProduct.img!
                      )
                  )
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(

              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(left: Dimensions.width35,right: Dimensions.width30,bottom: Dimensions.height20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: AppColors.backgroundColor1,
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.backgroundColor1,
                        blurRadius: 5.0,
                        offset: const Offset(0,5)
                    ),
                    BoxShadow(
                      color: AppColors.backgroundColor1,
                      offset:  const Offset(-5,0),
                    )
                  ]

              ),
              child: Container(
                padding: EdgeInsets.only(top: Dimensions.height10,left: Dimensions.width15,right: Dimensions.width15),
                child: AppColumn(text: popularProduct.name!,),
              ),
            ),
          )
        ],
      ),
    );
  }
}
