// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'repository_bloc.dart';

sealed class RepositoryEvent {}

class FetchPRCount extends RepositoryEvent {
  String username;
  String repo;
  FetchPRCount({
    required this.username,
    required this.repo,
  });
}
