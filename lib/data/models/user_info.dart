import 'dart:convert';

UserInfo userInfoFromJson(String str) => UserInfo.fromJson(json.decode(str));

String userInfoToJson(UserInfo data) => json.encode(data.toJson());

class UserInfo {
  int id;
  String username;
  String email;
  String firstName;
  String lastName;
  String image;

  UserInfo({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.image,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "firstName": firstName,
    "lastName": lastName,
    "image": image,
  };
}
