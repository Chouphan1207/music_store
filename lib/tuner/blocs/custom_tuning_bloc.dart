import 'package:flutter/material.dart';
import "../../tuner/extensions/globals.dart" as globals;

import '../extensions/custom_classes.dart';

class CustomTuningBloc extends ChangeNotifier {
  static List<TuningList> tuning = [
    TuningList(globals.flutterFft.getTuning),
    TuningList(["E3", "B2", "G2", "D2", "A1", "E1"]),
  ];

  addTuning(TuningList newTuning) {
    tuning.add(newTuning);
    notifyListeners();
  }

  List<TuningList> get getTuning => tuning;
}
