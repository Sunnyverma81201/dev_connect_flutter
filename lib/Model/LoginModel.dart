// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.token,
    required this.location,
    required this.profileImg,
  });

  String firstName;
  String lastName;
  String email;
  String token;
  String location;
  String? profileImg;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        token: json["token"],
        location: json["location"],
        profileImg: json["profile_img"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "token": token,
        "location": location,
        "profile_img": profileImg,
      };
}
