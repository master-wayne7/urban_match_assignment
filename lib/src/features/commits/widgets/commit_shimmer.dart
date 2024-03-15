import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// CommitShimmer class - a StatelessWidget that displays a shimmer widget
/// with a specific loading design.
class CommitShimmer extends StatelessWidget {
  /// Constructor for the CommitShimmer widget
  const CommitShimmer({super.key});

  /// The main build method of the widget. This method creates a Padding
  /// widget that wraps a Shimmer widget, which in turn wraps a Column
  /// widget containing a list of container widgets with various
  /// properties and decorations to create a shimmer effect.
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300, // Base color for the shimmer effect
        highlightColor: Colors.grey.shade100, // Highlight color for the shimmer effect
        enabled: true, // Enables the shimmer effect
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Aligns the child widgets
          // to the start of the cross axis
          children: [
            Container(
              decoration: BoxDecoration(
                // Container widget with a box decoration
                borderRadius: BorderRadius.circular(7), // Rounded border radius
                color: Colors.black, // Solid color for the container
              ),
              width: MediaQuery.of(context).size.width * 0.9, // Width of the container
              height: 20, // Height of the container
            ),
            const SizedBox(height: 5), // A spacer widget with a specified height
            Row(
              children: [
                ClipRRect(
                  // Container widget with a clipped border radius
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                    height: 25,
                    width: 25,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 5), // A spacer widget with a specified width
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Aligns the child widgets
                  // to the start of the cross axis
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        // Container widget with a box decoration
                        borderRadius: BorderRadius.circular(7), // Rounded border radius
                        color: Colors.black, // Solid color for the container
                      ),
                      height: 15, // Height of the container
                      width: 100, // Width of the container
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
