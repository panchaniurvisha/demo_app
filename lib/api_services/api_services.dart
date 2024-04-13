import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/user_model.dart';

class ApiService {
  Future<UserModel> fetchUserModel() async {
    final response = await http.get(Uri.parse(
        'https://miracocopepsi.com/admin/mayur/coc/raj/ios/roblox/json/boy.json'));

    if (response.statusCode == 200) {
      print('Get data : ${response.body}');
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load UserModel');
    }
  }
}
