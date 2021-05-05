// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/src/services/MidiUtils.dart';

class PianoPage extends StatefulWidget {
  @override
  _PianoPageState createState() => _PianoPageState();
}

class _PianoPageState extends State<PianoPage> with WidgetsBindingObserver {
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

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _loadSoundFont();
  }

  final List<int> sharps = [25, 27, 0, 30, 32, 34, 0];
  final List<int> notes = [24, 26, 28, 29, 31, 33, 35, 36];

  @override
  Widget build(BuildContext context) {
    void playNote(int note) {
      MidiUtils.play(note);
      //if (feedback) {
      // VibrateUtils.light();
      // }
    }

    /// Renders a single key to the screen
    Widget renderKey(int note, bool sharp) {
      final pitchName = 'Pitch Name';

      return Expanded(
        child: Container(
          margin: EdgeInsets.all(5.0),
          child: Semantics(
            button: true,
            hint: pitchName,
            child: Material(
              borderRadius: borderRadius,
              color: sharp ? Colors.black : Colors.white,
              child: InkWell(
                borderRadius: borderRadius,
                highlightColor: Colors.grey,
                onTap: () {},
                onTapCancel: () {
                  MidiUtils.stop(note + (12 * 3));
                },
                onTapDown: (_) => {
                  playNote(note + (12 * 3)),
                  Future.delayed(const Duration(milliseconds: 400), () {
                    MidiUtils.stop(note + (12 * 3));
                  })
                },
              ),
            ),
          ),
        ),
      );
    }

    Stack renderOctive() {
      return Stack(
        children: [
          Container(
            margin: EdgeInsets.all(10.0),
            // margin: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                for (var i = 0; i < notes.length; i++)
                  renderKey(notes[i], false),
              ],
            ),
          ),
          Positioned(
            right: 0.0,
            bottom: 50.0,
            top: 30.0,
            width: 200.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                for (var i = 0; i < sharps.length; i++)
                  sharps[i] == 0 || sharps[i] == 1
                      ? Container(
                          height: (100 * .5),
                        )
                      : renderKey(sharps[i], true)
              ],
            ),
          ),
          // Positioned(top: 0, left: 0, child: _backButton()),
        ],
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: renderOctive(),
        ),
      ),
    );
  }
}

const BorderRadiusGeometry borderRadius = BorderRadius.all(
  Radius.circular(10.0),
);
