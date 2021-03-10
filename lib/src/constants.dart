import 'package:flutter/material.dart';

const kHeadingFontSize = 28.0;
const kSubHeadingFontSize = 20.0;

const kHeadingTextStyle = TextStyle(
  fontSize: kHeadingFontSize,
);

const kHeadingNoteTextStyle = TextStyle(
    fontSize: kHeadingFontSize,
    decoration: TextDecoration.underline,
    color: Colors.orange,
    fontWeight: FontWeight.bold);

const kSubHeadingTextStyle = TextStyle(fontSize: kSubHeadingFontSize);

const kSubHeadingAnswerTextStyle =
    TextStyle(fontSize: kSubHeadingFontSize, color: Colors.white);

const kSubHeadingHintTextStyle =
    TextStyle(fontSize: 18, fontStyle: FontStyle.italic);

const BorderRadiusGeometry borderRadius = BorderRadius.all(
  Radius.circular(10.0),
);
