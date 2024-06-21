import 'package:collection/collection.dart';
import 'package:dotube/configs/configs.dart';
import 'package:spotify/spotify.dart';

enum ImagePlaceholder {
  artist,
}

extension DotubeImageExtensions on List<Image>? {
  String asUrlString({
    int index = 1,
    required ImagePlaceholder placeholder,
  }) {
    final String placeholderUrl = {
      ImagePlaceholder.artist: Assets.userPlaceholder.path,
    }[placeholder]!;

    final sortedImage = this?.sorted((a, b) => a.width!.compareTo(b.width!));

    return sortedImage != null && sortedImage.isNotEmpty
        ? sortedImage[index > sortedImage.length - 1 ? sortedImage.length - 1 : index].url!
        : placeholderUrl;
  }
}
