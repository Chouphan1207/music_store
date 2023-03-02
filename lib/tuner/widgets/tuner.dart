import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_store/utils/dimensions.dart';
import '../../tuner/settings/tuning_picker.dart';
import '../../tuner/extensions/tuner_extension.dart';
import '../../utils/colors.dart';
import '../../widgets/big_text.dart';

class Tuner extends StatelessWidget {
  const Tuner({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimensions.screenHeight,
      child: Column(
        children: <Widget>[
          SizedBox(height: Dimensions.height50,),
          Container(
            alignment: Alignment.topLeft,
            width: Dimensions.width45*3,
            height: Dimensions.height71,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/image/tuner_logo.png")),
            ),
          ),
          Flexible(
            flex: 100,
            child: Padding(
              padding: EdgeInsets.only(top: Dimensions.height50*2),
              child: BlocBuilder<TunerBloc, TunerState>(
                buildWhen: (previousState, state) =>
                    state.runtimeType != previousState.runtimeType,
                builder: (context, state) {
                  return Column(
                    children: _mapStateToButtons(
                        tunerBloc: BlocProvider.of<TunerBloc>(context),
                        context: context),
                  );
                },
              ),
            ),
          ),
          Flexible(
            flex: 200,
            child: Padding(
              padding: EdgeInsets.only(top: Dimensions.radius16),
              child: BlocBuilder<TunerBloc, TunerState>(
                builder: (context, state) {
                  return _mapStateToNote(
                    tunerBloc: BlocProvider.of<TunerBloc>(context),
                    context: context,
                  );
                },
              ),
            ),
          ),
          Divider(
            height: Dimensions.height71,
            color: Colors.transparent,
          ),
        ],
      ),
    );
  }

  List<Widget> _mapStateToButtons(
      {required TunerBloc tunerBloc, required BuildContext context}) {
    final TunerState currentState = tunerBloc.state;
    final raisedButtonStyle = ElevatedButton.styleFrom(
        padding: EdgeInsets.all(Dimensions.radius15), backgroundColor: AppColors.textColorDark);

    if (currentState is Ready) {
      return [
        Container(
          height: Dimensions.height71,
          width: Dimensions.width45*5,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 0.1,
                  spreadRadius: 1.1,
                  color: AppColors.backgroundColor1,
                ),
          ],
          ),
          child: ElevatedButton(
            style: raisedButtonStyle,
            child: Text(
              "Ready",
              style: Theme.of(context).textTheme.button!.copyWith(
                    color: AppColors.textColorWhite,
                    fontSize: Dimensions.font17
                  ),
            ),
            onPressed: () {
              tunerBloc.add(
                const Start(),
              );
            },
          ),
        ),
      ];
    } else if (currentState is Running) {
      return [
        Container(
          height: Dimensions.height71,
          width: Dimensions.width45*5,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              blurRadius: 0.1,
              spreadRadius: 1.1,
              color: AppColors.backgroundColor1,
            ),
          ]),
          child: ElevatedButton(
            style: raisedButtonStyle,
            child: Text(
              "Stop",
              style: Theme.of(context).textTheme.button!.copyWith(
                    color: AppColors.mainColor,
                    fontSize: Dimensions.font17
                  ),
            ),
            onPressed: () {
              tunerBloc.add(
                Stop(),
              );
            },
          ),
        ),
      ];
    } else if (currentState is Stopped) {
      print("Stopped");
      return [
        Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              blurRadius: 25,
              spreadRadius: 2,
              color: Colors.black.withAlpha(150),
            ),
          ]),
          child: ElevatedButton(
            style: raisedButtonStyle,
            child: Text(
              "Restart",
              style: Theme.of(context).textTheme.button!.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
            ),
            onPressed: () {
              tunerBloc.add(
                Stop(),
              );
            },
          ),
        ),
      ];
    }

    return [];
  }

  Widget _mapStateToNote(
      {required TunerBloc tunerBloc, required BuildContext context}) {
    final TunerState currentState = tunerBloc.state;

    String? instruction;
    Color? instructionColor;

    if (currentState is Running) {
      double dist = currentState.frequency! - currentState.target!;
      if (dist < 0) {
        instruction = "Strengthen string by:";
        instructionColor = AppColors.mainColor;
      } else if (dist > 0) {
        instruction = "Loosen string by:";
        instructionColor = AppColors.mainColor;
      } else if (dist == 0) {
        instruction = "Perfectly tuned!";
        instructionColor = AppColors.mainColor;
      }

      if (currentState.isOnPitch!) {
        return Column(
              children: <Widget>[
                Container(
                  height: Dimensions.height50,
                  width: Dimensions.width45*7,
                  padding: EdgeInsets.only(
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(Dimensions.width20),
                    ),
                    color: AppColors.backgroundColor2,
                  ),
                  child: Center(
                    child: BigText(text:
                      "On Pitch!",
                      size: Dimensions.font23,
                      color: AppColors.textColorWhite,
                    ),
                  ),
                ),
                SizedBox(
                  height: Dimensions.height50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    BigText(text:
                      "Perfect tuning is",
                          ),
                    Padding(
                      padding: EdgeInsets.only(left: Dimensions.radius15/5),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: Dimensions.width20*5,
                      child: BigText(text:
                        dist > 0
                            ? "-${dist.abs().toStringAsFixed(2)}"
                            : "+${dist.abs().toStringAsFixed(2)}",
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: Dimensions.radius15/5),
                    ),
                    BigText(text:
                      "away!",
                    ),
                  ],
                ),
                SizedBox(
                  height: Dimensions.height50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    BigText(text:
                      "Note:",
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: Dimensions.radius15),
                    ),
                    Container(
                      transform: Matrix4.translationValues(0.0, -2.5, 0.0),
                      child: BigText(text:
                        currentState.note! +
                            TuningPickerState.octaveToSuperscript(
                                currentState.octave.toString()),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Dimensions.height50,
                ),
                Container(

                  padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
                  transform: Matrix4.translationValues(0.0, -20, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      BigText(text:
                        "Frequency:",
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: Dimensions.radius15),
                      ),
                      BigText(text:
                        currentState.frequency!.toStringAsFixed(2),
                            ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Dimensions.height20,
                ),
              ],
            );
      } else {
        return SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: Dimensions.width10),
            child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                          width: Dimensions.width45*5,
                          child: BigText(text: instruction!,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: Dimensions.radius15),
                        ),
                        Container(
                          width: Dimensions.width20*3,
                          child: BigText(text:
                            currentState.distance!.toStringAsFixed(2),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.height50,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        BigText(text:
                          "Note:".padLeft(5),
                              ),
                        Padding(
                          padding: EdgeInsets.only(left: Dimensions.radius15),
                        ),
                        Container(
                          width: Dimensions.width20*3,

                          transform: Matrix4.translationValues(0.0, -1.5, 0.0),
                          child: BigText(text:
                            currentState.note! +
                                TuningPickerState.octaveToSuperscript(
                                    currentState.octave.toString()),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: Dimensions.height50,),
                    Container(
                      transform: Matrix4.translationValues(0.0, -20.0, 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          BigText(text:
                            "Frequency:",
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: Dimensions.radius15),
                          ),
                          SizedBox(
                            width: Dimensions.width20*3.5,
                            child: BigText(text:
                              currentState.frequency!.toStringAsFixed(2),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: Dimensions.height50*2,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        BigText(text:
                          "Target note:",
                          color: AppColors.mainColor,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: Dimensions.radius15),
                        ),
                        Container(
                          width: Dimensions.width45,
                          transform: Matrix4.translationValues(0.0, -1.5, 0.0),
                          child: BigText(text:
                            currentState.nearestNote! +
                                TuningPickerState.octaveToSuperscript(
                                    currentState.nearestOctave.toString()),
                            color: AppColors.mainColor,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.height50,
                    ),
                    Container(
                      transform: Matrix4.translationValues(0.0, -20.0, 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          BigText(text:
                            "Target frequency:",
                            color: AppColors.mainColor,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: Dimensions.radius15),
                          ),
                          Container(
                            width: Dimensions.width20*3.2,
                            child: BigText(text:
                              currentState.nearestTarget!.toStringAsFixed(2),
                              color: AppColors.mainColor,
                            ),

                          ),
                        ],
                      ),
                    ),
                  ],
                ),
          ),
        );
      }
    } else if (currentState is Stopped || currentState is Ready) {
      return Column(
        children: [
          Container(
            width: Dimensions.width45*7.5,
            height: Dimensions.height71*5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius15 ),
              image: const DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/image/tuner.png")),
            ),
          ),
          SizedBox(height: Dimensions.height7,),
          BigText(text:
            "Standard Tuning",
            color: AppColors.textColorDark,
          ),
        ],
      );
    } else {
      throw new Exception(
          "Exception thrown at 'tuner01.dart', in the method '_mapStateToNote({TunerBloc tunerBloc}).");
    }
  }
}
