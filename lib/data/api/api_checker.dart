import 'package:get/get.dart';
import 'package:music_store/base/show_custom_message.dart';
import 'package:music_store/routes/route_helper.dart';

class ApiChecker{
  static void checkApi(Response response){
    if(response.statusCode==401){
      Get.offNamed(RouteHelper.getSignInPage());
    }else{
      showCustomSnackBar(response.statusText!);
    }
  }
}