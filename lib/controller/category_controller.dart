import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CategoryController {
  uploadCategory({
    required dynamic pickedImage,
    required dynamic pickedBanner,
  }) async {
    try {
      final cloudinary = CloudinaryPublic(
          dotenv.env['CLOUD_NAME']!, dotenv.env['PRESET_NAME']!);

      // Uploade Image
      CloudinaryResponse imageResponse = await cloudinary.uploadFile(
        CloudinaryFile.fromBytesData(pickedImage,
            identifier: 'pickedImage', folder: 'categoryImages'),
      );
      debugPrint('اولیش: $imageResponse');

      CloudinaryResponse bannerResponse = await cloudinary.uploadFile(
        CloudinaryFile.fromBytesData(pickedBanner,
            identifier: 'pickedBanner', folder: 'categoryImages'),
      );
      debugPrint('دومیش: $bannerResponse');
    } catch (e) {
      debugPrint('Error Uploading to cloudinary: $e');
    }
  }
}
