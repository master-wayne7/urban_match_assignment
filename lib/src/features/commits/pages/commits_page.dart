import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urban_match/src/common/widgets/exception.dart';
import 'package:urban_match/src/features/commits/bloc/commit_bloc.dart';
import 'package:urban_match/src/features/commits/widgets/commit_shimmer.dart';
import 'package:urban_match/src/features/commits/widgets/commit_tile.dart';
import 'package:urban_match/src/models/repository_model.dart';

/// The CommitPage class displays the page for viewing a repository's commit history
/// using the Bloc pattern and Flutter.
class CommitPage extends StatelessWidget {
  /// Constructor for the CommitPage widget.
  const CommitPage({super.key, required this.repository});

  /// Instance variable for the repository to display the commit history for.
  final GitHubRepo repository;

  /// The main build method of the widget.
  ///
  /// The method returns a Scaffold widget with a custom app bar and a body
  /// containing the commit history. The body section uses a BlocBuilder
  /// widget to display different states based on the states of the CommitBloc
  /// widget. The BlocBuilder widget takes a CommitBloc and CommitState as
  /// parameters and builds UI based on the current state of the CommitBloc.
  @override
  Widget build(BuildContext context) {
    /// The body of the CommitPage displays the commit history based on the
    /// state of the CommitBloc.
    return Scaffold(
      /// The app bar displays the title of the page as 'Commits'
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text('Commits'),
      ),
      body: BlocBuilder<CommitBloc, CommitState>(
        builder: (context, state) {
          /// The BlocBuilder builds UI based on the state of the CommitBloc
          /// using a switch statement to check for different types of states.
          ///
          /// - If the state is CommitInitial, the body section displays a blank
          ///   SizedBox.
          /// - If the state is CommitLoading, the body section displays a list
          ///   of 10 CommitShimmer widgets.
          /// - If the state is CommitSuccessful, the body section displays
          ///   a list of CommitTile widgets that display the commits based on
          ///   the state's commits.
          /// - If the state is CommitError, the body section displays an error
          ///   message using the ShowException widget.
          /// - If the state is CommitNetworkError, the body section displays
          ///   a network error message using the ShowException widget.
          switch (state) {
            case CommitInitial():
              return const SizedBox(); // No commits to display
            case CommitLoading():
              return ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) => const CommitShimmer(), // Display loading shimmer
              );
            case CommitSuccessful():
              return state.commits.isEmpty // If commits list is empty, display a message
                  ? const Center(
                      child: ShowException(
                        text: "No commits found for this repository.",
                        lottieAsset: "assets/lottie/empty.json",
                        repeat: true,
                      ),
                    )
                  : ListView.builder(
                      itemCount: state.commits.length,
                      itemBuilder: (context, index) => CommitTile(commit: state.commits[index]), // Display commit history
                    );
            case CommitError():
              return const Center(
                child: ShowException(
                  text: "Got an error fetching data.",
                  lottieAsset: "assets/lottie/error.json",
                  repeat: false,
                ),
              );
            case CommitNetworkError():
              return const Center(
                child: ShowException(
                  text: "Network Error.\n Please check your network connection.",
                  lottieAsset: "assets/lottie/no_internet.json",
                  repeat: true,
                ),
              );
          }
        },
      ),
    );
  }
}
