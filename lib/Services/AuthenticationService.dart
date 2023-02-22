import 'dart:convert';

import 'package:dev_connect/Model/LoginModel.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<LoginModel?> loginUser(String email, String password) async {
    var client = http.Client();

    var uri = Uri.parse("${dotenv.env["BACKEND"]!}auth/login");
    Map<String, String> reqHeaders = {"Content-Type": "application/json"};
    String reqBody = jsonEncode({"email": email, "password": password});

    var response = await client.post(uri, headers: reqHeaders, body: reqBody);

    if (response.statusCode == 200) {
      var res = response.body;
      return loginModelFromJson(res);
    } else {
      return null;
    }
  }
}
