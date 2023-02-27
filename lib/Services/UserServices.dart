import 'dart:convert';

import 'package:dev_connect/Model/ProjectModel.dart';
import 'package:dev_connect/Model/UserModel.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart' as http;

class UserServices {
  // Service to Retrieve User data and save it to local Storage
  Future<UserModel?> getUserData(String token) async {
    var client = http.Client();

    var uri = Uri.parse("${dotenv.env['BACKEND']!}user/getUser");
    Map<String, String> reqHeaders = {
      "Content-Type": "application/json",
      "auth": token.toString()
    };

    var response = await client.get(uri, headers: reqHeaders);

    if (response.statusCode == 200) {
      var res = response.body;
      return userModelFromJson(res);
    } else {
      return null;
    }
  }

  Future<List<ProjectModel>?> getUserProjects(String token) async {
    var client = http.Client();

    var uri = Uri.parse("${dotenv.env['BACKEND']!}user/getCreatedPrjects");
    Map<String, String> reqHeaders = {
      "Content-Type": "application/json",
      "auth": token.toString()
    };

    var response = await client.get(uri, headers: reqHeaders);

    if (response.statusCode == 200) {
      var res = response.body;
      List<dynamic> projects = JsonDecoder().convert(res.toString());
      List<ProjectModel> prj = [];

      for (var project in projects) {
        prj.add(projectModelFromJson(JsonEncoder().convert(project)));
      }

      // print("$prj");

      return prj;
    } else {
      return null;
    }
  }
}
