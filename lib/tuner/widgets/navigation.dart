import "package:flutter/material.dart";
import 'package:music_store/utils/colors.dart';
import "../../tuner/views/home_view.dart";
import "../../tuner/views/settings_view.dart";

class NavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabs: [
        Tab(
          icon: Icon(Icons.mic),
        ),
        Tab(
          icon: Icon(Icons.settings),
        ),
      ],
      labelColor: Theme.of(context).focusColor,
      unselectedLabelColor: Theme.of(context).focusColor.withAlpha(70),
      indicatorSize: TabBarIndicatorSize.label,
      indicatorPadding: EdgeInsets.all(5.0),
      indicatorColor: Colors.transparent,
    );
  }
}

class Views extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return TabBarView(
    //   children: [
        return Scaffold(
          body: Home(),
          backgroundColor: AppColors.backgroundColor1,
      //   ),
      //   // Scaffold(
      //   //   body: Settings(),
      //   //   backgroundColor: AppColors.backgroundColor3,
      //   // ),
      // ],
    );
  }
}
