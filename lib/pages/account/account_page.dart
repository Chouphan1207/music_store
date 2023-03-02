import 'package:flutter/material.dart';
import 'package:music_store/base/custom_loader.dart';
import 'package:music_store/controllers/auth_controller.dart';
import 'package:music_store/controllers/cart_controller.dart';
import 'package:music_store/controllers/location_controller.dart';
import 'package:music_store/routes/route_helper.dart';
import 'package:music_store/utils/colors.dart';
import 'package:music_store/utils/dimensions.dart';
import 'package:music_store/widgets/app_icon.dart';
import 'package:music_store/widgets/big_text.dart';
import 'package:get/get.dart';

import '../../controllers/user_controller.dart';
import '../../widgets/account_widget.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if(_userLoggedIn){
      Get.find<UserController>().getUserInfo();
      // print("User has logged in");
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: Dimensions.height71,
        backgroundColor: AppColors.backgroundColor1,
        title: Center(
          child: BigText(
              text: "Profile",size: Dimensions.font23,color: AppColors.mainColor,),
        ),
      ),
      body: GetBuilder<UserController>(builder: (userController){
        return _userLoggedIn?
          (userController.isLoading?
              Container(
                color: AppColors.backgroundColor3,
                width: double.maxFinite,
                child: Container(
                  margin: EdgeInsets.only(top: Dimensions.height15),
                  child: Column(
                    children: [
                      //profile icon
                      AppIcon(
                        icon: Icons.person,
                        backgroundColor: AppColors.mainColor,
                        iconColor: Colors.white,
                        iconSize: Dimensions.radius15*5.5,
                        size: Dimensions.radius30*5,),
                      SizedBox(height: Dimensions.height30,),
                      //profile info
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              //name
                              AccountWidget(
                                appIcon: AppIcon(
                                  icon: Icons.person,
                                  backgroundColor: AppColors.mainColor,
                                  iconColor: Colors.white,
                                  iconSize: Dimensions.radius24,
                                  size: Dimensions.height50,),
                                bigText: BigText(text: userController.userModel.name),
                              ),
                              SizedBox(height: Dimensions.height15,),

                              //phone
                              AccountWidget(
                                appIcon: AppIcon(
                                  icon: Icons.phone,
                                  backgroundColor: AppColors.mainColor,
                                  iconColor: Colors.white,
                                  iconSize: Dimensions.radius24,
                                  size: Dimensions.height50,),
                                bigText: BigText(text: userController.userModel.phone),
                              ),
                              SizedBox(height: Dimensions.height15,),

                              //email
                              AccountWidget(
                                appIcon: AppIcon(
                                  icon: Icons.email,
                                  backgroundColor: AppColors.mainColor,
                                  iconColor: Colors.white,
                                  iconSize: Dimensions.radius24,
                                  size: Dimensions.height50,),
                                bigText: BigText(text: userController.userModel.email),
                              ),
                              SizedBox(height: Dimensions.height15,),

                              //address
                              GetBuilder<LocationController>(builder: (locationController){
                                if(_userLoggedIn&&locationController.addressList.isEmpty){
                                  return GestureDetector(
                                    onTap: (){
                                      Get.offNamed(RouteHelper.getAddressPage());
                                    },
                                    child: AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.location_on,
                                        backgroundColor: AppColors.mainColor,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.radius24,
                                        size: Dimensions.height50,),
                                      bigText: BigText(text: "141 Dien Bien Phu Street",),
                                    ),
                                  );
                                }else{
                                  return GestureDetector(
                                    onTap: (){
                                      Get.offNamed(RouteHelper.getAddressPage());
                                    },
                                    child: AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.location_on,
                                        backgroundColor: AppColors.mainColor,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.radius24,
                                        size: Dimensions.height50,),
                                      bigText: BigText(text: "Your address"),
                                    ),
                                  );
                                }
                              }),
                              SizedBox(height: Dimensions.height15,),

                              //message
                              AccountWidget(
                                appIcon: AppIcon(
                                  icon: Icons.message,
                                  backgroundColor: AppColors.mainColor,
                                  iconColor: Colors.white,
                                  iconSize: Dimensions.radius24,
                                  size: Dimensions.height50,),
                                bigText: BigText(text: "Message"),
                              ),
                              SizedBox(height: Dimensions.height15,),

                              //logout
                              GestureDetector(
                                onTap: (){
                                  if(Get.find<AuthController>().userLoggedIn()){
                                    Get.find<AuthController>().clearSharedData();
                                    Get.find<CartController>().clear();
                                    Get.find<CartController>().clearCartHistory();
                                    Get.find<LocationController>().clearAddressList();
                                    Get.offNamed(RouteHelper.getSignInPage());
                                    print("signed Out");
                                  }else{
                                    print("you logged out");
                                  }
                                },
                                child: AccountWidget(
                                  appIcon: AppIcon(
                                    icon: Icons.logout,
                                    backgroundColor: AppColors.mainColor,
                                    iconColor: Colors.white,
                                    iconSize: Dimensions.radius24,
                                    size: Dimensions.height50,),
                                  bigText: BigText(text: "Logout"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ):
              CustomLoader()
          ):
            Container(
              color: AppColors.backgroundColor3,
                child: Center( child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: double.maxFinite,
                      height: Dimensions.height50*10,
                      margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius15),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/image/signintocontinue.jpg",))
                      ),
                    ),
                    SizedBox(height: Dimensions.height20,),
                    GestureDetector(
                      onTap: (){
                        Get.toNamed(RouteHelper.getSignInPage());
                      },
                      child: Container(
                        width: double.maxFinite,
                        height: Dimensions.height71,
                        margin: EdgeInsets.only(left: Dimensions.width20*1.5,right: Dimensions.width20*1.5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                          color: AppColors.mainColor,
                        ),
                        child: Center(child: BigText(text: "Sign In",color: AppColors.textColorWhite,size: Dimensions.font23,)),
                      ),
                    ),

                  ],
            )));

        }),
    );
  }
}
