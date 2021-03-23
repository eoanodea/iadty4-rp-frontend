// @dart=2.9
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/src/data/Option.dart';
import 'package:frontend/src/model/QuestionItem.dart';
import 'package:frontend/src/services/MidiUtils.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../constants.dart';

typedef QuestionCallback = void Function(bool score);
typedef SelectCallback = void Function(List<dynamic> values);

class RenderMultiSelectPianoOptions extends StatefulWidget {
  final QuestionItem question;
  final QuestionCallback onAnswer;
  final SelectCallback onSelect;
  final selectedOptions;

  const RenderMultiSelectPianoOptions(
      {Key key,
      this.question,
      this.onAnswer,
      this.onSelect,
      this.selectedOptions})
      : super(key: key);

  @override
  _RenderMultiSelectPianoOptionsState createState() =>
      _RenderMultiSelectPianoOptionsState(
          question: question,
          onAnswer: onAnswer,
          onSelect: onSelect,
          selectedOptions: selectedOptions);
}

class _RenderMultiSelectPianoOptionsState
    extends State<RenderMultiSelectPianoOptions> {
  @override
  initState() {
    _loadSoundFont();
    super.initState();
  }

  void _loadSoundFont() async {
    MidiUtils.unmute();

    rootBundle.load("assets/Piano.sf2").then((sf2) {
      MidiUtils.prepare(sf2, "Piano.sf2");
    });
    // VibrateUtils.canVibrate.then((vibrate) {
    //   if (mounted)
    //     setState(() {
    //       canVibrate = vibrate;
    //     });
    // });
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    _loadSoundFont();
  }

  final QuestionItem question;
  final QuestionCallback onAnswer;
  final SelectCallback onSelect;
  final List<dynamic> selectedOptions;

  final Map<String, int> notes = {
    'C': 24,
    'C#': 25,
    'D': 26,
    "D#": 27,
    "E": 28,
    "F": 29,
    "F#": 30,
    "G": 31,
    "G#": 32,
    "A": 33,
    "A#": 34,
    "B": 35,
  };

  _RenderMultiSelectPianoOptionsState(
      {this.question, this.onAnswer, this.onSelect, this.selectedOptions});

  @override
  Widget build(BuildContext context) {
    List<Option> convertedOptions = [];
    List<String> sortedOptions = question.options;

    for (var i = 0; i < sortedOptions.length; i++) {
      convertedOptions.add(new Option(id: i, name: sortedOptions[i]));
    }

    void handleAnswer(dynamic item) {
      var options = selectedOptions;
      options.contains(item) ? options.remove(item) : options.add(item);
      onSelect(options);
    }

    void playNote(int note) {
      MidiUtils.play(note);
      //if (feedback) {
      // VibrateUtils.light();
      // }
    }

    final mediaQuery = MediaQuery.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MultiSelectChipField(
          showHeader: false,
          searchHint: "Select multiple answers by tapping them",
          decoration: BoxDecoration(
            border: Border.all(color: Colors.transparent),
          ),
          items: convertedOptions
              .map((e) => MultiSelectItem<Option>(e, e.name))
              .toList(),
          itemBuilder: (item, state) {
            return Expanded(
              child: Container(
                width: (mediaQuery.size.width / convertedOptions.length) -
                    (convertedOptions.length * 1.5),
                height: 250.0,
                margin: EdgeInsets.all(5.0),
                child: Semantics(
                  button: true,
                  hint: "Note of ${item.label}",
                  child: Material(
                    borderRadius: borderRadius,
                    color: selectedOptions.contains(item.value)
                        ? Colors.grey
                        : Colors.white,
                    child: InkWell(
                      borderRadius: borderRadius,
                      highlightColor: Colors.grey,
                      onTap: () {},
                      onTapCancel: () {
                        MidiUtils.stop(notes[item.label] + (12 * 3));
                      },
                      child: Center(child: Text(item.label)),
                      onTapDown: (_) => {
                        playNote(notes[item.label] + (12 * 3)),
                        handleAnswer(item.value)
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
