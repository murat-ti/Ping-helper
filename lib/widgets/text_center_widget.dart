import 'package:flutter/material.dart';

class TextCenter extends StatelessWidget {
  final String text;
  TextCenter({@required this.text});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(text),
    );
  }
}
