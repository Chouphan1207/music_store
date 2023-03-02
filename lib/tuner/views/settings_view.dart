import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import '../../tuner/blocs/custom_tuning_bloc.dart';
import "../../tuner/settings/frequency_tolerance.dart";
import "../../tuner/settings/sample_rate.dart";
import "../../tuner/settings/channels.dart";
import "../../tuner/settings/help.dart";
import "../../tuner/settings/interval_duration.dart";
import "../../tuner/settings/theme_changer.dart";
import "../../tuner/settings/reset.dart";
import "../../tuner/settings/tuning_picker.dart";
import "../../tuner/settings/custom_tuning.dart";

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ChangeNotifierProvider<CustomTuningBloc>.value(
        value: CustomTuningBloc(),
        child: ListView(
          children: [
            // Select the tuning target.
            TuningPicker(),

            // Implement your own custom tuning targets.
            CustomTuning(),

            // Update how often the plugin API gets called.
            IntervalDuration(),

            // Select how far apart the frequency and target frequency can be in order to be considered on pitch.
            FrequencyTolerance(),

            // Change the sample rate.
            SampleRate(),

            // Select the number of channels.
            Channels(),

            // Button that changes the theme to dark/light once clicked, depending on which theme is currently set.
            ThemeChanger(),

            // Help dialog.
            Help(),

            // Button that resets the data and restarts the application to the current (settings) view.
            Reset(),
          ],
        ),
      ),
    );
  }
}
