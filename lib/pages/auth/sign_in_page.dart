import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:music_store/base/custom_loader.dart';
import 'package:music_store/controllers/auth_controller.dart';
import 'package:music_store/pages/auth/sign_up_page.dart';
import 'package:music_store/routes/route_helper.dart';
import 'package:music_store/utils/colors.dart';
import 'package:music_store/utils/dimensions.dart';
import 'package:music_store/widgets/big_text.dart';

import '../../base/show_custom_message.dart';
import '../../widgets/app_text_field.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();
    void _login(AuthController authController){
      String phone= phoneController.text.trim();
      String password= passwordController.text.trim();

      if(phone.isEmpty){
        showCustomSnackBar("Type in your phone number",title: "Phone");
      }else if(password.isEmpty){
        showCustomSnackBar("Type in your password",title: "Password");
      }else if(password.length<6){
        showCustomSnackBar("Your password can not be less than 6 characters",title: "Password");
      }else{
        authController.login(phone,password).then((status){
          if(status.isSuccess){
            Get.toNamed(RouteHelper.getInitial());
          }else{
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundColor1,
      body: GetBuilder<AuthController>(builder: (authController) {
        return !authController.isLoading?
            SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: Dimensions.screenHeight*0.08,),
                //logo
                Container(
                  child: Center(
                    child: CircleAvatar(
                      radius: Dimensions.radius20*4,
                      backgroundColor: AppColors.backgroundColor3,
                      backgroundImage: AssetImage(
                          "assets/image/logo3.png"
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Dimensions.height15,),

                //welcome
                Container(
                  margin: EdgeInsets.only(left: Dimensions.width20),
                  width: double.maxFinite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hello",
                      style: TextStyle(
                        fontSize: Dimensions.font17*3.5,
                        color: AppColors.textColorDark,
                        fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("Sign into your account",
                        style: TextStyle(
                          fontSize: Dimensions.font17,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  )
                ),
                SizedBox(height: Dimensions.height15,),

                //body
                AppTextField(hintText: "Phone", icon: Icons.phone, textController: phoneController),
                SizedBox(height: Dimensions.height15,),
                AppTextField(hintText: "Password", icon: Icons.password_sharp, textController: passwordController,isObscure: true,),
                SizedBox(height: Dimensions.height10,),

                //tag line
                Row(
                  children: [
                    Expanded(child: Container()),
                    RichText(
                        text: TextSpan(
                            text: "Sign to your account",
                            style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: Dimensions.font17
                            )
                        )
                    ),
                    SizedBox(width: Dimensions.width20,)
                  ],
                ),
                SizedBox(height: Dimensions.screenHeight*0.05,),

                //signin button
                GestureDetector(
                  onTap: (){
                    _login(authController);
                  },
                  child: Container(
                    width: Dimensions.screenWidth/2,
                    height: Dimensions.screenWidth/10,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius30),
                        color: AppColors.mainColor
                    ),
                    child: Center(child: BigText(text: "Sign In",size: Dimensions.font17*1.2,color: AppColors.textColorWhite,)),
                  ),
                ),
                SizedBox(height: Dimensions.height15*2,),

                //signup option
                RichText(
                    text: TextSpan(
                    text: "Don\'t have an account?",
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: Dimensions.font17,
                    ),
                      children: [
                        TextSpan(
                        recognizer: TapGestureRecognizer()..onTap=()=>Get.to(SignUpPage(),transition: Transition.fade),
                        text: " Create",
                        style: TextStyle(
                            color: AppColors.mainBlackColor,
                            fontSize: Dimensions.font17,
                            fontWeight: FontWeight.bold
                        ),
                        )
                      ]
                  )
                ),
              ],
            ),
          ):
            CustomLoader();
        }
      ),
    );
  }
}
