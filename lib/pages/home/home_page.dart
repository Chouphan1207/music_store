import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:music_store/pages/account/account_page.dart';
import 'package:music_store/pages/auth/sign_in_page.dart';
import 'package:music_store/pages/auth/sign_up_page.dart';
import 'package:music_store/pages/home/main_store_page.dart';
import 'package:music_store/pages/tuner/tuner_page.dart';
import 'package:music_store/utils/colors.dart';
import 'package:music_store/utils/dimensions.dart';

import '../cart/cart_history.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex=0;
  List pages=[
    MainStorePage(),
    TunerPage(),
    CartHistory(),
    AccountPage(),
  ];
  void onTapNav(int index){
    setState(() {
      _selectedIndex=index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor3,
      body: pages[_selectedIndex],
      bottomNavigationBar: Container(
        color: AppColors.backgroundColor2,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.height15,vertical: Dimensions.width20/2),
          child: GNav(

              rippleColor: AppColors.mainColor,
              hoverColor: AppColors.backgroundColor1,
              color: Colors.black26,
              activeColor: AppColors.mainColor,
              iconSize: Dimensions.radius24,
              tabBackgroundColor: Colors.grey.withOpacity(0.05),
              padding:  EdgeInsets.symmetric(horizontal: Dimensions.height15, vertical: Dimensions.width10),
              duration: const Duration(milliseconds: 800),
              gap: 8,

              selectedIndex: _selectedIndex,
              onTabChange: onTapNav,

              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.music_note,
                  text: 'Tuner',
                ),
                GButton(
                  icon: Icons.shopping_cart,
                  text: 'Cart',
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Profile',
                )
              ]
          ),
        ),
      )
    );
  }
}
