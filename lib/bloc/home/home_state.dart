import 'package:flutter/foundation.dart';
import 'package:ping_helper/models/website.dart';

class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final List<Website> websites;
  HomeLoadedState({
    @required this.websites,
  });
}

class HomeErrorState extends HomeState {}