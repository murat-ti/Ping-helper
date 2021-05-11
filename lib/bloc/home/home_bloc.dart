import 'package:flutter/foundation.dart';
import 'package:bloc/bloc.dart';
import 'package:ping_helper/models/website.dart';
import 'package:ping_helper/repository/api/api_repository.dart';
import 'package:ping_helper/repository/db/url_repository.dart';
import 'bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UrlRepository _urlRepo = UrlRepository();
  final ApiRepository _apiRepo = ApiRepository();

  HomeBloc() : super(HomeInitialState());

  UrlRepository get urlRepo => _urlRepo;
  ApiRepository get apiRepo => _apiRepo;

  @override
  get initialState => HomeInitialState();

  @override
  Stream<HomeState> mapEventToState(event) async* {
    if (event is HomeLoadEvent) {
      try {
        yield HomeLoadingState();

        List<Website> webs = [];
        //load from db
        if (_urlRepo.isNewItemAdded == false) {
          await _urlRepo.getUrls();
          webs.addAll(_urlRepo.websites);
        }
        else{
          //load from cache
          webs.addAll(urlRepo.websites);
        }

        yield HomeLoadedState(
          websites: webs,
        );
      } catch (e) {
        print(e);
        yield HomeErrorState();
      }
    }
  }
}
