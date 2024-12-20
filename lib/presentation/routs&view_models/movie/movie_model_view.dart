import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_mobile_app/data/models/movie_model.dart';
import 'package:event_mobile_app/presentation/base/base_view_model.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/bloc_manage.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

import '../../bloc_state_managment/events.dart';

class MovieModelView extends BaseViewModel with MoviesModelViewFunctions {
  Color dominantColor = Colors.transparent;
  Color textColor = Colors.black;
  late EventsBloc bloc;

  late BuildContext context;
  final MovieResponse movie;

  MovieModelView({required this.movie, required this.context});

  @override
  void dispose() {}

  @override
  void start() {
    bloc = EventsBloc.get(context);

    extractDominantColor();
  }

  /// Determines the contrasting color for a given color based on brightness.
  /// The brightness calculation follows the standard luminance formula:
  /// brightness = 0.299 * red + 0.587 * green + 0.114 * blue.
  /// - If brightness is high (>0.5), the text color should be black (for readability).
  /// - Otherwise, the text color should be white.
  @override
  Color getContrastingColor(Color color) {
    // Calculate brightness using the luminance formula.
    double brightness =
        (0.299 * color.red + 0.587 * color.green + 0.114 * color.blue) / 255;

    // Return black text if brightness is high, otherwise return white text.
    return brightness > 0.5 ? Colors.black : Colors.white;
  }

  /// Extracts the dominant color from a specific region of the movie image.
  /// This function analyzes the image and retrieves the most prominent color
  /// from a defined region, which is then used to determine the text color contrast.
  @override
  Future<void> extractDominantColor() async {
    // Create an image provider for the movie's photo (loaded from a URL or cache).
    final imageProvider = CachedNetworkImageProvider(movie.photo!);

    // A completer is used here to get the dimensions of the image
    // because image loading is asynchronous, and dimensions aren't known immediately.
    final Completer<Size> completer = Completer();

    // Resolve the image and attach a listener to capture its dimensions.
    final ImageStream imageStream =
        imageProvider.resolve(const ImageConfiguration());
    imageStream.addListener(
      ImageStreamListener(
        (ImageInfo info, bool _) {
          // When the image is loaded, retrieve its width and height.
          completer.complete(
            Size(
              info.image.width.toDouble(),
              info.image.height.toDouble(),
            ),
          );
        },
      ),
    );

    // Wait for the image dimensions to be resolved.
    final imageSize = await completer.future;

    // Define the top and bottom boundaries of the region to analyze.
    // In this case, we are analyzing a slice from 65% to 70% of the image's height.
    final double regionTop = imageSize.height * 0.65;
    final double regionBottom = imageSize.height * 0.7;

    // Define the region of the image to analyze using a rectangular area.
    // - The region spans the full width of the image.
    // - The top and bottom are clamped to ensure they remail within the image's bounds.
    final region = Rect.fromLTRB(
      0, // Start at the very left (X-axis).
      regionTop.clamp(0, imageSize.height), // Clamp top boundary.
      imageSize.width, // Span the entire width of the image.
      regionBottom.clamp(0, imageSize.height), // Clamp bottom boundary.
    );

    // Generate a palette from the image's colors.
    // - The palette generator analyzes the specified region.
    // - The `size` parameter ensures proper scaling during analysis.
    final paletteGenerator = await PaletteGenerator.fromImageProvider(
      imageProvider,
      size: imageSize, // Use the image's full size for accuracy.
      region: region, // Analyze the defined region.
    );

    // Update the state with the extracted dominant color.
    // If a dominant color is found, use it; otherwise, default to black.
    dominantColor = paletteGenerator.dominantColor?.color ?? Colors.black;
    // Determine the contrasting text color for the dominant color.
    textColor = getContrastingColor(dominantColor);
    bloc.add(ExtractDominantColorEvent());
  }

  addFilmToFavEvent(MovieResponse movie) {
    bloc.add(AddFilmToFavEvent(movie));
  }

  removeFilmFromFavEvent(MovieResponse movie) {
    bloc.add(RemoveFilmFromFavEvent(movie));
  }
}

mixin MoviesModelViewFunctions {
  getContrastingColor(Color color);

  extractDominantColor();
}
