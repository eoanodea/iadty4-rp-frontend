import 'dart:collection';

class Note {
  String name;
  int value;

  Note({this.name, this.value});
}

// final List<int> notes = [24, 26, 28, 29, 31, 33, 35, 36];

// final letter = [
//   ['A', 24],
//   "B",
//   "C"
// ];

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

//const obj = {A: 24, B: 26, C:28}
