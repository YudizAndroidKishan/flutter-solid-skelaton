import 'dart:io';
import 'package:image_picker/image_picker.dart';

/// Abstract interface for image picking functionality.
abstract class ImagePickerUtil {
  Future<File?> pickImage();
}

/// A sample implementation using the image_picker package.
class ImagePickerUtilImpl implements ImagePickerUtil {
  final ImagePicker _picker = ImagePicker();

  @override
  Future<File?> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }
}
