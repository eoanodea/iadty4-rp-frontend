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

class RenderMultiSelectPianoOptions extends StatefulWidget {
  final QuestionItem question;
  final QuestionCallback onAnswer;

  const RenderMultiSelectPianoOptions({Key key, this.question, this.onAnswer})
      : super(key: key);

  @override
  _RenderMultiSelectPianoOptionsState createState() =>
      _RenderMultiSelectPianoOptionsState(
          question: question, onAnswer: onAnswer);
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

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   _loadSoundFont();
  // }

  final QuestionItem question;
  final QuestionCallback onAnswer;
  var selectedOptions = [];

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

  _RenderMultiSelectPianoOptionsState({this.question, this.onAnswer});

  @override
  Widget build(BuildContext context) {
    List<Option> convertedOptions = [];
    List<String> sortedOptions = question.options;

    for (var i = 0; i < sortedOptions.length; i++) {
      convertedOptions.add(new Option(id: i, name: sortedOptions[i]));
    }

    Column renderIncorrectAnswer() {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Answer Incorrect",
              style: kSubHeadingAnswerTextStyle,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
                'The correct answer was ${question.answerArr.map((e) => "$e")}',
                style: kSubHeadingAnswerTextStyle),
            if (question.answerHint != null)
              Container(
                margin: EdgeInsets.only(top: 10.0),
                child: Text(question.answerHint,
                    textAlign: TextAlign.center,
                    style: kSubHeadingHintTextStyle),
              ),
          ]);
    }

    bool checkAnswer() {
      List<String> items = [];

      for (var item in selectedOptions) {
        items.add(item.name);
      }

      print(listEquals(items, question.answerArr));

      return listEquals(items, question.answerArr);
    }

    void handleOnPress(value, context) {
      onAnswer(value);
      Navigator.pop(context);
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
        Text("Media query ${mediaQuery.size.width}"),
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
                        setState(() {
                          selectedOptions.contains(item.value)
                              ? selectedOptions.remove(item.value)
                              : selectedOptions.add(item.value);
                          // selectedOptions = values;
                        })
                      },
                    ),
                  ),
                ),
              ),
            );
          },
          onTap: (values) {
            setState(() {
              selectedOptions = values;
            });
          },
        ),
        // Positioned(
        //   bottom: 0.0,
        //   left: 0.0,
        //   width: 200.0,
        //   child:
        ButtonBar(
          alignment: MainAxisAlignment.center,
          children: [
            FlatButton(
              minWidth: mediaQuery.size.width,
              color: selectedOptions.length < 1 ? Colors.grey : Colors.orange,
              child: const Text(
                'Done',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: selectedOptions.length < 1
                  ? () => {}
                  : () => {
                        showModalBottomSheet<void>(
                          context: context,
                          isDismissible: false,
                          enableDrag: false,
                          builder: (BuildContext context) {
                            return Container(
                              height: 200,
                              color: checkAnswer()
                                  ? Colors.green
                                  : Colors.red[600],
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    if (!checkAnswer())
                                      renderIncorrectAnswer()
                                    else
                                      Text(
                                        "Answer Correct!",
                                        style: kSubHeadingAnswerTextStyle,
                                      ),
                                    SizedBox(height: 20),
                                    ElevatedButton(
                                        child: const Text('Next'),
                                        onPressed: () => handleOnPress(
                                            checkAnswer(), context))
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      },
            )
          ],
        ),
        // ),
      ],
    );
  }
}

// class RenderMultiSelectPianoOptions extends StatelessWidget {
//   final QuestionItem question;
//   final QuestionCallback onAnswer;

//   const RenderMultiSelectPianoOptions({Key? key, this.question, this.onAnswer})
//       : super(key: key);

// }
