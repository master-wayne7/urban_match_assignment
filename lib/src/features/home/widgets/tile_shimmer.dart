import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

// TileShimmer is a StatelessWidget that displays a shimmering effect for a list
// tile. It is used to create a loading effect for a list tile, providing a
// visually appealing experience while the actual data is being fetched or loaded.
class TileShimmer extends StatelessWidget {
  // The constructor initializes the TileShimmer widget with no required parameters.
  const TileShimmer({super.key});

  // The build method returns a Padding widget that wraps the Shimmer widget.
  // The Padding widget provides vertical spacing between the list tiles.
  @override
  Widget build(BuildContext context) {
    return Padding(
      // The padding property sets the vertical spacing between the list tiles.
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Shimmer.fromColors(
        // The Shimmer widget creates a shimmering effect for the list tile.
        // The fromColors constructor allows the base color and highlight color to
        // be set, creating the shimmer effect.
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: true,
        child: Row(
          // The Row widget arranges the list tile's content horizontally in a row.
          children: [
            ClipRRect(
              // ClipRRect is a widget that clips its child using a rounded border.
              borderRadius: BorderRadius.circular(100),
              child: Container(
                // The Container widget holds a black-colored box representing the
                // user profile picture.
                height: 40,
                width: 40,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 10), // 10 logical pixels of horizontal spacing.
            Column(
              // The Column widget arranges the list tile's content vertically in a column.
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // The first Container widget in the Column represents the user
                  // display name.
                  decoration: BoxDecoration(
                    // The BoxDecoration widget defines the properties of the
                    // Container widget, such as border radius and color.
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.black,
                  ),
                  height: 15,
                  width: 100,
                ),
                const SizedBox(height: 10), // 10 logical pixels of vertical spacing.
                Container(
                  // The second Container widget in the Column represents the post
                  // title or the content description.
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.black,
                  ),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
