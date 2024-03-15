part of 'home_bloc.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeSuccessful extends HomeState {
  final List<GitHubRepo> repositories;
  HomeSuccessful({required this.repositories});
}

final class HomeLoading extends HomeState {}

final class HomeError extends HomeState {}

final class HomeNetworkError extends HomeState {}
