import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileImageProvider extends ChangeNotifier {
  XFile? _selectedImage;
  static const String _imagePathKey = "selectedImagePath";

  XFile? get selectedImage => _selectedImage;

  // pick image and save in the shared preference
  Future<void> uploadImage() async {
    try {
      final pickedImage = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (pickedImage != null) {
        _selectedImage = pickedImage;

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_imagePathKey, pickedImage.path);
        notifyListeners();
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  // load image from shared prefrence
  Future<void> loadImage() async {
    final prefs = await SharedPreferences.getInstance();
    final imagePath = prefs.getString(_imagePathKey);
    if (imagePath != null) {
      _selectedImage = XFile(imagePath);
      notifyListeners();
    }
  }
}
