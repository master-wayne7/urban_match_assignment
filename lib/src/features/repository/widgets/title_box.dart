import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:urban_match/src/models/repository_model.dart';

/// A widget that displays a box containing information about a GitHub repository.
///
/// This widget is a custom `StatelessWidget` that takes a single required `repo`
/// property of type `GitHubRepo`, representing the repository to be displayed.
class TitleBox extends StatelessWidget {
  final GitHubRepo repo;

  /// Creates a new `TitleBox` widget.
  ///
  /// Requires a `repo` property of type `GitHubRepo`, which is the repository to
  /// be displayed in the box.
  const TitleBox({super.key, required this.repo});

  @override
  Widget build(BuildContext context) {
    // The box that contains the entire TitleBox widget.
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Color(0xfffbfbfb),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: 148,
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // A row containing the repository owner's avatar and login name.
              Row(
                children: [
                  // A clipped and rounded avatar image pulled from the owner's avatar URL.
                  SizedBox(
                    height: 25,
                    width: 25,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CachedNetworkImage(
                        imageUrl: repo.owner!.avatarUrl!,
                        placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                      ),
                    ),
                  ),
                  // A horizontal spacer between the avatar and the login name.
                  const SizedBox(width: 5),
                  // The login name of the repository owner, displayed in a grey text.
                  Text(
                    repo.owner?.login ?? "",
                    style: TextStyle(color: Colors.grey[600], fontSize: 16),
                  ),
                ],
              ),
              // A spacer between the row and the next text widget.
              const SizedBox(height: 10),
              // The name of the repository, displayed in a larger font and black text.
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  repo.name ?? "",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.w700),
                ),
              ),
              // A spacer between the repository name and the stats row.
              const SizedBox(height: 15),
              // A row containing the repository's stats, such as stars and forks.
              Row(
                children: [
                  // An icon for the star count, with a grey color.
                  const Icon(Icons.star_border, color: Colors.grey),
                  // A spacer between the star icon and the count.
                  const SizedBox(width: 3),
                  // The number of stars for the repository, displayed in grey text with a size of 18.
                  Text.rich(
                    TextSpan(
                      text: repo.stargazersCount.toString(),
                      children: const [
                        TextSpan(
                          text: " star",
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ],
                    ),
                    style: const TextStyle(fontSize: 18),
                  ),
                  // A spacer between the star and fork sections.
                  const SizedBox(width: 15),
                  SvgPicture.asset(
                    "assets/icons/git-fork.svg",
                    height: 20,
                    colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                  ),
                  const SizedBox(width: 4),
                  Text.rich(
                    TextSpan(
                      text: repo.forksCount.toString(),
                      children: const [
                        TextSpan(
                          text: " forks",
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ],
                    ),
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
