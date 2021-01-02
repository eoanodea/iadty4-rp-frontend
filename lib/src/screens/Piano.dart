/*
 * File: main.dart
 * Project: lib
 * Version <<projectversion>>
 * File Created: Saturday, 7th November 2020 1:49:48 pm
 * Author: Eoan O'Dea (eoan@web-space.design)
 * -----
 * File Description: 
 * Last Modified: Monday, 7th December 2020 9:30:14 pm
 * Modified By: Eoan O'Dea (eoan@web-space.design>)
 * -----
 * Copyright 2020 WebSpace, WebSpace
 */

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
    print('loading');

    rootBundle.load("assets/Piano.sf2").then((sf2) {
      print('preparing piano + $sf2');
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
    print("State: $state");
    _loadSoundFont();
  }

  final List<int> sharps = [25, 27, 0, 30, 32, 34];
  final List<int> notes = [24, 26, 28, 29, 31, 33, 35, 36];

  @override
  Widget build(BuildContext context) {
    void playNote(int note) {
      MidiUtils.play(note);
      //if (feedback) {
      // VibrateUtils.light();
      // }
    }

    // Widget _backButton() {
    //   return InkWell(
    //     onTap: () {
    //       Navigator.pop(context);
    //     },
    //     child: Container(
    //       padding: EdgeInsets.symmetric(horizontal: 10),
    //       child: Row(
    //         children: <Widget>[
    //           Container(
    //             padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
    //             child: Icon(Icons.keyboard_arrow_left, color: Colors.white),
    //           ),
    //           Text('Back',
    //               style: TextStyle(
    //                   fontSize: 14,
    //                   fontWeight: FontWeight.w700,
    //                   color: Colors.white))
    //         ],
    //       ),
    //     ),
    //   );
    // }

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
                onTapDown: (_) => playNote(note + (12 * 3)),
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
            margin: EdgeInsets.fromLTRB(10.0, 35.0, 10.0, 10.0),
            // margin: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < notes.length; i++)
                  renderKey(notes[i], false),
              ],
            ),
          ),
          Positioned(
            right: 0.0,
            bottom: 120.0,
            top: 50.0,
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
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: renderOctive(),
          ),
        ),
      ),
    );
  }
}

const BorderRadiusGeometry borderRadius = BorderRadius.all(
  Radius.circular(10.0),
);
