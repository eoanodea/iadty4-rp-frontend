// @dart=2.9
import 'package:flutter/material.dart';
import 'package:frontend/src/data/Option.dart';
import 'package:frontend/src/model/QuestionItem.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../constants.dart';

typedef QuestionCallback = void Function(bool score);
typedef SelectCallback = void Function(List<Option> values);

class RenderOptions extends StatelessWidget {
  final QuestionItem question;
  final QuestionCallback onAnswer;
  final SelectCallback onSelect;
  final List<Option> selectedOption;

  const RenderOptions(
      {Key key,
      this.question,
      this.onAnswer,
      this.onSelect,
      this.selectedOption})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    List<Option> convertedOptions = [];

    for (var i = 0; i < question.options.length; i++) {
      convertedOptions.add(new Option(id: i, name: question.options[i]));
    }

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MultiSelectChipField(
            showHeader: false,
            searchHint: "Select multiple answers by tapping them",
            decoration: BoxDecoration(
              border: Border.all(color: Colors.transparent),
            ),
            // alignment: Alignment.center,
            items: convertedOptions
                .map((e) => MultiSelectItem<Option>(e, e.name))
                .toList(),
            itemBuilder: (item, state) {
              // return your custom widget here
              return Container(
                width: (mediaQuery.size.width / convertedOptions.length) -
                    (convertedOptions.length * 4.0),
                height: 250.0,
                margin: EdgeInsets.all(5.0),
                child: Semantics(
                  button: true,
                  hint: "Note of ${item.label}",
                  child: Material(
                    borderRadius: borderRadius,
                    color: selectedOption.length > 0 &&
                            selectedOption[0] == item.value
                        ? Colors.orange
                        : Colors.grey[100],
                    child: InkWell(
                      borderRadius: borderRadius,
                      highlightColor: Colors.grey,
                      onTap: () {},
                      child: Center(
                          child: Text(
                        item.label,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18.0,
                            color: selectedOption.length > 0 &&
                                    selectedOption[0] == item.value
                                ? Colors.white
                                : Colors.black87),
                      )),
                      onTapDown: (_) => {
                        if (selectedOption.length == 0 ||
                            selectedOption[0] != item.value)
                          {
                            onSelect([item.value])
                          }
                        else
                          onSelect([])
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
