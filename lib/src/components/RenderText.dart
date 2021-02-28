import 'package:flutter/material.dart';
import 'package:frontend/src/model/TextItem.dart';

class RenderText extends StatelessWidget {
  final List<TextItem> items;

  const RenderText({Key key, this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        for (var item in this.items)
          if (item.note != null)
            Text(
              item.text,
              style: TextStyle(decoration: TextDecoration.underline),
            )
          else
            Text(item.text)
      ],
    );
  }
}
