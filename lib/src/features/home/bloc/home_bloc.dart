import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urban_match/src/models/repository_model.dart';
import 'package:urban_match/src/services/api_services.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ApiService apiService;
  HomeBloc({required this.apiService}) : super(HomeInitial()) {
    on<HomeFetchRepositry>(onFetchRepositories);
  }

  onFetchRepositories(HomeFetchRepositry event, Emitter emit) async {
    emit(HomeLoading());
    try {
      List<GitHubRepo> repos = await apiService.getUserRepos(event.userName);
      emit(HomeSuccessful(repositories: repos));
    } on SocketException {
      emit(HomeNetworkError());
    } catch (e) {
      emit(HomeError());
    }
  }
}
