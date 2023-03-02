import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../tuner/extensions/tuner_extension.dart';
import "../../tuner/widgets/tuner.dart";

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
      SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocProvider(
              create: (context) => TunerBloc(),
              child: Tuner(),
            ),
          ],
    ),
      );
  }
}
