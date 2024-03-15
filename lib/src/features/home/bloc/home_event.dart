part of 'home_bloc.dart';

sealed class HomeEvent {}

class HomeFetchRepositry extends HomeEvent {
  final String userName;

  HomeFetchRepositry({required this.userName});
}
