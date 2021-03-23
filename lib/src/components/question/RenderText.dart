// @dart=2.9
import 'package:flutter/material.dart';
import 'package:frontend/src/constants.dart';
import 'package:frontend/src/model/TextItem.dart';
import 'package:frontend/src/screens/NotePage.dart';

class RenderText extends StatelessWidget {
  final List<TextItem> items;

  const RenderText({Key key, this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    items.sort((a, b) => a.order.compareTo(b.order));

    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        for (var item in items)
          if (item.note != null)
            GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => NotePage(
                    noteId: item.note.id,
                  ),
                ),
              ),
              child: Text(item.text,
                  style: kHeadingNoteTextStyle.copyWith(
                      fontSize: kQuestionHeadingFontSize)),
            )
          else
            Text(
              " " + item.text + " ",
              style: kHeadingTextStyle.copyWith(
                  fontSize: kQuestionHeadingFontSize),
            )
      ],
    );
  }
}
