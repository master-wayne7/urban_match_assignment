import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// This widget is shown when an exception occurs during the application's runtime.
/// It displays an error message along with an animated lottie file to provide visual feedback
/// to the user.
class ShowException extends StatelessWidget {
  /// The text to be displayed as the error message.
  final String text;

  /// The path to the lottie animation asset to be displayed.
  final String lottieAsset;

  /// Optional parameter to specify if the animation should be repeated or not.
  final bool? repeat;

  /// Constructs a ShowException widget with the given error message and lottie animation.
  const ShowException({
    super.key,
    required this.text,
    required this.lottieAsset,
    this.repeat,
  });

  @override
  Widget build(BuildContext context) {
    /// Builds the widget by returning a column with two children.
    /// The first child is the Lottie animation, and the second child is the error message.
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        LottieBuilder.asset(
          /// Loads the lottie animation from the specified asset path.
          /// Optionally repeats the animation if the [repeat] parameter is true.
          lottieAsset,
          repeat: repeat,
          height: 100,
          width: 100,
          fit: BoxFit.fill,
        ),
        Text(
          /// Displays the error message to the user.
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
