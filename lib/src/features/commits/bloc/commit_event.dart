part of 'commit_bloc.dart';

sealed class CommitEvent {}

class FetchCommits extends CommitEvent {
  final String username;
  final String repo;

  FetchCommits({required this.username, required this.repo});
}
