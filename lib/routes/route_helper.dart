import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:music_store/pages/auth/sign_in_page.dart';
import 'package:music_store/pages/cart/cart_page.dart';
import 'package:music_store/pages/guitar/popular_product_detail.dart';
import 'package:music_store/pages/guitar/recommended_product_detail.dart';
import 'package:music_store/pages/home/home_page.dart';
import 'package:music_store/pages/home/main_store_page.dart';

import '../pages/address/add_address_page.dart';
import '../pages/address/pick_address_page.dart';
import '../pages/splash/splash_page.dart';

class RouteHelper{
  static const String splashPage="/splash-page";
  static const String initial="/";
  static const String popularProduct="/popular-product";
  static const String recommendedProduct="/recommended-product";
  static const String cartPage="/cart-page";
  static const String signIn="/sign-in";

  static const String addAddress="/add-address";
  static const String pickAddressMap="/pick-address";

  static get page => null;

  static String getSplashPage()=>'$splashPage';
  static String getInitial()=>'$initial';
  static String getPopularProduct(int pageId, String page)=>'$popularProduct?pageId=$pageId&page=$page';
  static String getRecommendedProduct(int pageId, String page)=>'$recommendedProduct?pageId=$pageId&page=$page';
  static String getCartPage()=>'$cartPage';
  static String getSignInPage()=>'$signIn';
  static String getAddressPage()=>'$addAddress';
  static String getPickAddressPage()=>'$pickAddressMap';


  static List<GetPage> routes=[
    GetPage(name: initial, page: (){
      return HomePage();
    },transition:  Transition.fade),
    GetPage(name:pickAddressMap, page: (){
      PickAddressMap _pickAddress =Get.arguments;
      return _pickAddress;
  }),
    GetPage(name: splashPage, page: ()=>SplashScreen()),
    GetPage(name: initial, page: (){
      return HomePage();
    },transition:  Transition.fade),

    GetPage(name: signIn, page: (){
      return SignInPage();
    },transition: Transition.fade),

    GetPage(name: popularProduct, page:(){
      var pageId= Get.parameters['pageId'];
      var page = Get.parameters["page"];
      return PopularProductDetail(pageId: int.parse(pageId!),page:page!);
    },
      transition: Transition.fadeIn
    ),

    GetPage(name: recommendedProduct, page:(){
      var pageId= Get.parameters['pageId'];
      var page = Get.parameters["page"];
      return RecommendedProductDetail(pageId: int.parse(pageId!),page:page!);
    },
        transition: Transition.fadeIn
    ),

    GetPage(name: cartPage, page: (){
      return CartPage();
    },transition: Transition.fadeIn,
    ),
    GetPage(name: addAddress, page: (){
      return AddAddressPage();
    })
  ];
}