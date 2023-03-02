import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:music_store/controllers/auth_controller.dart';
import 'package:music_store/controllers/user_controller.dart';
import 'package:music_store/models/address_model.dart';
import 'package:music_store/pages/address/pick_address_page.dart';
import 'package:music_store/routes/route_helper.dart';
import 'package:music_store/utils/colors.dart';
import 'package:music_store/widgets/app_text_field.dart';
import 'package:music_store/widgets/big_text.dart';

import '../../controllers/location_controller.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/title_text.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {

  TextEditingController _addressController =TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();
  late bool _isLogged;
  CameraPosition _cameraPosition = CameraPosition(
      target: LatLng(45.51563, -122.677433),
      zoom: 17
  );
  // late LatLng _initialPosition;

  @override
  void initState(){
    super.initState();
    _isLogged= Get.find<AuthController>().userLoggedIn();
    if (_isLogged&&Get.find<UserController>().userModel==null){
      Get.find<UserController>().getUserInfo();
    }
    if (Get.find<LocationController>().addressList.isNotEmpty){
      if(Get.find<LocationController>().getUserAddressFromLocalStorage()==""){
        Get.find<LocationController>().saveUserAddress(Get.find<LocationController>().addressList.last);
      }
      // _cameraPosition=CameraPosition(target: LatLng(
      //    double.parse( Get.find<LocationController>().getAddress["latitude"]),
      //     double.parse(Get.find<LocationController>().getAddress["longitude"])
      //   )
      // );
      // _initialPosition=LatLng(
      //     double.parse( Get.find<LocationController>().getAddress["latitude"]),
      //     double.parse(Get.find<LocationController>().getAddress["longitude"])
      // );
      print("camera position worked");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Address Page"),
        backgroundColor: AppColors.mainColor,
        toolbarHeight: Dimensions.height71,
      ),
      body: GetBuilder<UserController>(builder: (userController){
          if(userController.userModel!=null&&_contactPersonName.text.isEmpty){
            _contactPersonName.text= '${userController.userModel.name}';
            _contactPersonNumber.text ='${userController.userModel.phone}';
            if(Get.find<LocationController>().addressList.isNotEmpty){
              _addressController.text = Get.find<LocationController>().getUserAddress().address;
            }
          }
        return GetBuilder<LocationController>(
            builder: (locationController){
              _addressController.text='${locationController.placeMark.name??''}'
                  '${locationController.placeMark.locality??''}'
                  '${locationController.placeMark.postalCode??''}'
                  '${locationController.placeMark.country}';
              print("address in my view is "+_addressController.text);
              return Container(
                color: AppColors.backgroundColor1,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Container(
                      //     height: 140,
                      //     width: MediaQuery.of(context).size.width,
                      //     margin: const EdgeInsets.only(left: 5,right: 5,top: 5),
                      //     decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(5),
                      //         border: Border.all(
                      //             width: 2,color: AppColors.mainColor
                      //         )
                      //     ),
                      //     child: Stack(
                      //       children: [
                      //         GoogleMap(
                      //           initialCameraPosition: CameraPosition(
                      //               target: _initialPosition,zoom:17),
                      //           onTap: (latlng){
                      //             Get.toNamed(RouteHelper.getPickAddressPage(),
                      //             arguments: PickAddressMap(
                      //              fromSignup: false,
                      //              fromAddress: true,
                      //              googleMapController: locationController.mapController,
                      //             ));
                      //           },
                      //           zoomControlsEnabled: false,
                      //           compassEnabled: false,
                      //           indoorViewEnabled: true,
                      //           mapToolbarEnabled: false,
                      //           myLocationEnabled: true,
                      //           onCameraIdle: (){
                      //               locationController.updatePosition(_cameraPosition,true);
                      //           },
                      //           onCameraMove: ((position)=>_cameraPosition=position),
                      //           onMapCreated: ((GoogleMapController controller){
                      //               locationController.setMapController(controller);
                      //           }),
                      //         ),
                      //
                      //       ],
                      //     )
                      // ),
                      Container(
                        width: double.maxFinite,
                        height: Dimensions.height20*7,
                        margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20,top: Dimensions.height20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius15),
                          image: DecorationImage(
                              fit: BoxFit.fitWidth,
                              image: AssetImage(
                                  "assets/image/map.jpg"
                              )),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: Dimensions.width20,top: Dimensions.height20),
                        child: SizedBox(height: Dimensions.height20*2.2,child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: locationController.addressTypeList.length,
                            itemBuilder: (context,index){
                              return InkWell(
                                onTap: (){
                                  locationController.setAddressTypeIndex(index);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: Dimensions.width10),
                                  padding: EdgeInsets.symmetric(horizontal: Dimensions.width20/1.5,vertical: Dimensions.height10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(Dimensions.radius20/4),
                                    color: AppColors.backgroundColor3,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey[200]!,
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                      )
                                    ]
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        index==0?Icons.home_filled:index==1?Icons.work:Icons.location_on,
                                        color: locationController.addressTypeIndex==index?
                                        AppColors.mainColor:AppColors.backgroundColor1,
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }
                          ),
                        ),
                      ),
                      SizedBox(height: Dimensions.height20,),
                      Padding(
                        padding: EdgeInsets.only(left: Dimensions.width20),
                        child: BigText(text: "Delivery Address",color: AppColors.textColorDark,),
                      ),
                      SizedBox(height: Dimensions.height10,),
                      AppTextField(hintText: "Your address", icon: Icons.map, textController: _addressController),
                      SizedBox(height: Dimensions.height20,),
                      Padding(
                        padding: EdgeInsets.only(left: Dimensions.width20),
                        child: BigText(text: "Your Contact Name",color: AppColors.textColorDark,),
                      ),
                      SizedBox(height: Dimensions.height10,),
                      AppTextField(hintText: "Your name", icon: Icons.person, textController: _contactPersonName),
                      SizedBox(height: Dimensions.height20,),
                      Padding(
                        padding: EdgeInsets.only(left: Dimensions.width20),
                        child: BigText(text: "Your Contact Number",color: AppColors.textColorDark,),
                      ),
                      SizedBox(height: Dimensions.height10,),
                      AppTextField(hintText: "Your number", icon: Icons.phone, textController: _contactPersonNumber)

                    ],

                  ),
                ),
              );
            });
      },),

        bottomNavigationBar: GetBuilder<LocationController>(builder: (locationController){
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: Dimensions.height20*6.5,
                padding: EdgeInsets.only(top: Dimensions.height30/2,bottom: Dimensions.height30/2,left: Dimensions.width20,right: Dimensions.width20),
            decoration: BoxDecoration(
                color: AppColors.backgroundColor3,
                boxShadow: [
                  BoxShadow(
                      color: CupertinoColors.systemGrey5,
                      blurRadius: 1.0,
                      offset: -Offset(1,1)
                  ),
                  BoxShadow(
                    color: CupertinoColors.systemGrey5,
                    offset:  Offset(-1,1),
                   )
                  ]
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap:(){
                        AddressModel _addressModel = AddressModel(
                          addressType: locationController.addressTypeList[locationController.addressTypeIndex],
                          contactPersonName: _contactPersonName.text,
                          contactPersonNumber: _contactPersonNumber.text,
                          address: _addressController.text,
                          // latitude: locationController.position.latitude.toString(),
                          // longitude: locationController.position.longitude.toString(),
                        );
                        locationController.addAddress(_addressModel).then((response){
                          if(response.isSuccess){
                            Get.toNamed(RouteHelper.getInitial());
                            Get.snackbar("Address", "Added Successfully");
                          }else{
                            Get.snackbar("Address", "Failed To Save Address");
                          }
                        });
                      },
                      child: Container(
                        height: Dimensions.height71/1.1,
                        padding: EdgeInsets.only(top: Dimensions.height20/2,bottom: Dimensions.height20/2,left: Dimensions.width20,right: Dimensions.width20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.radius15),
                            color: AppColors.mainColor
                        ),
                        child: Center(child: TitleText(text: "Save Address",color: Colors.white,size: Dimensions.font23/1.2,)),
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        },)
    );
  }
}
