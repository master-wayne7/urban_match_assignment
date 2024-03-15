import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:urban_match/src/models/commit_model.dart';
import 'package:urban_match/src/services/app_services.dart';

/// Represents a single commit tile in the commit list view.
class CommitTile extends StatelessWidget {
  /// The commit to display.
  final GitHubCommit commit;

  /// Constructor that initializes the `CommitTile` widget with a commit.
  const CommitTile({super.key, required this.commit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row with the commit message and the date of the commit.
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Text displaying the commit message.
              Flexible(
                child: Text(
                  commit.commit?.message ?? "",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // Text displaying the date of the commit.
              Text(
                AppServices.formatTimeElapsed(commit.commit?.committer?.date ?? DateTime.now()),
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
          // Row with the avatar and the committer information.
          Row(
            children: [
              // ClipRRect with the committer avatar.
              SizedBox(
                height: 25,
                width: 25,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage(
                    imageUrl: commit.committer!.avatarUrl!,
                    placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                  ),
                ),
              ),
              const SizedBox(width: 5),
              // Text displaying the committer login.
              Text(
                commit.committer?.login ?? "",
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(width: 5),
              // Text displaying the "authored" tag if the committer is the same as the author.
              if (commit.committer?.login == commit.author?.login)
                Text(
                  "authored",
                  style: TextStyle(color: Colors.grey[500]),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
