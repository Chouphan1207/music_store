import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:music_store/controllers/popular_product_controller.dart';
import 'package:music_store/controllers/recommended_product_controller.dart';
import 'package:music_store/pages/auth/sign_in_page.dart';
import 'package:music_store/routes/route_helper.dart';
import 'package:music_store/utils/colors.dart';
import 'controllers/cart_controller.dart';
import 'helper/dependencies.dart' as dep;

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle( SystemUiOverlayStyle(
    systemNavigationBarColor: AppColors.backgroundColor2,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductController>(builder: (_){
      return GetBuilder<RecommendedProductController>(builder: (_) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          initialRoute: RouteHelper.getSplashPage(),
          getPages: RouteHelper.routes,
          theme: ThemeData(
            primaryColor: AppColors.mainColor,
            fontFamily: "Lato"
          ),
        );
      });
    });
  }
}

