import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:music_store/base/show_custom_message.dart';
import 'package:music_store/controllers/auth_controller.dart';
import 'package:music_store/models/signup_body_model.dart';
import 'package:music_store/routes/route_helper.dart';
import 'package:music_store/utils/colors.dart';
import 'package:music_store/utils/dimensions.dart';
import 'package:music_store/widgets/big_text.dart';

import '../../base/custom_loader.dart';
import '../../widgets/app_text_field.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpImages =[
      "twitter.png",
      "facebook.png",
      "google.png",
    ];

    void _registration(AuthController authController){

      String name= nameController.text.trim();
      String phone= phoneController.text.trim();
      String email= emailController.text.trim();
      String password= passwordController.text.trim();

      if(name.isEmpty){
        showCustomSnackBar("Type in your name",title: "Name");
      }else if(phone.isEmpty){
        showCustomSnackBar("Type in your phone number",title: "Phone Number");
      }else if(email.isEmpty){
        showCustomSnackBar("Type in your email address",title: "Email");
      }else if(!GetUtils.isEmail(email)){
        showCustomSnackBar("Your email isn\'t valid",title: "Email");
      }else if(password.isEmpty){
        showCustomSnackBar("Type in your password",title: "Password");
      }else if(password.length<6){
        showCustomSnackBar("Your password can not be less than 6 characters",title: "Password");
      }else{
        // showCustomSnackBar("All went well!!!",title: "Perfect");
        SignUpBody signUpBody = SignUpBody(
            name: name,
            phone: phone,
            email: email,
            password: password);
        authController.registration(signUpBody).then((status){
          if(status.isSuccess){
            print("Success registration");
            Get.offNamed(RouteHelper.getInitial());
          }else{
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundColor1,
      body: GetBuilder<AuthController>(builder: (_authController){
        return !_authController.isLoading?
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
                //body
                AppTextField(hintText: "Email", icon: Icons.email, textController: emailController,),
                SizedBox(height: Dimensions.height15,),
                AppTextField(hintText: "Password", icon: Icons.password_sharp, textController: passwordController,isObscure: true,),
                SizedBox(height: Dimensions.height15,),
                AppTextField(hintText: "Name", icon: Icons.person, textController: nameController),
                SizedBox(height: Dimensions.height15,),
                AppTextField(hintText: "Phone", icon: Icons.phone, textController: phoneController),
                SizedBox(height: Dimensions.height20*2,),
                //signup button
                GestureDetector(
                  onTap: (){
                  _registration(_authController);
                  },
                  child: Container(
                    width: Dimensions.screenWidth/2,
                    height: Dimensions.screenWidth/10,
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
                    color: AppColors.mainColor
                    ),
                    child: Center(child: BigText(text: "Sign Up",size: Dimensions.font17*1.2,color: AppColors.textColorWhite,)),
                    ),
                  ),
                SizedBox(height: Dimensions.height15,),

                //tag line
                RichText(text: TextSpan(
                recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                text: "Have an account already?",
                style: TextStyle(
                color: Colors.grey[500],
                fontSize: Dimensions.font17
                )
                )
                ),
                SizedBox(height: Dimensions.screenHeight*0.05,),

                //signup option
                RichText(text: TextSpan(
                  text: "Sign up using one of the following method",
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: Dimensions.font17/1.5
                    )
                  )
                ),
                SizedBox(height: Dimensions.height10,),
                Wrap(
                children: List.generate(3, (index) =>
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                  radius: Dimensions.radius20,
                  backgroundImage: AssetImage(
                  "assets/image/"+signUpImages[index]
                  ),
                  ),
                  )),
                )
                ],
            ),
            ):
          const CustomLoader();
      },),
    );
  }
}
