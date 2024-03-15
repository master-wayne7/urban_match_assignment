import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urban_match/src/models/commit_model.dart';
import 'package:urban_match/src/services/api_services.dart';

part 'commit_event.dart';
part 'commit_state.dart';

class CommitBloc extends Bloc<CommitEvent, CommitState> {
  final ApiService apiService;
  CommitBloc({required this.apiService}) : super(CommitInitial()) {
    on<FetchCommits>(onFetchCommits);
  }

  onFetchCommits(FetchCommits event, Emitter emit) async {
    emit(CommitLoading());
    try {
      List<GitHubCommit> commits = await apiService.getRepoCommits(event.username, event.repo);
      emit(CommitSuccessful(commits: commits));
    } on SocketException {
      emit(CommitNetworkError());
    } catch (e) {
      emit(CommitError());
    }
  }
}
