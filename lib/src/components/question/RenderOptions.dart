import 'package:flutter/material.dart';
import 'package:frontend/src/data/Option.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class RenderOptions extends StatelessWidget {
  final List<Object> options;

  const RenderOptions({Key key, this.options}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Option> convertedOptions = [];
    for (var i = 0; i < options.length; i++) {
      convertedOptions.add(new Option(id: i, name: options[i]));
    }

    return MultiSelectChipDisplay(
        alignment: Alignment.center,
        items: convertedOptions
            .map((e) => MultiSelectItem<Option>(e, e.name))
            .toList(),
        onTap: (value) {
          print("value tap!");
        });
  }
}
