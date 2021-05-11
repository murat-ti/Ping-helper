import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ping_helper/bloc/home/bloc.dart';
import 'package:ping_helper/views/bloc/home_bloc.dart';

class AppBloc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ping Helper',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
        create: (context) => HomeBloc(),
        child: HomeBlocScreen(title: 'Website availability checker'),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}