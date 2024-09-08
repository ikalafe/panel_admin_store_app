import 'dart:convert';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pannel_admin_store_app/global_variable.dart';
import 'package:pannel_admin_store_app/models/subcategory.dart';
import 'package:http/http.dart' as http;
import 'package:pannel_admin_store_app/services/manage_http_response.dart';

class SubcategoryController {
  uploadSubcategory({
    required String categoryId,
    required String categoryName,
    required dynamic pickedImage,
    required String subCategoryName,
    required context,
  }) async {
    try {
      final cloudinary = CloudinaryPublic(
          dotenv.env['CLOUD_NAME']!, dotenv.env['PRESET_NAME']!);

      // Uploade Image
      CloudinaryResponse imageResponse = await cloudinary.uploadFile(
        CloudinaryFile.fromBytesData(
          pickedImage,
          identifier: 'pickedImage',
          folder: 'subcategoryImage',
        ),
      );

      String image = imageResponse.secureUrl;
      Subcategory subcategory = Subcategory(
        id: '',
        categoryId: categoryId,
        categoryName: categoryName,
        image: image,
        subCategoryName: subCategoryName,
      );
      http.Response response = await http.post(
        Uri.parse('$uri/api/subcategories'),
        body: subcategory.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'زیر مجموعه دسته بندی با موفقیت بارگزاری شد (:',
            backgroundColorSnackBar: Colors.green,
          );
        },
      );
    } catch (e) {
      debugPrint("در بارگزاری زیر مجموعه دسته بندی مشکلی پیش آمد: $e");
    }
  }

  Future<List<Subcategory>> loadSubcateogries() async {
    try {
      final response = await http.get(
        Uri.parse('$uri/api/subcategories'),
        headers: <String, String>{
          'Content-Type': 'applicaton/json; charset=UTF-8'
        },
      );
      debugPrint('زیر مجموعه دسته بندی ها: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        List<Subcategory> subcategories = data
            .map((subcategory) => Subcategory.fromJson(subcategory))
            .toList();
        return subcategories;
      } else {
        throw Exception('مشکلی در بارگزاری زیرمجموعه دسته بندی ها رخ داد ):');
      }
    } catch (e) {
      debugPrint('Error: $e');
      throw Exception('Error loading Subcategories: $e');
    }
  }
}
