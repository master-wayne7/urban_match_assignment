import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urban_match/src/features/repository/bloc/repository_bloc.dart';
import 'package:urban_match/src/features/repository/pages/repository_page.dart';
import 'package:urban_match/src/models/repository_model.dart';

/// RepositoryTile is a widget that displays the repository's information with a clickable
/// avatar and title. On tap, it pushes the [RepositoryPage] with the given repository
/// details and fetches the pull request count for the repository using the [RepositoryBloc].
class RepositoryTile extends StatelessWidget {
  /// The repository object to display.
  final GitHubRepo repo;

  /// Constructor for wrapping [repo] with [RepositoryTile] widget.
  const RepositoryTile({
    super.key,
    required this.repo,
  });

  /// Builds the tile widget with the configured repository data.
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () {
          /// Adds an event to the [RepositoryBloc] to fetch the pull request count
          /// for the specified repository and username.
          context.read<RepositoryBloc>().add(
                FetchPRCount(
                  username: repo.owner?.login ?? "",
                  repo: repo.name ?? "",
                ),
              );

          /// Navigates to the [RepositoryPage] with the [repo] as a parameter.
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RepositoryPage(repo: repo),
            ),
          );
        },
        child: Row(
          children: [
            SizedBox(
              height: 40,
              width: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImage(
                  imageUrl: repo.owner!.avatarUrl!,
                  placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  repo.owner?.login ?? "",
                  style: TextStyle(color: Colors.grey[600]),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    repo.name ?? "",
                    style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
