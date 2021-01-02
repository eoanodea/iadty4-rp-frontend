import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final String message;
  const EmptyState({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        this.message != null ? this.message : "Could not load data",
        style: TextStyle(fontSize: 18.0),
      ),
    );
  }
}
