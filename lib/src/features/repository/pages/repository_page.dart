import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:urban_match/src/features/commits/bloc/commit_bloc.dart';
import 'package:urban_match/src/features/commits/pages/commits_page.dart';
import 'package:urban_match/src/features/repository/bloc/repository_bloc.dart';
import 'package:urban_match/src/features/repository/widgets/title_box.dart';
import 'package:urban_match/src/models/repository_model.dart';

/// A RepositoryPage widget displays the details of a specific GitHub repository.
/// It takes a single argument 'repo' of type [GitHubRepo] which represents the
/// repository being displayed.
class RepositoryPage extends StatelessWidget {
  final GitHubRepo repo;
  const RepositoryPage({super.key, required this.repo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: const Color(0xfffbfbfb),
      ),
      body: Column(
        children: [
          TitleBox(repo: repo),
          const SizedBox(height: 20),
          // Invoking repoTile widget with issues icon, title, color and count.
          repoTile(
            "assets/icons/issues.svg",
            "Issues",
            const Color(0xff33d058),
            repo.openIssuesCount ?? 0,
          ),

          /// BlocBuilder is used to listen to the state of the [RepositoryBloc]
          /// and based on the state, it will render the corresponding UI components
          /// using the repoTile widget for Pull requests.
          BlocBuilder<RepositoryBloc, RepositoryState>(
            builder: (context, state) {
              switch (state) {
                case RepositoryInitial():
                  return repoTile(
                    "assets/icons/pull-request.svg",
                    "Pull Requests",
                    const Color(0xff2189fe),
                    0,
                  );
                case RepositoryLoaded():
                  return repoTile(
                    "assets/icons/pull-request.svg",
                    "Pull Requests",
                    const Color(0xff2189fe),
                    context.watch<RepositoryBloc>().count,
                  );
                case RepositoryError():
                  return repoTile(
                    "assets/icons/pull-request.svg",
                    "Pull Requests",
                    const Color(0xff2189fe),
                    0,
                  );
              }
            },
          ),
          // Displaying the numbers of watchers and invoking the repoTile widget
          // with watchers icon, title, color and count.
          repoTile(
            "assets/icons/watchers.svg",
            "Watchers",
            const Color(0xffffd33c),
            repo.watchers ?? 0,
          ),
          // GestureDetector is used to handle the user's tap event and trigger
          // FetchCommits event with the given username and repo.
          GestureDetector(
            onTap: () {
              context.read<CommitBloc>().add(FetchCommits(
                    username: repo.owner?.login ?? "",
                    repo: repo.name ?? "",
                  ));
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CommitPage(repository: repo),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color(0xffeff0f5),
                    ),
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: Center(
                        child: SvgPicture.asset(
                          "assets/icons/commits.svg",
                          height: 25,
                          colorFilter: const ColorFilter.mode(Color(0xff414149), BlendMode.srcIn),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Commits",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget repoTile(String icon, String title, Color color, int count) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: color,
            ),
            child: SizedBox(
              height: 40,
              width: 40,
              child: Center(
                child: SvgPicture.asset(
                  icon,
                  height: 25,
                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(fontSize: 20),
          ),
          const Spacer(),
          Text(
            count.toString(),
            style: const TextStyle(fontSize: 20, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
