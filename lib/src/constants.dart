// @dart=2.9
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const kHeadingFontSize = 38.0;
const kQuestionHeadingFontSize = 30.0;
const kSubHeadingFontSize = 22.0;
const kHintFontSize = 18.0;
const kBodyFontSize = 20.0;
const kSubBodyFontSize = 16.0;

final kHeadingTextStyle = GoogleFonts.quicksand(
    fontSize: kHeadingFontSize, fontWeight: FontWeight.w700);

final kHeadingNoteTextStyle = GoogleFonts.quicksand(
    fontSize: kHeadingFontSize,
    decoration: TextDecoration.underline,
    color: Colors.orange,
    fontWeight: FontWeight.w700);

final kSubHeadingTextStyle = GoogleFonts.quicksand(
    fontSize: kSubHeadingFontSize, fontWeight: FontWeight.w700);

final kSubHeadingAnswerTextStyle =
    TextStyle(fontSize: kSubHeadingFontSize, fontWeight: FontWeight.w700);

final kSubHeadingHintTextStyle = GoogleFonts.quicksand(
    fontSize: 18, fontStyle: FontStyle.italic, fontWeight: FontWeight.w700);

final kCorrectAnswerColor = Colors.green;
final kIncorrectAnswerColor = Colors.red[400];

final kCorrectAnswerHeadingTextStyle = GoogleFonts.quicksand(
  fontSize: kSubHeadingFontSize,
  fontWeight: FontWeight.w700,
  color: kCorrectAnswerColor,
);

final kCorrectAnswerSubHeadingTextStyle = GoogleFonts.quicksand(
  fontSize: kSubHeadingFontSize,
  fontWeight: FontWeight.w700,
  color: kCorrectAnswerColor,
);

final kIncorrectAnswerHeadingTextStyle = GoogleFonts.quicksand(
  fontSize: kSubHeadingFontSize,
  fontWeight: FontWeight.w700,
  color: kIncorrectAnswerColor,
);

final kIncorrectAnswerSubHeadingTextStyle = GoogleFonts.quicksand(
  fontSize: kSubHeadingFontSize,
  fontWeight: FontWeight.w700,
  color: kIncorrectAnswerColor,
);

final kIncorrectAnswerHintTextStyle = GoogleFonts.quicksand(
  fontSize: kHintFontSize,
  fontWeight: FontWeight.w600,
  color: kIncorrectAnswerColor,
);

final kbodyTextStyle =
    GoogleFonts.quicksand(fontWeight: FontWeight.w600, fontSize: kBodyFontSize);

final kSubbodyTextStyle = GoogleFonts.quicksand(
    fontWeight: FontWeight.w500, fontSize: kSubBodyFontSize);

const BorderRadiusGeometry borderRadius = BorderRadius.all(
  Radius.circular(10.0),
);
