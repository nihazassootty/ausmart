import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:ausmart/Commons/AppConstants.dart';
import 'package:ausmart/Models/PopularModel.dart';

class PopularProvider extends ChangeNotifier {
  bool loading = true;
  int errorCode;

  PopularModel category = PopularModel();

  //* FETCH CATEGORY
  Future<PopularModel> fetchCategory() async {
    PopularModel result;
    FlutterSecureStorage storage = FlutterSecureStorage();
    final String token = await storage.read(key: "token");
    try {
      final Uri url = Uri.https(baseUrl, apiUrl + "/category/category-type");
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $token",
        'Accept': 'application/json',
      });
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        category = PopularModel.fromJson(data);
        loading = false;
      }
      if (response.statusCode == 404 || response.statusCode == 400) {
        errorCode = data["code"];
        loading = false;
      }
      notifyListeners();
    } catch (e) {
      print(e);
    }
    return result;
  }
}
