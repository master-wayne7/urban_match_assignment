part of 'commit_bloc.dart';

sealed class CommitState {}

final class CommitInitial extends CommitState {}

final class CommitSuccessful extends CommitState {
  final List<GitHubCommit> commits;
  CommitSuccessful({required this.commits});
}

final class CommitLoading extends CommitState {}

final class CommitError extends CommitState {}

final class CommitNetworkError extends CommitState {}
