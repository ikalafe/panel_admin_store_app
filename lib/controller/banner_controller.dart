import 'dart:convert';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pannel_admin_store_app/global_variable.dart';
import 'package:pannel_admin_store_app/models/banner.dart';
import 'package:http/http.dart' as http;
import 'package:pannel_admin_store_app/services/manage_http_response.dart';

class BannerController {
  uploadImage({required dynamic pickedImage, required context}) async {
    try {
      final cloudinary = CloudinaryPublic(
        dotenv.env['CLOUD_NAME']!,
        dotenv.env['PRESET_NAME']!,
      );
      CloudinaryResponse imageResponse = await cloudinary.uploadFile(
        CloudinaryFile.fromBytesData(pickedImage,
            identifier: 'pickedImage', folder: 'banners'),
      );
      String image = imageResponse.secureUrl;
      BannerModel bannerModel = BannerModel(id: '', image: image);
      http.Response response = await http.post(
        Uri.parse('$uri/api/banner'),
        body: bannerModel.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      manageHttpResponse(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(
              context,
              'بنر با موفقیت بارگزاری شد',
              backgroundColorSnackBar: Colors.green,
            );
          });
    } catch (e) {
      showSnackBar(
        context,
        'مشکلی در بارگزاری تصویر به وجود آمد ):',
      );
      debugPrint('Error Upload: $e');
    }
  }

  //Fetch banners
  Future<List<BannerModel>> loadBanners() async {
    try {
      // Send an http get request to fetch banners
      http.Response response = await http.get(
        Uri.parse('$uri/api/banner'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
      debugPrint(response.body);
      if (response.statusCode == 200) {
        //OK
        List<dynamic> data = jsonDecode(response.body);
        List<BannerModel> banners =
            data.map((banner) => BannerModel.fromJson(banner)).toList();
        return banners;
      } else {
        // throw an exception if the server responsed with an error status code
        throw Exception('Failed to load Banners');
      }
    } catch (e) {
      throw Exception('Error loading Banners: $e');
    }
  }
}
