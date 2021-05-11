import 'package:flutter/material.dart';
import 'package:ping_helper/views/AppBloc.dart';
import 'package:ping_helper/views/AppProvider.dart';

void main() {

  //Here one app developed with two different design patterns, you can choose on your taste:
  //1. Provider
  //2. Bloc

  //runApp(AppProvider());
  runApp(AppBloc());
}
