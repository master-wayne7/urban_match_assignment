import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urban_match/src/common/widgets/exception.dart';
import 'package:urban_match/src/features/home/bloc/home_bloc.dart';
import 'package:urban_match/src/features/home/widgets/repository_tile.dart';
import 'package:urban_match/src/features/home/widgets/tile_shimmer.dart';

/// RepositoryList is a widget displaying the list of repositories based on the user's input.
/// This class is a stateless widget that uses the BlocBuilder pattern to respond to the state
/// changes from the HomeBloc.
class RepositoryList extends StatelessWidget {
  const RepositoryList({super.key});

  @override
  Widget build(BuildContext context) {
    /// BlocBuilder listens to the changes in the HomeBloc and invokes the builder function
    /// every time the state changes.
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        /// Based on the HomeState, the view updates accordingly.
        switch (state) {
          case HomeInitial():

            /// Display the centered ShowException widget with the specific text and lottieAsset
            return const Center(
              child: ShowException(
                text: "Start by searching with username.",
                lottieAsset: "assets/lottie/start.json",
                repeat: true,
              ),
            );
          case HomeLoading():

            /// Display the ListView.builder with 10 shimmer loading tiles.
            return ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) => const TileShimmer(),
            );
          case HomeSuccessful():

            /// Display the list of repositories or an empty view if no repositories are found.
            if (state.repositories.isEmpty) {
              return const Center(
                child: ShowException(
                  text: "No repositories found for the user.",
                  lottieAsset: "assets/lottie/empty.json",
                  repeat: true,
                ),
              );
            }
            return ListView.builder(
              itemCount: state.repositories.length,
              itemBuilder: (context, index) {
                return RepositoryTile(
                  repo: state.repositories[index],
                );
              },
            );
          case HomeError():

            /// Display the exception widget with a specific error text and lottieAsset.
            return const ShowException(
              text: "User not found.\n Please enter a valid user name.",
              lottieAsset: "assets/lottie/no_user.json",
              repeat: false,
            );
          case HomeNetworkError():

            /// Display the exception widget with a specific error text and lottieAsset.
            return const ShowException(
              text: "Network Error.\n Please check your network connection.",
              lottieAsset: "assets/lottie/no_internet.json",
              repeat: true,
            );
        }
      },
    );
  }
}
