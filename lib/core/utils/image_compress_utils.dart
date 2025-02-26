import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';

/// Abstract interface for image compression functionality.
abstract class ImageCompressUtil {
  /// Compresses the given [file] with an optional [quality] (0-100).
  /// Default value for [quality] is 80.
  /// Returns the compressed [XFile].
  Future<XFile?> compressImage(File file, {int quality = 80});
}

/// A sample implementation using flutter_image_compress.
class ImageCompressUtilImpl implements ImageCompressUtil {
  @override
  Future<XFile?> compressImage(
    File file, {
    int quality = 80,
  }) async {
    final filePath = file.absolute.path;
    final lastIndex = filePath.lastIndexOf('.');
    final targetPath =
        '${filePath.substring(0, lastIndex)}_compressed${filePath.substring(lastIndex)}';

    final result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: quality,
    );
    return result;
  }
}
