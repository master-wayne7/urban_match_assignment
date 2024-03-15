part of 'repository_bloc.dart';

sealed class RepositoryState {}

final class RepositoryInitial extends RepositoryState {}

final class RepositoryLoaded extends RepositoryState {}

final class RepositoryError extends RepositoryState {}
