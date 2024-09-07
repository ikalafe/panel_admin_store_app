import 'dart:convert';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pannel_admin_store_app/global_variable.dart';
import 'package:pannel_admin_store_app/models/category.dart';
import 'package:http/http.dart' as http;
import 'package:pannel_admin_store_app/services/manage_http_response.dart';

class CategoryController {
  uploadCategory({
    required dynamic pickedImage,
    required dynamic pickedBanner,
    required String name,
    required context,
  }) async {
    try {
      final cloudinary = CloudinaryPublic(
          dotenv.env['CLOUD_NAME']!, dotenv.env['PRESET_NAME']!);

      // Uploade Image
      CloudinaryResponse imageResponse = await cloudinary.uploadFile(
        CloudinaryFile.fromBytesData(pickedImage,
            identifier: 'pickedImage', folder: 'categoryImages'),
      );

      String image = imageResponse.secureUrl;

      CloudinaryResponse bannerResponse = await cloudinary.uploadFile(
        CloudinaryFile.fromBytesData(pickedBanner,
            identifier: 'pickedBanner', folder: 'categoryImages'),
      );
      String banner = bannerResponse.secureUrl;

      Category category = Category(
        id: '',
        name: name,
        image: image,
        banner: banner,
      );
      http.Response response = await http.post(
        Uri.parse("$uri/api/categories"),
        body: category.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'دسته بندی بارگزاری شد.');
        },
      );
    } catch (e) {
      debugPrint('Error Uploading to cloudinary: $e');
    }
  }

  // Load th uploaded categories
  Future<List<Category>> loadCategories() async {
    try {
      // Send an http get request to load the categories
      http.Response response = await http.get(
        Uri.parse('$uri/api/categories'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
      debugPrint(response.body);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        List<Category> categories =
            data.map((category) => Category.fromJson(category)).toList();
        return categories;
      } else {
        throw Exception('خطایی در بارگزاری دسته بندی ها به وجود آمد ):');
      }
    } catch (e) {
      throw Exception('Error Loading Categories $e');
    }
  }
}
