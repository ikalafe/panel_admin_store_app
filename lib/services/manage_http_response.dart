import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void manageHttpResponse({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  // swich statement to handle different http status code
  switch (response.statusCode) {
    case 200: // Status code 200 indicates a successfull request
      onSuccess();
      break;
    case 400: // Status code 400 indicates a bad request
      showSnackBar(context, json.decode(response.body)['msg']);
      break;
    case 500: // Status code 500 indicates a internal server error
      showSnackBar(context, "مشکلی پیش آمد لطفا بعدا دوباره امتحان کنید");
      break;
    case 202: // Status code 201 indicates a resource has been created successfully
      onSuccess();
      break;
  }
}

void showSnackBar(BuildContext context, String title) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(title)));
}
