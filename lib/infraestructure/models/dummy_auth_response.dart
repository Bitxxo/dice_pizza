// To parse this JSON data, do
//
//     final userResponse = userResponseFromJson(jsonString);

import 'dart:convert';

UserResponse userResponseFromJson(String str) =>
    UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
  final String accessToken;
  final String refreshToken;
  final int id;
  final String firstName;
  final String lastName;
  final String? maidenName;
  final int? age;
  final String gender;
  final String? email;
  final String? phone;
  final String username;
  final String password;
  final String birthDate;
  final String image;

  UserResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.id,
    required this.firstName,
    required this.lastName,
    this.maidenName,
    this.age,
    required this.gender,
    this.email,
    this.phone,
    required this.username,
    required this.password,
    required this.birthDate,
    required this.image,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        accessToken: json["accessToken"] ?? '',
        refreshToken: json["refreshToken"] ?? '',
        id: json["id"] ?? 0,
        firstName: json["firstName"] ?? '',
        lastName: json["lastName"] ?? '',
        maidenName: json["maidenName"] ?? '',
        age: json["age"] ?? 0,
        gender: json["gender"] ?? '',
        email: json["email"] ?? '',
        phone: json["phone"] ?? '',
        username: json["username"] ?? '',
        password: json["password"] ?? '',
        birthDate: json["birthDate"] ?? '',
        image: json["image"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "maidenName": maidenName,
        "age": age,
        "gender": gender,
        "email": email,
        "phone": phone,
        "username": username,
        "password": password,
        "birthDate": birthDate,
        "image": image,
      };
}
