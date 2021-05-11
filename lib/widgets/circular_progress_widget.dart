import 'package:flutter/material.dart';

class CircularProgressWidget extends StatelessWidget {
  CircularProgressWidget();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child:  CircularProgressIndicator(),
      ),
    );
  }
}
